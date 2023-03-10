import 'package:flutter/cupertino.dart';


//xoay màn hình
extension GetOrientation on BuildContext {
  Orientation get orientation => MediaQuery.of(this).orientation;
}

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    Key? key,
    required this.portrait,
    required this.landscape,
  }) : super(key: key);

  final Widget portrait;
  final Widget landscape;

  @override
  Widget build(BuildContext context) {
    return context.orientation == Orientation.portrait ? portrait : landscape;
  }
}
