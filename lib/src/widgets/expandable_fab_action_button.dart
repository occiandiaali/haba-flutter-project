import 'package:flutter/material.dart';

@immutable
class ExpandableFabActionButton extends StatelessWidget {
  const ExpandableFabActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.deepOrange,//theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: Colors.white,//theme.colorScheme.onSecondary,
      ),
    );
  }
}
