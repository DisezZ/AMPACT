import 'package:ampact/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.leading,
    this.title = '',
    this.action,
  }) : super(key: key);

  final Widget? leading;
  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _size = MediaQuery.of(context).size;

    return Container(
      color: _theme.backgroundColor,
      child: Stack(
        children: [
          Positioned(
            width: _size.width,
            height: 145,
            bottom: 30,
            child: Container(
              decoration: BoxDecoration(
                color: _theme.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 75,
            left: kDefaultPadding,
            height: 35,
            child: FittedBox(
              child: leading,
            ),
          ),
          Positioned(
            bottom: 75,
            height: 35,
            width: _size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.25),
                        ),
                        height: 10,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 2,
                      ),
                      child: Image.asset('assets/images/logo_name_white.png'),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 75,
            right: kDefaultPadding,
            height: 35,
            child: FittedBox(
              child: action,
            ),
          ),
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 5,
                    color: Theme.of(context).primaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
}
