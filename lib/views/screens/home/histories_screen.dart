import 'package:flutter/material.dart';
import 'package:startkit_app/views/widgets/bottom_navigation_bar.dart';

// ─── Shared tokens ────────────────────────────────────────────────────────────
class _C {
  static const bg      = Color(0xFF0B0E14);
  static const surface = Color(0xFF13171F);
  static const accent  = Color(0xFF4F7EFF);
  static const border  = Color(0x1AFFFFFF);
  static const textHi  = Colors.white;
  static const textMid = Color(0x99FFFFFF);
  static const textLow = Color(0x50FFFFFF);
  static const success = Color(0xFF3DBE7A);
  static const danger  = Color(0xFFE24B4A);
}

enum PaymentStatus { paid, late, pending }

class PaymentEntry {
  final String label;
  final String date;
  final int amount;
  final PaymentStatus status;

  const PaymentEntry({
    required this.label,
    required this.date,
    required this.amount,
    required this.status,
  });
}

// ─── Page ─────────────────────────────────────────────────────────────────────
class HistoriesScreen extends StatefulWidget {
  const HistoriesScreen({super.key});

  @override
  State<HistoriesScreen> createState() => _HistoryePageState();
}

class _HistoryePageState extends State<HistoriesScreen> {
  PaymentStatus? _filter; // null = tout

  static const _payments = [
    PaymentEntry(label: 'Paiement mensuel', date: '15 Mars 2026',   amount: 5000, status: PaymentStatus.paid),
    PaymentEntry(label: 'Paiement mensuel', date: '10 Mars 2026',   amount: 5000, status: PaymentStatus.paid),
    PaymentEntry(label: 'Paiement mensuel', date: '28 Fév 2026',    amount: 5000, status: PaymentStatus.late),
    PaymentEntry(label: 'Paiement mensuel', date: '15 Fév 2026',    amount: 5000, status: PaymentStatus.paid),
    PaymentEntry(label: 'Paiement mensuel', date: '01 Fév 2026',    amount: 5000, status: PaymentStatus.paid),
    PaymentEntry(label: 'Paiement mensuel', date: '15 Jan 2026',    amount: 5000, status: PaymentStatus.late),
    PaymentEntry(label: 'Paiement mensuel', date: '01 Jan 2026',    amount: 5000, status: PaymentStatus.paid),
  ];

  List<PaymentEntry> get _filtered => _filter == null
      ? _payments
      : _payments.where((p) => p.status == _filter).toList();

  int get _totalPaid => _payments
      .where((p) => p.status == PaymentStatus.paid)
      .fold(0, (s, p) => s + p.amount);

  int get _totalLate => _payments
      .where((p) => p.status == PaymentStatus.late)
      .fold(0, (s, p) => s + p.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _C.bg,
        title: const Text(
          'Historique',
          style: TextStyle(
            color: _C.textHi,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Exporter',
              style: TextStyle(color: _C.accent, fontSize: 13),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── KPI row ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: Row(
              children: [
                Expanded(child: _StatCard(
                  label: 'Total payé',
                  value: '${_formatAmount(_totalPaid)} FCFA',
                  valueColor: _C.success,
                )),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(
                  label: 'Arriérés',
                  value: '${_formatAmount(_totalLate)} FCFA',
                  valueColor: _C.danger,
                )),
              ],
            ),
          ),

          // ── Filters ───────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(label: 'Tout',     active: _filter == null,
                      onTap: () => setState(() => _filter = null)),
                  _FilterChip(label: 'Payé',     active: _filter == PaymentStatus.paid,
                      onTap: () => setState(() => _filter = PaymentStatus.paid)),
                  _FilterChip(label: 'En retard', active: _filter == PaymentStatus.late,
                      onTap: () => setState(() => _filter = PaymentStatus.late)),
                ],
              ),
            ),
          ),

          // ── List ──────────────────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              itemCount: _filtered.length,
              itemBuilder: (_, i) => _PaymentTile(entry: _filtered[i]),
            ),
          ),
        ],
      ),
     
    
    );
  }

  String _formatAmount(int v) =>
      v.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]} ');
}



// ─── Widgets ──────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _StatCard({
    required this.label,
    required this.value,
    required this.valueColor,
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
          Text(label,
              style: const TextStyle(color: _C.textLow, fontSize: 11)),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                color: valueColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              )),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: active ? _C.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? _C.accent : _C.border,
            width: 0.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : _C.textLow,
            fontSize: 12,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  final PaymentEntry entry;

  const _PaymentTile({required this.entry});

  Color get _iconColor {
    switch (entry.status) {
      case PaymentStatus.paid:    return _C.success;
      case PaymentStatus.late:    return _C.danger;
      case PaymentStatus.pending: return const Color(0xFFFF8C42);
    }
  }

  String get _statusLabel {
    switch (entry.status) {
      case PaymentStatus.paid:    return 'Payé';
      case PaymentStatus.late:    return 'Retard';
      case PaymentStatus.pending: return 'En attente';
    }
  }

  String get _amountLabel {
    if (entry.status == PaymentStatus.late) return '–${_fmt(entry.amount)}';
    return '+${_fmt(entry.amount)}';
  }

  Color get _amountColor =>
      entry.status == PaymentStatus.late ? _C.danger : _C.success;

  String _fmt(int v) =>
      v.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]} ');

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
          // icon
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: _iconColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.payments_outlined,
                color: _iconColor, size: 18),
          ),
          const SizedBox(width: 14),
          // label + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.label,
                    style: const TextStyle(
                        color: _C.textHi,
                        fontWeight: FontWeight.w500,
                        fontSize: 13)),
                const SizedBox(height: 3),
                Text(entry.date,
                    style: const TextStyle(
                        color: _C.textLow, fontSize: 11)),
              ],
            ),
          ),
          // amount + badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${_amountLabel} FCFA',
                style: TextStyle(
                  color: _amountColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _iconColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _statusLabel,
                  style: TextStyle(
                    color: _iconColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}