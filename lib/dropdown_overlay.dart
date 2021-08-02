import 'package:flutter/material.dart';

class DropdownOverlay {

  BuildContext context;
  OverlayEntry _overlayEntry;
  bool _isShowing = false, outsideTouch = true;

  DropdownOverlay(this.context);

  void show(GlobalKey dropdownButtonKey, GlobalKey textKey, List items, Function onSelect){
    if(_isShowing){
      return;
    }

    RenderBox iconBox = dropdownButtonKey.currentContext.findRenderObject();
    RenderBox textBox = textKey.currentContext.findRenderObject();
    double xOffset = _getXOffset(iconBox.localToGlobal(Offset.zero).dx + iconBox.size.width/2 , textBox.size.width);
    Map<String, double> y = _getY(iconBox, textBox.size.height, items.length);
    Size size = Size(textBox.size.width, y['Height']);
    Offset offset = Offset(xOffset, y['yOffset']);

    _overlayEntry = overlayEntry(offset: offset, size: size, height: textBox.size.height, items: items, onSelect: onSelect);
    Overlay.of(context).insert(_overlayEntry);
    _isShowing = true;
  }

  OverlayEntry overlayEntry({
    @required Size size,
    @required Offset offset,
    @required double height,
    @required List items,
    @required Function onSelect,
  }){
    return OverlayEntry(
        builder: (context) {
          return Positioned(
              width: size.width,
              height: size.height,
              left: offset.dx,
              top: offset.dy,
              child: Scaffold(
                  backgroundColor: Colors.white70,
                  body: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            alignment: Alignment.center,
                            height: height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  items[index].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Container(
                                  height: 0.5,
                                  color: Colors.grey,
                                )
                              ],
                            )
                          ),
                          onTap: (){
                            onSelect(index, items[index]);

                            remove();
                          },
                        );
                      }
                  )
              )
          );
        }
    );
  }

  remove(){
    if(_isShowing){
      _overlayEntry.remove();
      _isShowing = false;
      return null;
    }
  }

  bool isShowing(){
    return _isShowing;
  }

  double _getXOffset(double dx, double width) {
    double center = width/2;
    /*Right Side*/
    if(dx+center > MediaQuery.of(context).size.width){
      return MediaQuery.of(context).size.width - center;
    }
    /*Left Side*/
    else if(dx-center < 0){
      return 0;
    }
    /*Center*/
    return dx-center;
  }

  Map<String, double> _getY(RenderBox renderBox, double height, int count) {
    double dy = renderBox.localToGlobal(Offset.zero).dy;
    double totalHeight = height * count;
    double yOffset;

    /*if dy is in upper side*/
    if(dy < MediaQuery.of(context).size.height/3){
      yOffset = dy+renderBox.size.height;
      /*if height is greater than bottom free space*/
      if(totalHeight > (MediaQuery.of(context).size.height - dy)) {
        totalHeight = MediaQuery.of(context).size.height - (dy + renderBox.size.height);
      }
    }
    /*if dy is in lower side*/
    else {
      /*if height is greater than bottom free space*/
      if(totalHeight > (MediaQuery.of(context).size.height - dy)) {
        /*if height is less than dy*/
        if(totalHeight < dy){
          yOffset = dy-totalHeight;
        } else {
          totalHeight = dy;
          yOffset = 10;
        }
      } else {
        yOffset = dy + renderBox.size.height;
      }
    }
    return{
      'Height': totalHeight,
      'yOffset': yOffset
    };
  }
}
