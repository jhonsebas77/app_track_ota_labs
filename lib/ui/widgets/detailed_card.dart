part of com.app_track_ota_labs.app.widgets;

class DetailedCard extends StatelessWidget {
  const DetailedCard({required this.app, super.key});

  final AppModel app;

  Color _statusColor() {
    switch (app.status) {
      case 'Live':
        return BpColors.success;
      case 'Draft':
        return BpColors.textDim;
      default:
        return BpColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: BpColors.surfaceContainerLow,
      border: Border.all(color: BpColors.outline.withAlpha(50), width: 1),
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.all(14),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: BpColors.background,
          border: Border.all(
            color: BpColors.outline.withAlpha(60),
            width: 1,
          ),
        ),
        child: Image.asset(
          'assets/apps/${app.iconApp}.png',
          height: 48,
          width: 48,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        app.name,
        style: GoogleFonts.jetBrainsMono(
          fontWeight: FontWeight.w700,
          fontSize: 13,
          color: BpColors.textPrimary,
          letterSpacing: 0.5,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 4),
          Text(
            '${app.bundleId}  //  v${app.version}',
            style: GoogleFonts.jetBrainsMono(
              color: BpColors.primaryContainer,
              fontSize: 9,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${app.platform.join(', ')}  ·  ${app.description}',
            style: GoogleFonts.jetBrainsMono(
              color: BpColors.textDim,
              fontSize: 9,
              letterSpacing: 0.3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _statusColor().withAlpha(25),
          border: Border.all(
            color: _statusColor().withAlpha(100),
            width: 1,
          ),
        ),
        child: Text(
          app.status.toUpperCase(),
          style: GoogleFonts.jetBrainsMono(
            color: _statusColor(),
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ),
    ),
  );
}
