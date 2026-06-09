part of com.app_track_ota_labs.app.core.providers;

class AppProvider with ChangeNotifier {
  AppProvider() {
    Supabase.instance.client.auth.onAuthStateChange.listen((AuthState data) {
      notifyListeners();
    });
  }
  bool get isLoggedIn => Supabase.instance.client.auth.currentSession != null;
  User? get user => Supabase.instance.client.auth.currentUser;

  final List<AppModel> _apps = <AppModel>[
    AppModel(
      id: '1',
      name: 'SocialSphere',
      description: 'Social media management tool',
      bundleId: 'com.social.sphere',
      icon: '',
      color: Colors.white,
      platform: <String>['iOS'],
      status: 'Live',
      developPlatform: '1.2M Active Users',
      version: '1.0.0',
    ),
    AppModel(
      id: '2',
      name: 'FinTrack',
      description: 'Personal finance tracker',
      bundleId: 'com.finance.tracker',
      icon: '',
      color: Colors.blue,
      platform: <String>['Android'],
      status: 'In Review',
      developPlatform: 'Last updated: 2 days ago',
      version: '1.0.0',
    ),
    AppModel(
      id: '3',
      name: 'TaskFlow',
      description: 'Project management app',
      bundleId: 'com.task.flow',
      icon: '',
      color: Colors.green,
      platform: <String>['Web'],
      status: 'Live',
      developPlatform: '980k Active Users',
      version: '1.0.0',
    ),
    AppModel(
      id: '4',
      name: 'Project Phoenix',
      description: 'Social media management tool',
      bundleId: 'com.project.phoenix',
      icon: '',
      color: Colors.green,
      platform: <String>['iOS'],
      status: 'Draft',
      developPlatform: 'Created: 1 week ago',
      version: '1.0.0',
    ),
  ];

  List<AppModel> get apps => _apps;

  Future<void> login(String email, String password) async {
    await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout(BuildContext context) async {
    if (context.mounted) {
      showSuccessSnackBar(context, 'Logout successfully');
    }
    await Supabase.instance.client.auth.signOut();
  }

  void addApp(AppModel app) {
    _apps.add(app);
    notifyListeners();
  }

  void deleteApp(String id) {
    _apps.removeWhere((AppModel app) => app.id == id);
    notifyListeners();
  }
}
