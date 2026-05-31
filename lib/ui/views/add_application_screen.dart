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

  TextStyle _fieldLabel() => GoogleFonts.jetBrainsMono(
    color: BpColors.textDim,
    fontSize: 9,
    letterSpacing: 2,
    fontWeight: FontWeight.w500,
  );

  void _saveApp() {
    if (_nameController.text.isEmpty || _bundleIdController.text.isEmpty) {
      showErrorSnackBar(context, 'ERR: NAME and BUNDLE_ID are required');
      return;
    }

    // Provider.of<AppProvider>(context, listen: false).addApp(AppModel(
    //   id: DateTime.now().millisecondsSinceEpoch.toString(),
    //   name: _nameController.text,
    //   description: _descriptionController.text,
    //   bundleId: _bundleIdController.text,
    //   icon: 'Icons.apps',
    //   color: Colors.blue,
    //   platform: _selectedPlatform,
    //   status: 'Draft',
    //   developPlatform: 'Flutter',
    //   version: '1.0.0',
    // ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bundleIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: BpColors.background,
    appBar: AppBar(
      backgroundColor: BpColors.surfaceContainerLow,
      elevation: 0,
      shape: const Border(
        bottom: BorderSide(color: BpColors.outlineVariant, width: 1),
      ),
      leading: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          'CANCEL',
          style: GoogleFonts.jetBrainsMono(
            color: BpColors.textDim,
            fontSize: 10,
            letterSpacing: 1,
          ),
        ),
      ),
      leadingWidth: 88,
      title: Text(
        'NEW_APPLICATION',
        style: GoogleFonts.jetBrainsMono(
          color: BpColors.textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        TextButton(
          onPressed: _saveApp,
          child: Text(
            'SAVE',
            style: GoogleFonts.jetBrainsMono(
              color: BpColors.primaryContainer,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    ),
    body: GridBackground(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Icon upload
            _buildSectionLabel('APP_ICON'),
            const SizedBox(height: 12),
            _buildIconUpload(),
            const SizedBox(height: 32),

            // Name
            _buildSectionLabel('APPLICATION_NAME'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _nameController,
              hint: 'INPUT_APP_NAME',
              icon: Icons.label_outline,
            ),
            const SizedBox(height: 24),

            // Bundle ID
            _buildSectionLabel('BUNDLE_IDENTIFIER'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _bundleIdController,
              hint: 'com.company.appname',
              icon: Icons.fingerprint,
            ),
            const SizedBox(height: 24),

            // Description
            _buildSectionLabel('DESCRIPTION'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _descriptionController,
              hint: 'INPUT_BRIEF_DESCRIPTION',
              icon: Icons.notes_outlined,
              maxLines: 4,
            ),
            const SizedBox(height: 24),

            // Platform
            _buildSectionLabel('TARGET_PLATFORM'),
            const SizedBox(height: 8),
            _buildPlatformSelector(),
            const SizedBox(height: 32),

            // Save button
            _buildSaveButton(),
          ],
        ),
      ),
    ),
  );

  Widget _buildSectionLabel(String label) => Row(
    children: <Widget>[
      Container(width: 2, height: 12, color: BpColors.primaryContainer),
      const SizedBox(width: 8),
      Text(label, style: _fieldLabel()),
    ],
  );

  Widget _buildIconUpload() => Center(
    child: Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          width: 112,
          height: 112,
          decoration: BoxDecoration(
            color: BpColors.surfaceContainerLow,
            border: Border.all(
              color: BpColors.primaryContainer.withAlpha(80),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.cloud_upload_outlined,
                color: BpColors.primaryContainer,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                'UPLOAD_ICON',
                style: GoogleFonts.jetBrainsMono(
                  color: BpColors.primaryContainer,
                  fontSize: 8,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Corner decorations
        Positioned(
          top: -4,
          left: -4,
          child: Container(width: 8, height: 8,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: BpColors.primaryContainer, width: 1),
                  left: BorderSide(color: BpColors.primaryContainer, width: 1),
                ),
                color: BpColors.background,
              )),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: Container(width: 8, height: 8,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: BpColors.primaryContainer, width: 1),
                  right: BorderSide(color: BpColors.primaryContainer, width: 1),
                ),
                color: BpColors.background,
              )),
        ),
        Positioned(
          bottom: -4,
          left: -4,
          child: Container(width: 8, height: 8,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: BpColors.primaryContainer, width: 1),
                  left: BorderSide(color: BpColors.primaryContainer, width: 1),
                ),
                color: BpColors.background,
              )),
        ),
        Positioned(
          bottom: -4,
          right: -4,
          child: Container(width: 8, height: 8,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: BpColors.primaryContainer, width: 1),
                  right: BorderSide(color: BpColors.primaryContainer, width: 1),
                ),
                color: BpColors.background,
              )),
        ),
      ],
    ),
  );

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) => TextField(
    controller: controller,
    maxLines: maxLines,
    style: GoogleFonts.jetBrainsMono(
      color: BpColors.textPrimary,
      fontSize: 12,
      letterSpacing: 0.5,
    ),
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: maxLines == 1
          ? Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Icon(icon, color: BpColors.primaryContainer, size: 16),
            )
          : null,
      prefixIconConstraints: const BoxConstraints(minWidth: 44),
    ),
  );

  Widget _buildPlatformSelector() => DecoratedBox(
    decoration: BoxDecoration(
      color: BpColors.surfaceContainerLow,
      border: Border.all(color: BpColors.outline.withAlpha(50), width: 1),
    ),
    child: Row(
      children: <String>['iOS', 'Android', 'Web'].map((String platform) {
        bool isSelected = _selectedPlatform.contains(platform);
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedPlatform = <String>[platform]),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: isSelected
                    ? BpColors.primaryContainer
                    : Colors.transparent,
                border: isSelected
                    ? null
                    : Border(
                        right: platform != 'Web'
                            ? BorderSide(
                                color: BpColors.outline.withAlpha(50),
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
              ),
              alignment: Alignment.center,
              child: Text(
                platform.toUpperCase(),
                style: GoogleFonts.jetBrainsMono(
                  color: isSelected
                      ? BpColors.onPrimaryFixed
                      : BpColors.textDim,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );

  Widget _buildSaveButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: _saveApp,
      style: ElevatedButton.styleFrom(
        backgroundColor: BpColors.primaryContainer,
        foregroundColor: BpColors.onPrimaryFixed,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        side: const BorderSide(color: BpColors.primaryContainer, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'REGISTER_APPLICATION',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.5,
              color: BpColors.onPrimaryFixed,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.bolt, size: 16, color: BpColors.onPrimaryFixed),
        ],
      ),
    ),
  );
}
