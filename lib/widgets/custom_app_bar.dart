import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  final String title;
  final bool isHome;
  final bool isBack;
  final Function? onBackTap;
  final Function? onCartTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isHome = false,
    this.isBack = false,
    this.onBackTap,
    this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      title: Text(title, style: TextStyle(color: Colors.white)),
      backgroundColor: Theme.of(context).colorScheme.primary,
      // title: Text(title, style: TextStyle(color: Colors.white),),
      actions: [
        if (isHome)
          // Badge(
          //   label: Text('11', style: TextStyle(color: Colors.white)),
          //   child: IconButton(
          //     icon: Icon(Icons.shopping_cart),
          //     onPressed: () {
          //       if (onCartTap != null) {
          //         onCartTap!();
          //       }
          //     },
          //     color: Colors.white,
          //   ),
          // ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: onCartTap as void Function()?,
          ),
      ],
      leading:
          isBack
              ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: onBackTap as void Function()?,
              )
              : null,
    );
  }
}

// AppBar(
//     title: Text('E-Commerce', style: TextStyle(color: Colors.white)),
//     backgroundColor: Theme.of(context).colorScheme.primary,
//     actions: <Widget>[
//       IconButton(
//         icon: Icon(Icons.search, color: Colors.white),
//         onPressed: () {
//           // showSearch(context: context, delegate: DataSearch());
//         },
//       ),
//     ],
//   );
