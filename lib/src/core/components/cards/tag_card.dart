// import 'package:flutter/material.dart';
//
// import '../../constants/styles.dart';
// import '../../utils/app_context.dart';
// import '../../../features/app/domain/entities/operation_type.dart';
//
// class TagCard extends StatelessWidget {
//   final OperationType operationType;
//   final String text;
//   final bool isAppear;
//
//   const TagCard({
//     super.key,
//     required this.operationType,
//     required this.text,
//     this.isAppear = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final color = operationType == OperationType.income
//         ? context.colors.secondary
//         : context.colors.error;
//
//     return isAppear
//         ? Container(
//             height: 25,
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: BorderRadius.circular(circle),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 5,
//                     backgroundColor: context.colors.surface,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     text,
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: operationType == OperationType.income
//                           ? context.colors.primaryContainer
//                           : context.colors.errorContainer,
//                       fontWeight: FontWeight.bold,
//                       height: 0,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         : const SizedBox();
//   }
// }
