import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/src/base/bloc.dart';

class BlocProvider<T extends Bloc> extends InheritedWidget {
  BlocProvider({
    Key key,
    @required this.bloc,
    child,
  }) : super(key: key, child: child);

  final T bloc;

  static T of<T extends Bloc>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
