part of com.app_track_ota_labs.app.widgets;

class StatsCard extends StatelessWidget {
  const StatsCard({required this.title, required this.value, super.key});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: BpColors.surfaceContainerLow,
      border: Border.all(color: BpColors.outline.withAlpha(50), width: 1),
    ),
    child: Row(
      children: <Widget>[
        Container(width: 2, height: 40, color: BpColors.primaryContainer),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: GoogleFonts.jetBrainsMono(
                color: BpColors.textDim,
                fontSize: 9,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.jetBrainsMono(
                fontWeight: FontWeight.w800,
                fontSize: 32,
                color: BpColors.primaryContainer,
                letterSpacing: -1,
                height: 1.1,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: BpColors.primaryContainer.withAlpha(80),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.apps_outlined,
            color: BpColors.primaryContainer,
            size: 20,
          ),
        ),
      ],
    ),
  );
}
