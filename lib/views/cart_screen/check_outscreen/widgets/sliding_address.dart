import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingAddress extends StatefulWidget {
  @override
  _SlidingAddressState createState() => _SlidingAddressState();
}
PanelController _pc = new PanelController();
 

class _SlidingAddressState extends State<SlidingAddress> {
   @override
  void initState() {
    PanelController _pc =  PanelController();
     _pc.show();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
        controller: _pc,
        panel: Center(child: Text('test'),),
        body: ListView(children: [

        ],),
      );
  }
}