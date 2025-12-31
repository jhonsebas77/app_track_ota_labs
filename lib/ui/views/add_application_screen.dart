part of com.app_track_ota_labs.app.views;

class AddApplicationScreen extends StatefulWidget {
  const AddApplicationScreen({super.key});

  @override
  State<AddApplicationScreen> createState() => _AddApplicationScreenState();
}

class _AddApplicationScreenState extends State<AddApplicationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bundleIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<String> _selectedPlatform = <String>['iOS'];

  void _saveApp() {
    if (_nameController.text.isEmpty || _bundleIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    AppModel newApp = AppModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Simple unique ID
      name: _nameController.text,
      description: _descriptionController.text,
      bundleId: _bundleIdController.text,
      icon: 'Icons.apps', // Default icon
      color: Colors.blue, // Default color
      platform: _selectedPlatform,
      status: 'Draft',
      developPlatform: 'Flutter',
      version: '1.0.0',
    );

    // Provider.of<AppProvider>(context, listen: false).addApp(newApp);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text(
          'Cancel',
          style: TextStyle(color: Colors.blue, fontSize: 16),
        ),
      ),
      leadingWidth: 80,
      title: const Text(
        'New Application',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        TextButton(
          onPressed: _saveApp,
          child: const Text(
            'Save',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          const Text(
            'App Icon',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),

          // App Icon Upload Mock
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A).withOpacity(0.5),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.3),
                  width: 1,
                  style: BorderStyle.solid,
                ), // Dashed border not easy in native, using solid or custom painter. Sticking to solid for MVP.
                borderRadius: BorderRadius.circular(16),
              ),
              // To simulate dashed border, we'd use a CustomPainter, but for speed, let's use a solid border or an image asset.
              // Actually let's just make it look good.
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.cloud_upload, color: Colors.blue, size: 32),
                  SizedBox(height: 8),
                  Text('Upload Icon', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Name
          const Text(
            'Application Name',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'My Awesome App'),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 24),

          // Bundle ID
          const Text(
            'Bundle Identifier',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _bundleIdController,
            decoration: const InputDecoration(hintText: 'com.company.appname'),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 24),

          // Description
          const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              hintText: 'A short summary of what this app does',
            ),
            maxLines: 4,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 24),

          // Platform
          const Text(
            'Platform',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          // Custom Segmented Control-ish look
          DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: <String>['iOS', 'Android', 'Web'].map((
                String platform,
              ) {
                bool isSelected = _selectedPlatform == <String>[platform];
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPlatform = <String>[platform];
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF334155)
                            : Colors.transparent, // Lighter slate for selected
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        platform,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ),
  );
}
