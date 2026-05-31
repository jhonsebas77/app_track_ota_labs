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
        backgroundColor: BpColors.background,
        appBar: AppBar(
          backgroundColor: BpColors.surfaceContainerLow,
          elevation: 0,
          shape: const Border(
            bottom: BorderSide(color: BpColors.outlineVariant, width: 1),
          ),
          title: Text(
            'APP_TRACK',
            style: GoogleFonts.jetBrainsMono(
              color: BpColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: BpColors.textDim,
                size: 18,
              ),
              onPressed: () {
                Provider.of<AppProvider>(
                  context,
                  listen: false,
                ).logout(context);
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: const TabBarView(
          children: <Widget>[DashboardView(), SettingsView()],
        ),
        bottomNavigationBar: DecoratedBox(
          decoration: const BoxDecoration(
            color: BpColors.surfaceContainerLow,
            border: Border(
              top: BorderSide(color: BpColors.outlineVariant, width: 1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            child: TabBar(
              indicatorColor: BpColors.primaryContainer,
              indicatorWeight: 2,
              labelColor: BpColors.primaryContainer,
              unselectedLabelColor: BpColors.textDim,
              dividerColor: Colors.transparent,
              labelStyle: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
              unselectedLabelStyle: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
              tabs: const <Widget>[
                Tab(icon: Icon(Icons.home_rounded), text: 'INICIO'),
                Tab(icon: Icon(Icons.settings_rounded), text: 'AJUSTES'),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
