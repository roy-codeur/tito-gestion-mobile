import 'package:flutter/material.dart';
import 'package:startkit_app/views/widgets/bottom_navigation_bar.dart';

// ─── Design tokens (cohérent avec login_page.dart) ───────────────────────────
class _C {
  static const bg      = Color(0xFF0B0E14);
  static const surface = Color(0xFF13171F);
  static const card    = Color(0xFF1C2540);
  static const accent  = Color(0xFF4F7EFF);
  static const border  = Color(0x1AFFFFFF);
  static const textHi  = Colors.white;
  static const textMid = Color(0x99FFFFFF);
  static const textLow = Color(0x50FFFFFF);
  static const danger  = Color(0xFFE24B4A);
  static const success = Color(0xFF3DBE7A);
  static const orange  = Color(0xFFFF8C42);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,

      // ── AppBar ──────────────────────────────────────────────────────────────
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _C.bg,
        title: const Text(
          'PayTrack',
          style: TextStyle(
            color: _C.textHi,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          // Streak badge
          Container(
            margin: const EdgeInsets.only(right: 4),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _C.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _C.border, width: 0.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.local_fire_department,
                    color: _C.orange, size: 16),
                SizedBox(width: 4),
                Text(
                  '9',
                  style: TextStyle(
                    color: _C.textHi,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Notifications
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 4),
            child: IconButton(
              icon: const Icon(Icons.notifications_outlined,
                  color: _C.textMid, size: 22),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),

      // ── Body ────────────────────────────────────────────────────────────────
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Profil card ─────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _C.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _C.border, width: 0.5),
              ),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _C.card,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: _C.accent.withOpacity(.3), width: 1.5),
                    ),
                    child: const Icon(Icons.person_outline_rounded,
                        color: _C.accent, size: 22),
                  ),
                  const SizedBox(width: 14),

                  // Infos
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Kossi',
                          style: TextStyle(
                            color: _C.textHi,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Moto : Haojue 125',
                          style: TextStyle(
                              color: _C.textMid, fontSize: 13),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: _C.danger.withOpacity(.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Arriérés : 25 000 FCFA',
                            style: TextStyle(
                              color: _C.danger,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(Icons.arrow_forward_ios,
                      size: 14, color: _C.textLow),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Streak banner ────────────────────────────────────────────────
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: _C.orange.withOpacity(.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: _C.orange.withOpacity(.2), width: 0.5),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_fire_department,
                      color: _C.orange, size: 22),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      '9 jours de paiement consécutifs',
                      style: TextStyle(
                        color: _C.textHi,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _C.orange.withOpacity(.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Bravo !',
                      style: TextStyle(
                        color: _C.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Activités ────────────────────────────────────────────────────
            _SectionHeader(title: 'Activités', onSeeAll: () {}),
            const SizedBox(height: 12),

            _ActivityCard(
              title: 'Création crédit',
              date: '12 Mars 2026',
              icon: Icons.add_card_outlined,
              iconColor: _C.accent,
            ),
            _ActivityCard(
              title: 'Vidange',
              date: '10 Mars 2026',
              icon: Icons.build_outlined,
              iconColor: _C.success,
            ),

            const SizedBox(height: 28),

            // ── Historique paiements ─────────────────────────────────────────
            _SectionHeader(title: 'Historique paiements', onSeeAll: () {}),
            const SizedBox(height: 12),

            _PaymentCard(amount: '5 000 FCFA', date: '15 Mars'),
            _PaymentCard(amount: '5 000 FCFA', date: '10 Mars'),
          ],
        ),
      ),

      // ── Bottom nav ──────────────────────────────────────────────────────────
     
      
    );
  }
}

// ─── Section header ───────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const _SectionHeader({required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _C.textHi,
            fontWeight: FontWeight.w600,
            fontSize: 15,
            letterSpacing: -0.2,
          ),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: const Text(
              'Voir tout',
              style: TextStyle(
                color: _C.accent,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}


// ─── Activity card ────────────────────────────────────────────────────────────
class _ActivityCard extends StatelessWidget {
  final String title;
  final String date;
  final IconData icon;
  final Color iconColor;

  const _ActivityCard({
    required this.title,
    required this.date,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _C.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: _C.textHi,
                        fontWeight: FontWeight.w500,
                        fontSize: 14)),
                const SizedBox(height: 3),
                Text(date,
                    style: const TextStyle(
                        color: _C.textLow, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios,
              size: 13, color: _C.textLow),
        ],
      ),
    );
  }
}

// ─── Payment card ─────────────────────────────────────────────────────────────
class _PaymentCard extends StatelessWidget {
  final String amount;
  final String date;

  const _PaymentCard({
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _C.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _C.success.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.payments_outlined,
                color: _C.success, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              amount,
              style: const TextStyle(
                color: _C.textHi,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _C.success.withOpacity(.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              date,
              style: const TextStyle(
                color: _C.success,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}