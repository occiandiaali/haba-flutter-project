import 'package:flutter/material.dart';

class MapMarkerWidget extends StatelessWidget {
  const MapMarkerWidget({Key? key, required this.text, required this.toolTipTap, this.iconColour}) : super(key: key);
  final String text;
  final void Function() toolTipTap;
  final Color? iconColour;

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Center(
      child: GestureDetector(
       // onTap: toolTipTap,
        onLongPress: toolTipTap,
        child: Tooltip(
          key: key,
        //  triggerMode: TooltipTriggerMode.tap,
          message: text,
          showDuration: const Duration(seconds: 4),
          preferBelow: false,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent.withOpacity(0.6),
            borderRadius: BorderRadius.circular(22),
          ),
          textStyle: const TextStyle(fontFamily: 'Cera Pro'),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onTap(key),
            child: Icon(Icons.pin_drop_outlined, size: 30, color: iconColour,),
          ),
        ),
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}
