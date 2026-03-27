import 'package:flutter/material.dart';
import 'package:startkit_app/config/app_colors.dart';

// ── Label de champ ────────────────────────────────────────────────────────────

Widget fieldLabel(String text) => Text(
      text.toUpperCase(),
      style: const TextStyle(
        color:         ColorsPalette.label,
        fontSize:      11,
        fontWeight:    FontWeight.w600,
        letterSpacing: 1.0,
      ),
    );

// ── Champ texte avec label ────────────────────────────────────────────────────

Widget appDarkTextField({
  required String    label,
  required String    hint,
  required IconData  icon,
  bool               obscureText      = false,
  bool               focused          = false,
  String?            errorText,
  Widget?            suffixIcon,
  TextEditingController? controller,
  FocusNode?         focusNode,
  Function(String?)? onChanged,
  String? Function(String?)? validator,
  TextInputType?     keyboardType,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      fieldLabel(label),
      const SizedBox(height: 8),
      TextFormField(
        controller:       controller,
        focusNode:        focusNode,
        obscureText:      obscureText,
        onChanged:        onChanged,
        validator:        validator,
        keyboardType:     keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(color: ColorsPalette.textHigh, fontSize: 14),
        decoration: _buildDecoration(
          hint:      hint,
          icon:      icon,
          focused:   focused,
          suffix:    suffixIcon,
          errorText: errorText,
        ),
      ),
    ],
  );
}

// ── Décoration interne ────────────────────────────────────────────────────────

InputDecoration _buildDecoration({
  required String   hint,
  required IconData icon,
  required bool     focused,
  Widget?           suffix,
  String?           errorText,
}) {
  return InputDecoration(
    hintText:       hint,
    hintStyle:      const TextStyle(color: ColorsPalette.textLow, fontSize: 14),
    prefixIcon:     Icon(
      icon,
      color: focused ? ColorsPalette.accent : ColorsPalette.label,
      size:  18,
    ),
    suffixIcon:     suffix,
    filled:         true,
    fillColor:      ColorsPalette.surface,
    errorText:      errorText,
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide:   const BorderSide(color: ColorsPalette.border, width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide:   const BorderSide(color: ColorsPalette.borderFoc, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide:   const BorderSide(color: ColorsPalette.danger, width: 0.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide:   const BorderSide(color: ColorsPalette.danger, width: 1),
    ),
    errorStyle: const TextStyle(color: ColorsPalette.danger, fontSize: 12),
  );
}