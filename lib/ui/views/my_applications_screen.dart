part of com.app_track_ota_labs.app.views;

class MyApplicationsScreen extends StatelessWidget {
  const MyApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: BpColors.background,
    appBar: AppBar(
      backgroundColor: BpColors.surfaceContainerLow,
      elevation: 0,
      shape: const Border(
        bottom: BorderSide(color: BpColors.outlineVariant, width: 1),
      ),
      title: Text(
        'MY_APPLICATIONS',
        style: GoogleFonts.jetBrainsMono(
          color: BpColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.5,
        ),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: BpColors.textDim),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search, color: BpColors.textDim, size: 18),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    ),
    body: GridBackground(
      child: Consumer<AppProvider>(
        builder: (BuildContext context, AppProvider provider, Widget? child) {
          if (provider.apps.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(
                    Icons.inbox_outlined,
                    color: BpColors.textDim,
                    size: 40,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'NO_APPLICATIONS_REGISTERED',
                    style: GoogleFonts.jetBrainsMono(
                      color: BpColors.textDim,
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: provider.apps.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (BuildContext context, int index) =>
                DetailedCard(app: provider.apps[index]),
          );
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
      backgroundColor: BpColors.primaryContainer,
      foregroundColor: BpColors.onPrimaryFixed,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: const Icon(Icons.add),
    ),
  );
}
