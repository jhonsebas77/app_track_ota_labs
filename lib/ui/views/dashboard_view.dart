part of com.app_track_ota_labs.app.views;

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  static const String route = '/dashboard';

  @override
  Widget build(BuildContext context) => GridBackground(
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildStats(context)
              .animate()
              .fadeIn(duration: 500.ms, delay: 100.ms)
              .slideY(
                begin: -0.1,
                end: 0,
                duration: 400.ms,
                curve: Curves.easeOut,
              ),
          const SizedBox(height: 16),
          _buildNewAppButton(context)
              .animate()
              .fadeIn(duration: 500.ms, delay: 200.ms),
          const SizedBox(height: 32),
          _buildSectionHeader(context)
              .animate()
              .fadeIn(duration: 500.ms, delay: 300.ms),
          const SizedBox(height: 16),
          _buildAppList(context)
              .animate()
              .fadeIn(duration: 500.ms, delay: 400.ms),
        ],
      ),
    ),
  );

  Widget _buildStats(BuildContext context) => StatsCard(
    title: 'TOTAL_APPLICATIONS',
    value: Provider.of<AppProvider>(context).apps.length.toString(),
  );

  Widget _buildNewAppButton(BuildContext context) => SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () {
        CustomNavigator().push(
          context,
          const AddApplicationScreen(),
          animation: CustomNavigationAnimation.slideBottom,
        );
      },
      icon: const Icon(Icons.add, size: 16, color: BpColors.onPrimaryFixed),
      label: Text(
        'NEW_APPLICATION',
        style: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.5,
          color: BpColors.onPrimaryFixed,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: BpColors.primaryContainer,
        foregroundColor: BpColors.onPrimaryFixed,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        side: const BorderSide(color: BpColors.primaryContainer, width: 1),
      ),
    ),
  );

  Widget _buildSectionHeader(BuildContext context) => Row(
    children: <Widget>[
      Container(width: 2, height: 16, color: BpColors.primaryContainer),
      const SizedBox(width: 8),
      Text(
        'MY_APPLICATIONS',
        style: GoogleFonts.jetBrainsMono(
          color: BpColors.textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
        ),
      ),
      const Spacer(),
      GestureDetector(
        onTap: () {
          CustomNavigator().push(
            context,
            const MyApplicationsScreen(),
            animation: CustomNavigationAnimation.fade,
          );
        },
        child: Row(
          children: <Widget>[
            Text(
              'VIEW_ALL',
              style: GoogleFonts.jetBrainsMono(
                color: BpColors.primaryContainer,
                fontSize: 9,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_forward_ios,
              size: 10,
              color: BpColors.primaryContainer,
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildAppList(BuildContext context) => FutureBuilder<List<AppModel>>(
    future: fetchAllApps(),
    builder: (BuildContext context, AsyncSnapshot<List<AppModel>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 48),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              color: BpColors.primaryContainer,
            ),
          ),
        );
      }
      if (snapshot.hasError) {
        if (context.mounted) {
          showErrorSnackBar(context, 'Error with fetchAllApps');
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Center(
            child: Text(
              'ERR: ${snapshot.error}',
              style: GoogleFonts.jetBrainsMono(
                color: BpColors.error,
                fontSize: 10,
                letterSpacing: 0.5,
              ),
            ),
          ),
        );
      }
      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: Center(
            child: Column(
              children: <Widget>[
                const Icon(
                  Icons.inbox_outlined,
                  color: BpColors.textDim,
                  size: 32,
                ),
                const SizedBox(height: 12),
                Text(
                  'NO_APPLICATIONS_REGISTERED',
                  style: GoogleFonts.jetBrainsMono(
                    color: BpColors.textDim,
                    fontSize: 9,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      List<AppModel> apps = snapshot.data!;
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: apps.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (BuildContext context, int index) =>
            DashboardCard(app: apps[index]),
      );
    },
  );
}
