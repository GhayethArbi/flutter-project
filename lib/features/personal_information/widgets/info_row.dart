import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_tokens.dart';

/// A single labelled row inside an [AppMenuCard].
///
/// Shows an icon box, a stacked label+value, and an optional chevron.
/// Set [isEditable] to `false` for read-only rows (no tap ripple / no chevron).
class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.isLast,
    this.onTap,
    this.isEditable = true,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;

  /// When `false`, no divider is drawn below this row.
  final bool isLast;

  final VoidCallback? onTap;

  /// Disables the tap ripple and hides the chevron.
  final bool isEditable;

  /// Overrides the default value text colour (e.g. green for "Vérifié").
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: isEditable ? onTap : null,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                _IconBox(icon: icon),
                const SizedBox(width: 12),
                Expanded(child: _LabelValue(label: label, value: value, valueColor: valueColor)),
                if (isEditable)
                  Icon(Icons.chevron_right, size: 18, color: Colors.black.withOpacity(0.2)),
              ],
            ),
          ),
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.only(left: 58),
            child: Divider(height: 0.5, color: AppTokens.divider),
          ),
      ],
    );
  }
}

class _IconBox extends StatelessWidget {
  const _IconBox({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppTokens.iconBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 17, color: Colors.black54),
    );
  }
}

class _LabelValue extends StatelessWidget {
  const _LabelValue({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final isEmpty = value.isEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppTokens.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          isEmpty ? '—' : value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: valueColor ?? (isEmpty ? AppTokens.textHint : AppTokens.textPrimary),
          ),
        ),
      ],
    );
  }
}