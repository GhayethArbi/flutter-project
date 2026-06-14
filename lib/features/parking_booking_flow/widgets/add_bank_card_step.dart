// import 'package:flutter/material.dart';
// import 'package:tunipark/core/utils/responsive_extension.dart';

// class AddBankCardStep extends StatelessWidget {
//   const AddBankCardStep({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final rs = context.rs;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Numéro de carte',
//           style: TextStyle(
//             fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 8),
//         _CardInputField(
//           hintText: 'Numéro de carte',
//           prefixIcon: Icons.credit_card,
//         ),
//         const SizedBox(height: 18),
//         Row(
//           children: const [
//             Expanded(
//               child: _LabeledField(
//                 label: 'Expiration',
//                 hintText: 'Expiration',
//               ),
//             ),
//             SizedBox(width: 12),
//             Expanded(
//               child: _LabeledField(
//                 label: 'Cryptogramme',
//                 hintText: 'Cryptogramme',
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class _LabeledField extends StatelessWidget {
//   final String label;
//   final String hintText;

//   const _LabeledField({
//     required this.label,
//     required this.hintText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final rs = context.rs;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 8),
//         _CardInputField(hintText: hintText),
//       ],
//     );
//   }
// }

// class _CardInputField extends StatelessWidget {
//   final String hintText;
//   final IconData? prefixIcon;

//   const _CardInputField({
//     required this.hintText,
//     this.prefixIcon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final rs = context.rs;

//     return TextFormField(
//       decoration: InputDecoration(
//         hintText: hintText,
//         isDense: true,
//         hintStyle: TextStyle(
//           color: Colors.black38,
//           fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
//         ),
//         prefixIcon: prefixIcon == null
//             ? null
//             : Icon(prefixIcon, size: 18, color: Colors.black54),
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFFDDE7A5)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFFB7F000)),
//         ),
//       ),
//     );
//   }
// }