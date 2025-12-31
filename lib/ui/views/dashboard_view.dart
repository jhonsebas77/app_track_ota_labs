part of com.app_track_ota_labs.app.views;

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  static const String route = '/dashboard';

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: StatsCard(
                title: 'Total Applications',
                // TODO(SebastianOtalora): Replace by the real value
                value: Provider.of<AppProvider>(context).apps.length.toString(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  CustomNavigator().push(
                    context,
                    const AddApplicationScreen(),
                    animation: CustomNavigationAnimation.slideBottom,
                  );
                },
                icon: const Icon(Icons.add_circle, color: Colors.white),
                label: const Text('New App'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'My Applications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                CustomNavigator().push(
                  context,
                  const MyApplicationsScreen(),
                  animation: CustomNavigationAnimation.fade,
                );
              },
              child: const Text(
                'View All',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: FutureBuilder<List<AppModel>>(
            future: fetchAllApps(),
            builder:
                (BuildContext context, AsyncSnapshot<List<AppModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    if (context.mounted) {
                      showErrorSnackBar(context, 'Error with fetchAllApps');
                    }
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No hay aplicaciones registradas.'),
                    );
                  }

                  List<AppModel> apps = snapshot.data!;

                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: apps.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (BuildContext context, int index) {
                      AppModel app = apps[index];
                      return DashboardCard(app: app);
                    },
                  );
                },
          ),
        ),
      ],
    ),
  );
}
