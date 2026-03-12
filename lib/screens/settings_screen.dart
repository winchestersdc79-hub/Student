import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkTheme = true;
  bool _isRussian = true;
  bool _isPinEnabled = false;
  String _selectedAccent = 'purple';

  final _accents = [
    {'name': 'purple', 'color': const Color(0xFF9B59B6), 'label': '💜 Фиолетовый'},
    {'name': 'blue', 'color': const Color(0xFF2980B9), 'label': '💙 Синий'},
    {'name': 'green', 'color': const Color(0xFF27AE60), 'label': '💚 Зелёный'},
    {'name': 'red', 'color': const Color(0xFFE74C3C), 'label': '❤️ Красный'},
    {'name': 'orange', 'color': const Color(0xFFF39C12), 'label': '🧡 Оранжевый'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D1A),
        title: Text(
          _isRussian ? '⚙️ Настройки' : '⚙️ Settings',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(_isRussian ? 'Внешний вид' : 'Appearance'),
            _buildSwitchTile(
              icon: Icons.dark_mode,
              title: _isRussian ? 'Тёмная тема' : 'Dark theme',
              subtitle: _isRussian ? 'Тёмный фон приложения' : 'Dark background',
              value: _isDarkTheme,
              onChanged: (v) => setState(() => _isDarkTheme = v),
            ),
            const SizedBox(height: 8),
            _buildSection(_isRussian ? 'Цвет акцента' : 'Accent color'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: _accents.map((a) {
                final isSelected = _selectedAccent == a['name'];
                return GestureDetector(
                  onTap: () => setState(() => _selectedAccent = a['name'] as String),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (a['color'] as Color).withOpacity(0.2)
                          : const Color(0xFF16213E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? a['color'] as Color : Colors.white12,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      a['label'] as String,
                      style: TextStyle(
                        color: isSelected ? a['color'] as Color : Colors.white54,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            _buildSection(_isRussian ? 'Язык' : 'Language'),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildLangButton('🇷🇺 Русский', true),
                const SizedBox(width: 12),
                _buildLangButton('🇬🇧 English', false),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(_isRussian ? 'Безопасность' : 'Security'),
            _buildSwitchTile(
              icon: Icons.lock,
              title: _isRussian ? 'Пин-код' : 'PIN code',
              subtitle: _isRussian ? 'Защита приложения' : 'App protection',
              value: _isPinEnabled,
              onChanged: (v) {
                if (v) {
                  _showPinSetup();
                } else {
                  setState(() => _isPinEnabled = false);
                }
              },
            ),
            const SizedBox(height: 24),
            _buildSection(_isRussian ? 'О приложении' : 'About'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF16213E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _isRussian ? 'Версия' : 'Version',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const Text(
                        'v1.4.0',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _isRussian ? 'Разработчик' : 'Developer',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const Text(
                        'winchestersdc79-hub',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _isRussian ? 'Платформа' : 'Platform',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const Text(
                        'Flutter',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF9B59B6)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white)),
                Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF9B59B6),
          ),
        ],
      ),
    );
  }

  Widget _buildLangButton(String label, bool isRussian) {
    final isSelected = _isRussian == isRussian;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _isRussian = isRussian),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF9B59B6).withOpacity(0.2)
                : const Color(0xFF16213E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF9B59B6) : Colors.white12,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? const Color(0xFF9B59B6) : Colors.white54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  void _showPinSetup() {
    final pinController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF16213E),
        title: Text(
          _isRussian ? 'Установить пин-код' : 'Set PIN code',
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: pinController,
          keyboardType: TextInputType.number,
          maxLength: 4,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: _isRussian ? '4 цифры' : '4 digits',
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: const Color(0xFF0D0D1A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              _isRussian ? 'Отмена' : 'Cancel',
              style: const TextStyle(color: Colors.white54),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (pinController.text.length == 4) {
                setState(() => _isPinEnabled = true);
                Navigator.pop(ctx);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9B59B6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              _isRussian ? 'Сохранить' : 'Save',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
