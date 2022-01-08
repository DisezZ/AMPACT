import 'package:ampact/constants.dart';
import 'package:flutter/material.dart';

class APCustomBNBItem {
  const APCustomBNBItem({required this.iconData, this.text});

  final IconData? iconData;
  final String? text;
}

class APCustomBNB extends StatefulWidget {
    const APCustomBNB({
    Key? key,
    required this.items,
    this.height = 80,
    this.iconSize = 35,
    this.backgroundColor,
    this.onTabSelected,
    this.onButtonPressed,
  }) :  assert(items.length == 5),
        super(key: key);

  final List<APCustomBNBItem> items;
  final double height;
  final double iconSize;
  final Color? backgroundColor;
  final ValueChanged<int>? onTabSelected;
  final VoidCallback? onButtonPressed;

  @override
  _APCustomBNBState createState() => _APCustomBNBState();
}

class _APCustomBNBState extends State<APCustomBNB> {
  int _selectedIndex = 0;

  void _updateIndex(int index) {
    widget.onTabSelected!(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    List<Widget> items = List.generate(4, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    Widget floatButton = _buildFloatTabItem(item: widget.items[4], onPressed: null);

    return Container(
      height: 80,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.38),
          ),
        ],
      ),
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, widget.height),
            painter: BNBCustomPainter(color: widget.backgroundColor!),
          ),
          Center(
              heightFactor: 0.6,
              child: floatButton
          ),
          Container(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                items[0],
                items[1],
                Container(width: size.width * 0.2),
                items[2],
                items[3],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    APCustomBNBItem? item,
    required int index,
    ValueChanged<int>? onPressed
  }) {
    Color? iconColor = _selectedIndex == index? kSecondaryColor : kPrimaryColor;
    return IconButton(
      onPressed: () => onPressed!(index),
      icon: Icon(item!.iconData, size: widget.iconSize, color: iconColor,),
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
    );
  }

  Widget _buildFloatTabItem({
    APCustomBNBItem? item,
    ValueChanged<void>? onPressed
  }) {
    return FloatingActionButton(
      onPressed: widget.onButtonPressed,
      backgroundColor: kPrimaryColor,
      child: Icon(item!.iconData, size: widget.iconSize, ),
      elevation: 0.1,
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  const BNBCustomPainter({this.color = Colors.red});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: const Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/*
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child:  Container(
            width: size.width,
            height: 80,
            //color: Colors.blueAccent,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(size.width, 80),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.deepOrangeAccent,
                    child: Icon(Icons.add),
                    elevation: 0.1,
                  ),
                ),
                Container(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.home, size: 35,),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.assignment_ind, size: 35,),
                      ),
                      Container(width: size.width * 0.2),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications, size: 35,),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.account_circle, size: 35,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
 */
