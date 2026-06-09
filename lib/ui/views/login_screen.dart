part of com.app_track_ota_labs.app.views;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController(
    text: 'jhonsebas77.otalabs@gmail.com',
  );
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  bool _obscureText = true;
  bool _isLoading = false;
  String? _errorMsg;

  TextStyle _label({
    Color color = BpColors.textDim,
    double size = 10,
    double spacing = 1.5,
    FontWeight weight = FontWeight.w500,
  }) => GoogleFonts.jetBrainsMono(
    color: color,
    fontSize: size,
    letterSpacing: spacing,
    fontWeight: weight,
    height: 1.2,
  );

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMsg = null;
    });

    AppProvider provider = Provider.of<AppProvider>(context, listen: false);

    await HapticFeedback.mediumImpact();

    try {
      await provider.login(_emailController.text, _passwordController.text);
      if (mounted) {
        showSuccessSnackBar(context, 'Login successfully');
      }
    } on AuthException catch (e) {
      if (mounted) {
        setState(() => _errorMsg = e.message);
        if (context.mounted) {
          showErrorSnackBar(context, 'Usuario o contraseña erróneo');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _errorMsg = 'ERR: UNEXPECTED_FAILURE');
        if (context.mounted) {
          showErrorSnackBar(context, 'An unexpected error has occurred');
        }
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: BpColors.background,
    body: GridBackground(
      child: Stack(
        children: <Widget>[
          const ScanlineOverlay(),
          const Positioned.fill(
            child: IgnorePointer(child: CornerBrackets(size: 28, inset: 24)),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                _buildHeader(),
                Expanded(child: _buildBody()),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildHeader() =>
      Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: BpColors.primaryContainer,
                        width: 2,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'SYSTEM_STATUS',
                        style: _label(size: 9, spacing: 1.5),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: <Widget>[
                          _PulseDot(),
                          const SizedBox(width: 6),
                          Text(
                            'OPERATIONAL',
                            style: _label(
                              color: BpColors.success,
                              size: 10,
                              spacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Ref_ID: MCS_77-X',
                      style: _label(size: 9, spacing: 0.5),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'COORD: 40.7128° N',
                      style: _label(size: 9, spacing: 0.5),
                    ),
                  ],
                ),
              ],
            ),
          )
          .animate()
          .fadeIn(duration: 600.ms, delay: 100.ms)
          .slideY(begin: -0.3, end: 0, duration: 600.ms, curve: Curves.easeOut);

  Widget _buildBody() => SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 32),
    child: Column(
      children: <Widget>[
        const SizedBox(height: 16),
        _buildLogoCluster()
            .animate()
            .fadeIn(duration: 700.ms, delay: 200.ms)
            .scale(
              begin: const Offset(0.9, 0.9),
              end: const Offset(1, 1),
              duration: 700.ms,
              curve: Curves.easeOut,
            ),
        const SizedBox(height: 24),
        _buildTitle().animate().fadeIn(duration: 500.ms, delay: 400.ms),
        const SizedBox(height: 40),
        _buildForm()
            .animate()
            .fadeIn(duration: 500.ms, delay: 550.ms)
            .slideY(
              begin: 0.2,
              end: 0,
              duration: 500.ms,
              curve: Curves.easeOut,
            ),
        const SizedBox(height: 24),
      ],
    ),
  );

  Widget _buildLogoCluster() => SchematicRing(
    size: 128,
    child: Container(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
        color: BpColors.background,
        border: Border.all(color: BpColors.outline.withAlpha(60), width: 1),
      ),
      child: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.modulate),
        child: Image.asset('assets/logo_ota.png', fit: BoxFit.contain),
      ),
    ),
  );

  Widget _buildTitle() => Column(
    children: <Widget>[
      Text(
        'OTA_SYS',
        style: GoogleFonts.jetBrainsMono(
          color: BpColors.primaryContainer,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          height: 1.1,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        'v1.0.42 // SYSTEM_VERSION_CONTROL',
        style: _label(size: 9, spacing: 1),
      ),
    ],
  );

  Widget _buildForm() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          const Icon(Icons.lock_outline, color: BpColors.textDim, size: 14),
          const SizedBox(width: 8),
          Text('AUTHENTICATION_PROTOCOL', style: _label(size: 10, spacing: 2)),
          const Spacer(),
          Text('ENCRYPTED_AES_256', style: _label(size: 8, spacing: 0.5)),
        ],
      ),
      const SizedBox(height: 16),
      _buildUserDisplay(),
      const SizedBox(height: 16),
      Text('SECURE_CREDENTIAL', style: _label(size: 9, spacing: 1.5)),
      const SizedBox(height: 8),
      _buildPasswordInput(),
      if (_errorMsg != null) ...<Widget>[
        const SizedBox(height: 8),
        Text(
          _errorMsg!,
          style: _label(color: BpColors.error, size: 9, spacing: 0.5),
        ),
      ],
      const SizedBox(height: 20),
      _buildActionButton(),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.help_outline,
                  color: BpColors.textDim,
                  size: 13,
                ),
                const SizedBox(width: 4),
                Text(
                  'FORGOT_CREDENTIALS',
                  style: _label(size: 9, spacing: 0.5),
                ),
              ],
            ),
          ),
          Text('Term_01', style: _label(size: 9, spacing: 0.5)),
        ],
      ),
    ],
  );

  Widget _buildUserDisplay() => Container(
    decoration: BoxDecoration(
      border: Border.all(color: BpColors.outline.withAlpha(40), width: 1),
      color: BpColors.surfaceContainerLow,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      children: <Widget>[
        const Icon(
          Icons.person_outline,
          color: BpColors.primaryContainer,
          size: 16,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('SYSTEM_USER', style: _label(size: 8, spacing: 1.5)),
            const SizedBox(height: 2),
            Text(
              _emailController.text,
              style: _label(
                color: BpColors.textPrimary,
                size: 11,
                spacing: 0.3,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildPasswordInput() => Stack(
    clipBehavior: Clip.none,
    children: <Widget>[
      TextField(
        controller: _passwordController,
        focusNode: _passwordFocus,
        obscureText: _obscureText,
        style: GoogleFonts.jetBrainsMono(
          color: BpColors.textPrimary,
          fontSize: 13,
          letterSpacing: 4,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'INPUT_PASSWORD',
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 12, right: 8),
            child: Icon(
              Icons.terminal,
              color: BpColors.primaryContainer,
              size: 18,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 44),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 16,
              color: BpColors.textDim,
            ),
            onPressed: () => setState(() => _obscureText = !_obscureText),
          ),
        ),
        onChanged: (_) {
          if (_errorMsg != null) setState(() => _errorMsg = null);
        },
        onSubmitted: (_) => _login(),
        textInputAction: TextInputAction.go,
      ),
      Positioned(
        right: -12,
        top: 0,
        child: Column(
          children: <Widget>[
            Container(
              width: 1,
              height: 24,
              color: BpColors.outline.withAlpha(80),
            ),
            Container(
              width: 10,
              height: 1,
              color: BpColors.outline.withAlpha(80),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildActionButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: _isLoading ? null : _login,
      style: ElevatedButton.styleFrom(
        backgroundColor: BpColors.primaryContainer,
        foregroundColor: BpColors.onPrimaryFixed,
        disabledBackgroundColor: BpColors.primaryContainer.withAlpha(120),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        side: const BorderSide(color: BpColors.primaryContainer, width: 1),
      ),
      child: _isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: BpColors.onPrimaryFixed,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'AUTHENTICATING...',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.5,
                    color: BpColors.onPrimaryFixed,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'AUTHENTICATE',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.5,
                    color: BpColors.onPrimaryFixed,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.bolt,
                  size: 16,
                  color: BpColors.onPrimaryFixed,
                ),
              ],
            ),
    ),
  );

  Widget _buildFooter() =>
      Container(
            decoration: const BoxDecoration(
              color: BpColors.surfaceContainerLow,
              border: Border(
                top: BorderSide(color: BpColors.outlineVariant, width: 1),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'LEGAL_PROTOCOL',
                            style: _label(
                              color: BpColors.primaryContainer,
                              size: 9,
                              spacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '''©2024 OTA_SYSTEM. ALL RIGHTS RESERVED.\nSECURE ACCESS SCHEMA REQUIRED.''',
                            style: _label(size: 8, spacing: 0.3),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Row(
                      children: <Widget>[
                        _FooterIcon(icon: Icons.shield_outlined),
                        SizedBox(width: 8),
                        _FooterIcon(icon: Icons.language_outlined),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const DiagnosticStrip(),
              ],
            ),
          )
          .animate()
          .fadeIn(duration: 500.ms, delay: 700.ms)
          .slideY(begin: 0.3, end: 0, duration: 500.ms, curve: Curves.easeOut);
}

class _PulseDot extends StatefulWidget {
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _ctrl,
    builder: (_, __) => Opacity(
      opacity: 0.4 + 0.6 * _ctrl.value,
      child: Container(width: 6, height: 6, color: BpColors.success),
    ),
  );
}

class _FooterIcon extends StatelessWidget {
  const _FooterIcon({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(
      border: Border.all(color: BpColors.outline.withAlpha(80), width: 1),
    ),
    child: Icon(icon, size: 15, color: BpColors.textDim),
  );
}
