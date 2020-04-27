import 'package:flutter/widgets.dart';
import 'package:haftaa/authentication/auth.dart';
import 'package:haftaa/bloc/product-bloc.dart';
import 'package:haftaa/settings/settings.dart';
import 'package:haftaa/settings/settings_controller.dart';

class Provider extends InheritedWidget {
  Auth auth ;
  final Future<Settings> settings=  SettingsController.getSettings();

  ProductBloc productBloc = ProductBloc();

  Provider({Key key, Widget child,this.auth}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  // static ProductBloc of(BuildContext context) {
  //   return (context.inheritFromWidgetOfExactType(Provider) as Provider).productBloc;
  // }


  static Provider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider);
  }
}
