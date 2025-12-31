part of com.app_track_ota_labs.app.widgets;

class DetailedCard extends StatelessWidget {
  const DetailedCard({required this.app, super.key});

  final AppModel app;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 16),
    child: ListTile(
      contentPadding: const EdgeInsets.all(16),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          'assets/apps/${app.iconApp}.png',
          height: 50,
          width: 50,
          fit: BoxFit.fill,
        ),
      ),
      title: Text(
        '${app.name} (${app.bundleId}) | ${app.version}',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 4),
          Text(
            '${app.description} | ${app.platform}',
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
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
