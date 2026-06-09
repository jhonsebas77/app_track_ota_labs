import 'package:app_track_ota_labs/core/models/models.dart';
import 'package:app_track_ota_labs/core/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppProvider Tests', () {
    test('Initial state is logged out', () {
      AppProvider provider = AppProvider();
      expect(provider.isLoggedIn, false);
    });

    test('Login with correct password works', () {
      AppProvider provider = AppProvider()
        ..login('test@yopmail.com', 'password123');
      expect(provider.isLoggedIn, true);
    });

    test('Login with incorrect password fails', () {
      AppProvider provider = AppProvider()
        ..login('test@yopmail.com', 'wrongPassword');
      expect(provider.isLoggedIn, false);
    });

    test('Add App works', () {
      AppProvider provider = AppProvider();
      int initialCount = provider.apps.length;
      AppModel newApp = AppModel(
        id: 'test',
        name: 'Test App',
        description: 'Test',
        bundleId: 'com.test',
        icon: '',
        color: Colors.red,
        platform: <String>['iOS'],
        version: '1.0.0',
      );
      provider.addApp(newApp);
      expect(provider.apps.length, initialCount + 1);
      expect(provider.apps.last.name, 'Test App');
    });

    test('Delete App works', () {
      AppProvider provider = AppProvider();
      AppModel appToDelete = provider.apps.first;
      provider.deleteApp(appToDelete.id);
      expect(provider.apps.contains(appToDelete), false);
    });
  });
}
