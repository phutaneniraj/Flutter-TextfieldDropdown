import 'package:flutter/material.dart';
import 'package:flutter_textfield_dropdown/dropdown_widget.dart';
import 'dropdown_overlay.dart';

class SampleScreen extends StatefulWidget {

  SampleScreen();

  @override
  _SampleScreenState createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {

  DropdownOverlay dropdown;
  String selectedValue;
  List items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dropdown'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 400),
          alignment: Alignment.topCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 150),
                child: DropdownWidget(
                  initialValue: '0',
                  context: context,
                  globalKey: _globalKey,
                  items: items,
                  onSelect: (index, value){
                    print(index.toString()+' : '+value.toString());
                    setState(() {
                      selectedValue = items[index].toString();
                    });
                  },
                )
              ),
              Expanded(
                  child: Text(
                    selectedValue?? 'No value...',
                    key: _globalKey,
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  )
              ),
            ],
          ),
        )
    );
  }
}
