part of com.app_track_ota_labs.app.widgets;

class DashboardCard extends StatelessWidget {
  const DashboardCard({required this.app, super.key});

  final AppModel app;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(16),
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.all(16),
      leading: Image.asset(
        'assets/apps/${app.iconApp}.png',
        height: 50,
        width: 50,
        fit: BoxFit.fill,
      ),
      title: Text(
        app.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        app.description,
        style: TextStyle(color: Colors.grey[400], fontSize: 14),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: app.status == 'Live'
              ? Colors.green.withOpacity(0.2)
              : (app.status == 'Draft'
                    ? Colors.grey.withOpacity(0.2)
                    : Colors.amber.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          app.status,
          style: TextStyle(
            color: app.status == 'Live'
                ? Colors.green
                : (app.status == 'Draft' ? Colors.grey : Colors.amber),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
