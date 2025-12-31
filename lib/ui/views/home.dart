part of com.app_track_ota_labs.app.views;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 2,
    child: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'App Track',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Provider.of<AppProvider>(
                  context,
                  listen: false,
                ).logout(context);
              },
            ),
            const SizedBox(width: 16),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: const TabBarView(
          children: <Widget>[DashboardView(), SettingsView()],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: SizedBox(
            height: 60,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  dividerColor: Colors.transparent,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                  tabs: const <Widget>[
                    Tab(icon: Icon(Icons.home_rounded), text: 'Inicio'),
                    Tab(icon: Icon(Icons.settings_rounded), text: 'Ajustes'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
