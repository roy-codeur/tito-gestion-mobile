import 'package:flutter/material.dart';
import 'package:startkit_app/views/widgets/bottom_navigation_bar.dart';

class _C {
  static const bg      = Color(0xFF0B0E14);
  static const surface = Color(0xFF13171F);
  static const card    = Color(0xFF1C2540);
  static const accent  = Color(0xFF4F7EFF);
  static const border  = Color(0x1AFFFFFF);
  static const textHi  = Colors.white;
  static const textLow = Color(0x50FFFFFF);
  static const success = Color(0xFF3DBE7A);
  static const orange  = Color(0xFFFF8C42);
}

enum ActivityType { credit, maintenance, payment, other }

class ActivityEntry {
  final String title;
  final String date;
  final String subtitle;
  final ActivityType type;
  final String badge;

  const ActivityEntry({
    required this.title,
    required this.date,
    required this.subtitle,
    required this.type,
    required this.badge,
  });
}

// ─── Page ─────────────────────────────────────────────────────────────────────
class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  static const _recent = [
    ActivityEntry(
      title: 'Vidange effectuée',
      date: '10 Mars 2026',
      subtitle: 'Entretien courant · Haojue 125',
      type: ActivityType.maintenance,
      badge: 'Entretien',
    ),
    ActivityEntry(
      title: 'Création du crédit',
      date: '12 Janv 2026',
      subtitle: 'Crédit moto approuvé',
      type: ActivityType.credit,
      badge: 'Validé',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _C.bg,
        title: const Text(
          'Activité',
          style: TextStyle(
            color: _C.textHi,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: _C.textLow, size: 22),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── KPIs ────────────────────────────────────────────────────────
            Row(
              children: [
                Expanded(child: _KpiCard(
                  label: 'Activités ce mois',
                  value: '3',
                  icon: Icons.bolt_outlined,
                  iconColor: _C.accent,
                )),
                const SizedBox(width: 12),
                Expanded(child: _KpiCard(
                  label: 'Jours consécutifs',
                  value: '9',
                  icon: Icons.local_fire_department,
                  iconColor: _C.orange,
                  suffix: '🔥',
                )),
              ],
            ),

            const SizedBox(height: 24),

            // ── Crédit actif ────────────────────────────────────────────────
            const _SectionLabel('En cours'),
            const SizedBox(height: 10),
            _CreditCard(
              label: 'Crédit moto actif',
              sub: 'Haojue 125 · Début janv. 2026',
              paid: 45000,
              total: 180000,
            ),

            const SizedBox(height: 24),

            // ── Streak banner ───────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('9 jours consécutifs',
                            style: TextStyle(
                              color: _C.textHi,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            )),
                        SizedBox(height: 2),
                        Text('Continuez comme ça !',
                            style: TextStyle(
                                color: _C.orange, fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _C.orange.withOpacity(.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Bravo !',
                        style: TextStyle(
                          color: _C.orange,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Activités récentes ──────────────────────────────────────────
            const _SectionLabel('Récent'),
            const SizedBox(height: 10),
            ..._recent.map((e) => _ActivityTile(entry: e)),
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
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: _C.textLow,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final String? suffix;

  const _KpiCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _C.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(height: 8),
          Text(
            suffix != null ? '$value $suffix' : value,
            style: const TextStyle(
              color: _C.textHi,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 3),
          Text(label,
              style: const TextStyle(color: _C.textLow, fontSize: 11)),
        ],
      ),
    );
  }
}

class _CreditCard extends StatelessWidget {
  final String label;
  final String sub;
  final int paid;
  final int total;

  const _CreditCard({
    required this.label,
    required this.sub,
    required this.paid,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final pct = paid / total;
    final fmt = (int v) => v.toString()
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]} ');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: const BorderSide(color: _C.accent, width: 2),
          top: BorderSide(color: _C.border, width: 0.5),
          right: BorderSide(color: _C.border, width: 0.5),
          bottom: BorderSide(color: _C.border, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34, height: 34,
                decoration: BoxDecoration(
                  color: _C.accent.withOpacity(.1),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(Icons.credit_card_outlined,
                    color: _C.accent, size: 17),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: const TextStyle(
                          color: _C.textHi,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        )),
                    Text(sub,
                        style: const TextStyle(
                            color: _C.textLow, fontSize: 11)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _C.accent.withOpacity(.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Actif',
                    style: TextStyle(
                        color: _C.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Progression',
                  style: TextStyle(color: _C.textLow, fontSize: 12)),
              Text('${fmt(paid)} / ${fmt(total)} FCFA',
                  style: const TextStyle(
                      color: _C.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 6,
              backgroundColor: const Color(0xFF1C2540),
              color: _C.accent,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${(pct * 100).toStringAsFixed(0)}% remboursé',
            style: const TextStyle(color: _C.textLow, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final ActivityEntry entry;

  const _ActivityTile({required this.entry});

  Color get _color {
    switch (entry.type) {
      case ActivityType.credit:      return const Color(0xFF4F7EFF);
      case ActivityType.maintenance: return const Color(0xFFFF8C42);
      case ActivityType.payment:     return _C.success;
      case ActivityType.other:       return const Color(0x99FFFFFF);
    }
  }

  IconData get _icon {
    switch (entry.type) {
      case ActivityType.credit:      return Icons.credit_card_outlined;
      case ActivityType.maintenance: return Icons.build_outlined;
      case ActivityType.payment:     return Icons.payments_outlined;
      case ActivityType.other:       return Icons.circle_outlined;
    }
  }

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
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: _color.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_icon, color: _color, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.title,
                    style: const TextStyle(
                      color: _C.textHi,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    )),
                const SizedBox(height: 3),
                Text(entry.subtitle,
                    style: const TextStyle(
                        color: _C.textLow, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(entry.date,
                  style: const TextStyle(
                      color: _C.textLow, fontSize: 11)),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _color.withOpacity(.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(entry.badge,
                    style: TextStyle(
                      color: _color,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}