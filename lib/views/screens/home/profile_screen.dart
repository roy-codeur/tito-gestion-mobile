import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startkit_app/core/routes/app_routes.dart';
import 'package:startkit_app/views/widgets/bottom_navigation_bar.dart';

class _C {
  static const bg      = Color(0xFF0B0E14);
  static const surface = Color(0xFF13171F);
  static const card    = Color(0xFF1C2540);
  static const accent  = Color(0xFF4F7EFF);
  static const border  = Color(0x1AFFFFFF);
  static const textHi  = Colors.white;
  static const textMid = Color(0x99FFFFFF);
  static const textLow = Color(0x50FFFFFF);
  static const success = Color(0xFF3DBE7A);
  static const danger  = Color(0xFFE24B4A);
}

// ─── Page ─────────────────────────────────────────────────────────────────────
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static String _fmt(int v) => v.toString()
      .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]} ');

  @override
  Widget build(BuildContext context) {
    const totalCredit = 180000;
    const paid        = 45000;
    const remaining   = totalCredit - paid;
    final pct         = paid / totalCredit;

    return Scaffold(
      backgroundColor: _C.bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _C.bg,
        title: const Text(
          'Mon profil',
          style: TextStyle(
            color: _C.textHi,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined,
                color: _C.textLow, size: 20),
            onPressed: () {},
          ),
        ],
      ),
     
   
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Avatar + identité ─────────────────────────────────────────
            Center(
              child: Column(
                children: [
                  Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(
                      color: _C.card,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: _C.accent.withOpacity(.35), width: 2),
                    ),
                    child: const Center(
                      child: Text('K',
                          style: TextStyle(
                            color: _C.accent,
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Kossi',
                      style: TextStyle(
                        color: _C.textHi,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                      )),
                  const SizedBox(height: 4),
                  const Text('Client PayTrack',
                      style: TextStyle(
                          color: _C.textLow, fontSize: 13)),
                  const SizedBox(height: 12),
                  // Arriérés badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: _C.danger.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: _C.danger.withOpacity(.2), width: 0.5),
                    ),
                    child: const Text('Arriérés : 25 000 FCFA',
                        style: TextStyle(
                          color: _C.danger,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Progression crédit ────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _C.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _C.border, width: 0.5),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Progression du crédit',
                          style: TextStyle(
                            color: _C.textHi,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          )),
                      Text('${(pct * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: _C.accent,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: pct,
                      minHeight: 7,
                      backgroundColor: _C.card,
                      color: _C.accent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _MiniStat(
                        label: 'Remboursé',
                        value: '${_fmt(paid)} FCFA',
                        color: _C.success,
                      )),
                      const SizedBox(width: 10),
                      Expanded(child: _MiniStat(
                        label: 'Restant',
                        value: '${_fmt(remaining)} FCFA',
                        color: _C.danger,
                      )),
                      const SizedBox(width: 10),
                      Expanded(child: _MiniStat(
                        label: 'Total',
                        value: '${_fmt(totalCredit)} FCFA',
                        color: _C.textMid,
                      )),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Informations personnelles ─────────────────────────────────
            const _SectionLabel('Informations'),
            const SizedBox(height: 10),
            _InfoSection(rows: const [
              _InfoRow(label: 'Téléphone',    value: '+228 90 00 00 00'),
              _InfoRow(label: 'Moto',         value: 'Haojue 125'),
              _InfoRow(label: 'Membre depuis', value: 'Janv. 2026'),
            ]),

            const SizedBox(height: 24),

            // ── Paramètres ────────────────────────────────────────────────
            const _SectionLabel('Paramètres'),
            const SizedBox(height: 10),
            _SettingTile(
              icon: Icons.notifications_outlined,
              label: 'Notifications',
              onTap: () {},
            ),
            _SettingTile(
              icon: Icons.lock_outline_rounded,
              label: 'Changer le mot de passe',
              onTap: () {},
            ),
            _SettingTile(
              icon: Icons.help_outline_rounded,
              label: 'Aide & support',
              onTap: () {},
            ),

            const SizedBox(height: 16),

            // ── Déconnexion ───────────────────────────────────────────────
            GestureDetector(
              onTap: () => _confirmLogout(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: _C.danger.withOpacity(.07),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: _C.danger.withOpacity(.2), width: 0.5),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Se déconnecter',
                        style: TextStyle(
                          color: _C.danger,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        )),
                    Icon(Icons.logout_rounded,
                        color: _C.danger, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF13171F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: _C.border,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Se déconnecter ?',
                style: TextStyle(
                  color: _C.textHi,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 8),
            const Text(
              'Vous devrez vous reconnecter pour accéder à votre compte.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _C.textLow, fontSize: 13),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: _C.border, width: 0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Annuler',
                        style: TextStyle(color: _C.textMid)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.offAllNamed(AppRoutes.login);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _C.danger,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Déconnecter',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// ─── Widgets ──────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: _C.textLow,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      );
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MiniStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: _C.textLow, fontSize: 10)),
        const SizedBox(height: 3),
        Text(value,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}

class _InfoRow {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});
}

class _InfoSection extends StatelessWidget {
  final List<_InfoRow> rows;
  const _InfoSection({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _C.border, width: 0.5),
      ),
      child: Column(
        children: List.generate(rows.length, (i) {
          final row = rows[i];
          final isLast = i == rows.length - 1;
          return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: isLast
                  ? null
                  : const Border(
                      bottom: BorderSide(color: _C.border, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(row.label,
                    style: const TextStyle(
                        color: _C.textLow, fontSize: 13)),
                Text(row.value,
                    style: const TextStyle(
                      color: _C.textHi,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SettingTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: _C.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _C.border, width: 0.5),
        ),
        child: Row(
          children: [
            Icon(icon, color: _C.textLow, size: 18),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label,
                  style: const TextStyle(
                    color: _C.textHi,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: _C.textLow, size: 13),
          ],
        ),
      ),
    );
  }
}