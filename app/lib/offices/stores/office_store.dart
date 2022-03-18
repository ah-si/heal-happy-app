import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final officeStoreProvider = ChangeNotifierProvider.family<OfficeStore, OfficeInfo>((_, data) => OfficeStore(id: data.id, office: data.office));

class OfficeInfo {
  final String id;
  final Office? office;

  OfficeInfo(this.id, this.office);
}

class OfficeResult {
  final Office? office;
  final ErrorResultException? error;

  OfficeResult(this.office, {this.error});
}

class OfficePlaningResult {
  final List<UserEvent> events;
  final ErrorResultException? error;

  OfficePlaningResult(this.events, {this.error});
}

enum OfficeTabs { home, planing }

class OfficeStore extends ChangeNotifier {
  final OfficesApi _officesApi;
  final String id;
  OfficeTabs _selectedTab = OfficeTabs.home;
  OfficeTabs get selectedTab => _selectedTab;

  set selectedTab(OfficeTabs value) {
    if (_selectedTab != value) {
      _selectedTab = value;
      notifyListeners();
    }
  }

  OfficeResult? result;
  OfficePlaningResult? planingResult;

  OfficeStore({required this.id, Office? office, OfficesApi? officesApi})
      : _officesApi = officesApi ?? BackendApiProvider().api.getOfficesApi(),
        result = OfficeResult(office);

  void loadOffice({bool force = false}) async {
    try {
      if (result == null || force) {
        final resultsRequest = await _officesApi.getOffice(id: id);
        result = OfficeResult(resultsRequest.data);
        notifyListeners();
      }
    } catch (error, stackTrace) {
      result = OfficeResult(null, error: handleError(error, stackTrace));
      notifyListeners();
    }
  }

  void loadPlaning() async {
    final results = await _officesApi.getOfficeEvents(id: id);
    try {
      planingResult = OfficePlaningResult(results.data!.toList());
      notifyListeners();
    } catch (error, stackTrace) {
      planingResult = OfficePlaningResult([], error: handleError(error, stackTrace));
      notifyListeners();
    }
  }

  Future<void> addRoom(String name) async{
    await _officesApi.addRoom(id: id, officeRoom: OfficeRoom((b) {
      b.name = name;
      b.officeId = id;
    }));
    loadOffice(force: true);
  }

  Future<void> deleteRoom(String id) async{
    await _officesApi.deleteRoom(id: id);
    loadOffice(force: true);
  }

  Future<void> updateRoom(String id, String name) async{
    await _officesApi.updateRoom(id: id, officeRoom: OfficeRoom((b) {
      b.id = id;
      b.name = name;
      b.officeId = id;
    }));
    loadOffice(force: true);
  }

  Future<void> addManager(String email) async{
    await _officesApi.addManager(id: id, userEmail: UserEmail((b) {
      b.email = email;
    }));
    loadOffice(force: true);
  }

  Future<void> removeManager(String userId) async{
    await _officesApi.removeManager(id: id, managerId: userId);
    loadOffice(force: true);
  }

  Future<void> addHealer(String roomId, String email) async{
    await _officesApi.addHealerToRoom(id: roomId, userEmail: UserEmail((b) {
      b.email = email;
    }));
    loadOffice(force: true);
  }

  Future<void> removeHealer(String roomId, String userId) async{
    await _officesApi.removeHealerFromRoom(id: roomId, healerId: userId);
    loadOffice(force: true);
  }
}
