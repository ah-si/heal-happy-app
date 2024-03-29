import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final adminUsersStoreProvider = ChangeNotifierProvider((_) => AdminUsersStore());

class SearchQuery {
  final String query;
  final String? job;
  final UserTypeEnum? type;
  final bool? canDoFaceToFace;
  final bool? isActivated;
  final bool? isVerified;

  SearchQuery(
    this.query,
    this.type,
    this.job,
    this.isActivated,
    this.isVerified,
    this.canDoFaceToFace,
  );
}

class SearchResults {
  final List<User> users;
  final int totalPages;
  final int currentPage;
  final ErrorResultException? error;

  SearchResults(this.users, this.currentPage, this.totalPages, {this.error});
}

class AdminUsersStore extends ChangeNotifier {
  final AdminApi _adminApi;
  SearchResults? searchResults;
  late SearchQuery _lastSearchQuery;
  bool isLoading = false;

  AdminUsersStore({AdminApi? adminApi}) : _adminApi = BackendApiProvider().api.getAdminApi();

  Future<void> search(int page, {SearchQuery? query}) async {
    query ??= _lastSearchQuery;
    isLoading = true;
    notifyListeners();
    try {
      final results = await _adminApi.searchUsers(
        isActivated: query.isActivated,
        isVerified: query.isVerified,
        canDoFaceToFace: query.canDoFaceToFace,
        query: query.query,
        job: query.job,
        type: query.type,
        page: page,
      );
      searchResults = SearchResults(results.data!.users.toList(), page, results.data!.totalPages);
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      searchResults = SearchResults([], page, 0, error: handleError(error, stackTrace));
      isLoading = false;
      notifyListeners();
    }
    _lastSearchQuery = query;
  }

  Future<void> validateHealer(User healer, bool isVerified) async {
    await _adminApi.verifyUser(verifyRequest: VerifyRequest((b) {
      b.isVerified = isVerified;
    }), id: healer.id!);
    await search(searchResults!.currentPage);
    notifyListeners();
  }

  Future<void> blockUser(User user, bool isBlocked) async {
    await _adminApi.blockUser(blockRequest: BlockRequest((b) {
      b.isBlocked = isBlocked;
    }), id: user.id!);
    await search(searchResults!.currentPage);
    notifyListeners();
  }

  Future<void> saveHealer(User healer) async {
    await _adminApi.updateUser(id: healer.id!, user: healer);
    await search(searchResults!.currentPage);
    notifyListeners();
  }

  Future<void> deleteHealer(User healer) async {
    await _adminApi.deleteUser(id: healer.id!);
    searchResults = SearchResults(searchResults!.users..remove(healer), searchResults!.currentPage, searchResults!.totalPages);
    notifyListeners();
  }

  Future<void> deleteUser(User user) async {
    await _adminApi.deleteUser(id: user.id!);
    searchResults = SearchResults(searchResults!.users..remove(user), searchResults!.currentPage, searchResults!.totalPages);
    notifyListeners();
  }
}
