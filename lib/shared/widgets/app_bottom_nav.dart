// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mobile_app_user/core/extensions/string_ext.dart';
// import 'package:mobile_app_user/core/theme/colors.dart';
// import 'package:mobile_app_user/shared/utils/constants.dart';
// import 'package:mobile_app_user/shared/widgets/app_svg.dart';
// // import 'package:badges/badges.dart' as badges;
// import 'package:mobile_app_user/shared/widgets/hexColorCode.dart';
// import '../presentation/landing/landing_cubit.dart';

// class AppBottomNav extends StatelessWidget {
//   const AppBottomNav(
//       {super.key,
//       required this.currentIndex,
//       required this.onTap,
//       required this.cubit});
//   static const menus = ['connect', 'orders', 'account'];
//   // static const menus = ['stores', 'courier', 'orders', 'account'];

//   final int currentIndex;
//   final void Function(int) onTap;
//   final LandingCubit cubit;

//   @override
//   Widget build(BuildContext context) {
//     final bool hasSafeArea = MediaQuery.of(context).padding.bottom > 0;

//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 400),
//       alignment: Alignment.center,
//       height:  (hasSafeArea ? 100 : 70),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         // Apply shadow
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             spreadRadius: 2,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Wrap(
//         children: [
//           BottomNavigationBar(
//             elevation: 0,
//             onTap: (index) => onTap(index),
//             currentIndex: currentIndex,
//             items: menus
//                 .map(
//                   (menu) => BottomNavigationBarItem(
//                     icon:
//                     //  menu == "instant" &&
//                     //         ((currentUser?.abandonedCart?.itemCount ?? 0) > 0)
//                     //     ? badges.Badge(
//                     //         showBadge: true,
//                     //         badgeStyle:
//                     //             ((currentUser?.abandonedCart?.itemCount ?? 0) >
//                     //                     9)
//                     //                 ? const badges.BadgeStyle(
//                     //                     padding: EdgeInsets.symmetric(
//                     //                         horizontal: 2, vertical: 2))
//                     //                 : const badges.BadgeStyle(),
//                     //         position:
//                     //             badges.BadgePosition.topEnd(top: -1, end: -8),
//                     //         badgeAnimation:
//                     //             const badges.BadgeAnimation.rotation(
//                     //           animationDuration: Duration(seconds: 1),
//                     //           colorChangeAnimationDuration:
//                     //               Duration(seconds: 1),
//                     //           loopAnimation: false,
//                     //           curve: Curves.fastOutSlowIn,
//                     //           colorChangeAnimationCurve: Curves.easeInCubic,
//                     //         ),
//                     //         badgeContent: AppText(
//                     //           ((currentUser?.abandonedCart?.itemCount ?? 0) > 9)
//                     //               ? "9+"
//                     //               : currentUser?.abandonedCart?.itemCount,
//                     //           family: manrope600,
//                     //           size: 12,
//                     //           color: Colors.white,
//                     //         ),
//                     //         child: Padding(
//                     //           padding: EdgeInsets.only(bottom: 3.h),
//                     //           child: BnvIcon(
//                     //               iconName: menu, color: bnvUnselectedClr),
//                     //         ),
//                     //       )
//                     //     :
//                          Padding(
//                             padding: EdgeInsets.only(bottom: 3.h),
//                             child: BnvIcon(
//                                 iconName: menu, color: bnvUnselectedClr),
//                           ),
//                     activeIcon: Padding(
//                       padding: EdgeInsets.only(bottom: 3.h),
//                       child: BnvIcon(
//                           iconName: "${menu}_fill", color: bnvSelectedClr),
//                     ),
//                     label: menu.upperFirst,
//                   ),
//                 )
//                 .toList(),
//             showUnselectedLabels: true,
//             backgroundColor: Colors.white,
//             type: BottomNavigationBarType.fixed,
//             selectedLabelStyle: TextStyle(
//                 color: HexColor("#3531BE"), fontSize: 14.sp, fontFamily: manrope600),
//             unselectedLabelStyle: TextStyle(
//                 color: bnvUnselectedClr,
//                 fontSize: 14.sp,
//                 fontFamily: manrope600),
//             fixedColor: HexColor("#3531BE"),
//             landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BnvIcon extends StatelessWidget {
//   const BnvIcon({
//     super.key,
//     required this.iconName,
//     required this.color,
//   });

//   final String iconName;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: AppSvg(assetName: iconName, ),
//     );
//   }
// }
