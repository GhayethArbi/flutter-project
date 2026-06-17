import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/core/constants/app_strings.dart';


class AppScreenHeader extends StatelessWidget {
  const AppScreenHeader({
    super.key,
    required this.title,
    this.bottom,
  });

  final String title;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.colorBtn,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
      ),
      padding: EdgeInsets.fromLTRB(
        8,
        rs.adaptive(mobile: 8, tablet: 12),
        rs.adaptive(mobile: 22, tablet: 28),
        rs.adaptive(mobile: 20, tablet: 24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back,
                    color: AppTokens.textPrimary, size: 22),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: rs.adaptive(mobile: 18, tablet: 20),
                    fontWeight: FontWeight.w700,
                    color: AppTokens.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          if (bottom != null) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: bottom!,
            ),
          ],
        ],
      ),
    );
  }
}


class AppSectionLabel extends StatelessWidget {
  const AppSectionLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppTokens.textHint,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class AppMenuCard extends StatelessWidget {
  const AppMenuCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppTokens.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTokens.border, width: 0.5),
      ),
      child: Column(children: children),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Single menu row
// ─────────────────────────────────────────────────────────────────────────────

class AppMenuRow extends StatelessWidget {
  const AppMenuRow({
    super.key,
    required this.icon,
    required this.label,
    required this.isLast,
    this.onTap,
    this.labelColor,
    this.iconColor,
    this.iconBackground,
    this.trailing,
    this.showChevron = true,
  });

  final IconData icon;
  final String label;
  final bool isLast;
  final VoidCallback? onTap;
  final Color? labelColor;
  final Color? iconColor;
  final Color? iconBackground;
  final Widget? trailing;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                _IconBox(
                  icon: icon,
                  color: iconColor ?? Colors.black54,
                  background: iconBackground ?? AppTokens.iconBackground,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: labelColor ?? AppTokens.textPrimary,
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
                if (showChevron && trailing == null)
                  Icon(Icons.chevron_right,
                      size: 18,
                      color: Colors.black.withOpacity(0.2)),
                if (showChevron && trailing != null) ...[
                  const SizedBox(width: 4),
                  Icon(Icons.chevron_right,
                      size: 18,
                      color: Colors.black.withOpacity(0.2)),
                ],
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
  const _IconBox({
    required this.icon,
    required this.color,
    required this.background,
  });

  final IconData icon;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 17, color: color),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Accordion row (for FAQ / Policy / Terms)
// ─────────────────────────────────────────────────────────────────────────────

class AppAccordionRow extends StatelessWidget {
  const AppAccordionRow({
    super.key,
    required this.title,
    required this.content,
    required this.isExpanded,
    required this.isLast,
    required this.onTap,
  });

  final String title;
  final String content;
  final bool isExpanded;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isExpanded
                          ? AppTokens.limeDark
                          : AppTokens.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: isExpanded ? AppTokens.limeDark : Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTokens.limeSubtle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 13,
                color: AppTokens.limeDark,
                height: 1.6,
              ),
            ),
          ),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Divider(height: 0.5, color: AppTokens.divider),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Info banner (lime tinted)
// ─────────────────────────────────────────────────────────────────────────────

class AppInfoBanner extends StatelessWidget {
  const AppInfoBanner({
    super.key,
    required this.text,
    this.icon = Icons.info_outline,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTokens.limeSubtle,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTokens.lime, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppTokens.limeDark),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: AppTokens.limeDark,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// "Last updated" chip
// ─────────────────────────────────────────────────────────────────────────────

class AppUpdatedChip extends StatelessWidget {
  const AppUpdatedChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTokens.limeLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTokens.lime, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.update, size: 13, color: AppTokens.limeDark),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTokens.limeDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Primary button (lime)
// ─────────────────────────────────────────────────────────────────────────────

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    return SizedBox(
      width: double.infinity,
      height: rs.adaptive(mobile: 52, tablet: 56),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTokens.lime,
          foregroundColor: AppTokens.textPrimary,
          disabledBackgroundColor: AppTokens.lime.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppTokens.textPrimary,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Outlined button
// ─────────────────────────────────────────────────────────────────────────────

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppTokens.lime, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 18, color: AppTokens.limeDark),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTokens.limeDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTokens.limeDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Password text field
// ─────────────────────────────────────────────────────────────────────────────

class AppPasswordField extends StatelessWidget {
  const AppPasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isVisible,
    required this.onToggleVisibility,
    this.onChanged,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isVisible;
  final VoidCallback onToggleVisibility;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      onChanged: onChanged,
      validator: validator,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      style: const TextStyle(fontSize: 15, color: AppTokens.textPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppTokens.textHint),
        filled: true,
        fillColor: AppTokens.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: _border(AppTokens.border),
        enabledBorder: _border(AppTokens.border),
        focusedBorder: _border(AppTokens.lime, width: 1.5),
        errorBorder: _border(AppTokens.danger),
        focusedErrorBorder: _border(AppTokens.danger, width: 1.5),
        suffixIcon: IconButton(
          onPressed: onToggleVisibility,
          icon: Icon(
            isVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 18,
            color: Colors.black38,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _border(Color color, {double width = 0.5}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Field label
// ─────────────────────────────────────────────────────────────────────────────

class AppFieldLabel extends StatelessWidget {
  const AppFieldLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppTokens.textSecondary,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stateful toggle switch (lime branded)
// ─────────────────────────────────────────────────────────────────────────────

class AppToggle extends StatelessWidget {
  const AppToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppTokens.lime,
      activeTrackColor: const Color(0xFFD9F569),
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: const Color(0xFFE0E0E0),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Confirm dialog helper
// ─────────────────────────────────────────────────────────────────────────────

Future<bool?> showAppConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool isDanger = false,
}) {
  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
      content: Text(message,
          style: const TextStyle(fontSize: 14, color: AppTokens.textSecondary)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(AppStrings.annuler,
              style: TextStyle(color: AppTokens.textSecondary)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            confirmLabel,
            style: TextStyle(
              color: isDanger ? AppTokens.danger : AppTokens.limeDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}