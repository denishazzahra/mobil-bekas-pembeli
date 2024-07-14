import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import '../utils/colors.dart';
import 'text_fields.dart';
import 'texts.dart';

AppBar appBar(int currentPageIndex, TextEditingController searchController,
    Function changePage, Function onSearch) {
  return AppBar(
    elevation: 2,
    surfaceTintColor: whiteColor,
    backgroundColor: whiteColor,
    shadowColor: blackColor,
    toolbarHeight: 72,
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InkWell(
            onTap: changePage(0),
            child: listTitleText('Nama Web', false),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: textField(
            controller: searchController,
            placeholder: 'Cari mobil...',
            prefixIcon: const Icon(Symbols.search),
            isSearch: true,
            onSubmitted: onSearch,
          ),
        ),
      ],
    ),
    actions: [
      const SizedBox(width: 15),
      IconButton(
        onPressed: () {
          changePage(1);
        },
        icon: Icon(
          Symbols.receipt,
          fill: 0,
          color: blackColor,
        ),
      ),
      const SizedBox(width: 10),
      IconButton(
        onPressed: () {
          changePage(2);
        },
        icon: Icon(
          Symbols.person,
          fill: 0,
          color: blackColor,
        ),
      ),
      const SizedBox(width: 15),
    ],
  );
}

// Widget bottomNavbar(int currentPageIndex, Function changePage) {
//   return Container(
//     decoration: BoxDecoration(
//       boxShadow: <BoxShadow>[
//         BoxShadow(
//           color: Colors.grey.shade600,
//           blurRadius: 2,
//         ),
//       ],
//     ),
//     child: NavigationBar(
//       backgroundColor: whiteColor,
//       surfaceTintColor: whiteColor,
//       onDestinationSelected: (int index) {
//         changePage(index);
//       },
//       indicatorColor: blackColor,
//       selectedIndex: currentPageIndex,
//       destinations: <Widget>[
//         NavigationDestination(
//           selectedIcon: Icon(
//             Symbols.home,
//             color: whiteColor,
//             fill: 1,
//           ),
//           icon: const Icon(
//             Symbols.home,
//             fill: 0,
//           ),
//           label: 'Beranda',
//         ),
//         NavigationDestination(
//           selectedIcon: Icon(
//             Symbols.search,
//             color: whiteColor,
//             fill: 1,
//             weight: 600,
//           ),
//           icon: const Icon(
//             Symbols.search,
//             fill: 0,
//           ),
//           label: 'Pencarian',
//         ),
//         NavigationDestination(
//           selectedIcon: Icon(
//             Symbols.history,
//             color: whiteColor,
//             fill: 1,
//             weight: 600,
//           ),
//           icon: const Icon(
//             Icons.history,
//             fill: 0,
//           ),
//           label: 'Riwayat',
//         ),
//       ],
//     ),
//   );
// }
