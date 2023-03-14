import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProvider extends InheritedWidget {
  final Bloc bloc;

  const BlocProvider({
    super.key,
    required this.bloc,
    required Widget child,
  }) : super(child: child);

  static Bloc of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<BlocProvider>();

    if (provider != null) {}

    throw Exception('Bloc not found!');
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return (oldWidget as Bloc).state != bloc.state;
  }
}
