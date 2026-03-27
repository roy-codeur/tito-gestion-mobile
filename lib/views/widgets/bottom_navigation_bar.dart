import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubits/home_cubit.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  static const List<_NavItemData> _items = [
    _NavItemData(Icons.home_outlined, 'Accueil'),
    _NavItemData(Icons.history_outlined, 'Historique'),
    _NavItemData(Icons.insights_outlined, 'Activité'),
    _NavItemData(Icons.person_outline_rounded, 'Profil'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex =
        context.select((HomeCubit cubit) => cubit.state.index);

    return Container(
      decoration: const BoxDecoration(
        color: _C.bg,
        border: Border(
          top: BorderSide(color: _C.border, width: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (index) {
            final item = _items[index];

            return _NavItem(
              icon: item.icon,
              label: item.label,
              active: currentIndex == index,
              onTap: () {
                context.read<HomeCubit>().change(index);
              },
            );
          }),
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;

  const _NavItemData(this.icon, this.label);
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: active
                ? BoxDecoration(
                    color: _C.accent.withOpacity(.12),
                    borderRadius: BorderRadius.circular(20),
                  )
                : null,
            child: Icon(
              icon,
              color: active ? _C.accent : _C.textLow,
              size: 22,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: active ? _C.accent : _C.textLow,
              fontSize: 11,
              fontWeight:
                  active ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}


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
