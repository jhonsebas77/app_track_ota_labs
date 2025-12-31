part of com.app_track_ota_labs.app.core.providers;

final SupabaseClient supabase = Supabase.instance.client;
Future<List<AppModel>> fetchAllApps() async {
  try {
    PostgrestList response = await supabase
        .schema('app_track')
        .from('all_apps')
        .select()
        .order('created_at', ascending: false);
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response);
    return data.map(AppModel.fromMap).toList();
  } catch (e) {
    debugPrint('Error detallado: $e');
    return <AppModel>[];
  }
}
