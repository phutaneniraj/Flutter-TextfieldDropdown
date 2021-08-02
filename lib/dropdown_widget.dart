import 'package:flutter/material.dart';
import 'dropdown_overlay.dart';

class DropdownWidget extends StatefulWidget {

  final List items;
  final GlobalKey globalKey;
  final BuildContext context;
  final Function onSelect;
  final initialValue;

  DropdownWidget({
    @required this.items,
    @required this.globalKey,
    @required this.context,
    @required this.onSelect,
    this.initialValue
  });

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {

  String selectedValue;
  DropdownOverlay overlay;
  GlobalKey iconKey = GlobalKey();

  @override
  void initState() {
    selectedValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (){
          overlay.remove();
          return Future.value(false);
        },
        child: IconButton(
            key: iconKey,
            iconSize: 40,
            icon: Icon(Icons.arrow_drop_down_circle_outlined),
            onPressed: (){
              overlay = DropdownOverlay(context);
              overlay.show(iconKey, widget.globalKey, widget.items, widget.onSelect);
            }
        ),
      );
  }
}
