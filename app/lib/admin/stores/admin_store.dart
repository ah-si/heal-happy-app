import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminStoreProvider = ChangeNotifierProvider((_) => AdminStore());

enum HomeTabs { home, users, healerStats, profile }

class AdminStore extends ChangeNotifier {
  HomeTabs _selectedTab = HomeTabs.home;

  AdminStore();

  HomeTabs get selectedTab => _selectedTab;

  set selectedTab(HomeTabs value) {
    if (_selectedTab != value) {
      _selectedTab = value;
      notifyListeners();
    }
  }

}
