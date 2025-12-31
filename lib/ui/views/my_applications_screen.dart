part of com.app_track_ota_labs.app.views;

class MyApplicationsScreen extends StatelessWidget {
  const MyApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'My Applications',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      ],
    ),
    body: Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider provider, Widget? child) =>
          ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: provider.apps.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 16),
            itemBuilder: (BuildContext context, int index) {
              AppModel app = provider.apps[index];
              return DetailedCard(app: app);
            },
          ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        CustomNavigator().push(
          context,
          const AddApplicationScreen(),
          animation: CustomNavigationAnimation.slideBottom,
        );
      },
      backgroundColor: const Color(0xFF2563EB),
      child: const Icon(Icons.add),
    ),
  );
}
