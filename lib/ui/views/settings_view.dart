part of com.app_track_ota_labs.app.views;

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) => GridBackground(
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionLabel('SYSTEM_CONFIG'),
          const SizedBox(height: 12),
          const VersionWidget(),
          const SizedBox(height: 32),
          _buildSectionLabel('SESSION'),
          const SizedBox(height: 12),
          _buildLogoutTile(context),
          const SizedBox(height: 32),
          _buildSectionLabel('BUILD_INFO'),
          const SizedBox(height: 12),
          _buildInfoRow('ENVIRONMENT', 'PRODUCTION'),
          _buildDivider(),
          _buildInfoRow('PLATFORM', 'FLUTTER'),
          _buildDivider(),
          _buildInfoRow('THEME', 'BLUEPRINT_DARK_v1'),
        ],
      ),
    ),
  );

  Widget _buildSectionLabel(String label) => Row(
    children: <Widget>[
      Container(width: 2, height: 14, color: BpColors.primaryContainer),
      const SizedBox(width: 8),
      Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          color: BpColors.textDim,
          fontSize: 9,
          letterSpacing: 2,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );

  Widget _buildLogoutTile(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: BpColors.surfaceContainerLow,
      border: Border.all(color: BpColors.outline.withAlpha(50), width: 1),
    ),
    child: ListTile(
      onTap: () =>
          Provider.of<AppProvider>(context, listen: false).logout(context),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: const Icon(
        Icons.logout,
        color: BpColors.error,
        size: 18,
      ),
      title: Text(
        'CLOSE_SESSION',
        style: GoogleFonts.jetBrainsMono(
          color: BpColors.error,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
        color: BpColors.textDim,
      ),
    ),
  );

  Widget _buildInfoRow(String key, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          key,
          style: GoogleFonts.jetBrainsMono(
            color: BpColors.textDim,
            fontSize: 10,
            letterSpacing: 1,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.jetBrainsMono(
            color: BpColors.textPrimary,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ),
  );

  Widget _buildDivider() => Container(
    height: 1,
    color: BpColors.outlineVariant.withAlpha(80),
  );
}
