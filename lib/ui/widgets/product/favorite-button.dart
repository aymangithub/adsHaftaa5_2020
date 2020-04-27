import 'package:flutter/material.dart';
import 'package:haftaa/product/base-product.dart';
import 'package:haftaa/provider/provider.dart';
import 'package:haftaa/user/user-controller.dart';
import 'package:haftaa/user/user.dart';
import 'dart:convert';

class ProductFavoriteButton extends StatefulWidget {
  BaseProduct product;

  ProductFavoriteButton(this.product);

  @override
  _ProductFavoriteButtonState createState() => _ProductFavoriteButtonState();
}

class _ProductFavoriteButtonState extends State<ProductFavoriteButton> {
  User _user;
  bool productInUserFav = false;
  Widget favIcon = Icon(Icons.favorite_border);
  //String favouriteID;
  UserController _userController = UserController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of(context).auth.user == null) {
      if ((widget.product.favUsers as Map)
          .keys
          .contains(Provider.of(context).auth.user.id)) {
        changeFavStatus(true);
      } else {
        changeFavStatus(false);
      }
    }

    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: favIcon,
            color: Colors.redAccent.shade200,
            onPressed: () {
              if (Provider.of(context).auth.user != null) {
                productInUserFav ? removeFromFav(context) : addToFav(context);
              } else {
                Navigator.pushNamed(context, 'choose-login');
              }
            },
          ),
        ),
        //Text(favouriteID ?? 'null' )
      ],
    );
  }

  void addToFav(BuildContext context) async {
    (widget.product.favUsers as Map)[Provider.of(context).auth.user.id] = true;
    var values = jsonEncode(widget.product.favUsers);
    _userController
        .addUserIDToProductFav(
        widget.product.id, Provider.of(context).auth.user.id)
        .then((newFavID) async {
      changeFavStatus(true);
    });
  }

  void removeFromFav(BuildContext context) async {
    (widget.product.favUsers as Map).remove(Provider.of(context).auth.user.id);

    _userController
        .removeUserFromProductFav(
        widget.product.id, Provider.of(context).auth.user.id)
        .then((newFavID) async {
      changeFavStatus(false);
    }).catchError((error) {
      var s;
    });
  }

  void changeFavStatus(bool productIsInFavList) {
    setState(() {
      if (!productIsInFavList) {
        productInUserFav = false;
        favIcon = Icon(Icons.favorite_border);
      } else {
        productInUserFav = true;
        favIcon = Icon(Icons.favorite);
      }
    });
  }

  void refreshCurrentUserData() {
    //Provider.of(context).auth.refreshUserData();
  }
}
