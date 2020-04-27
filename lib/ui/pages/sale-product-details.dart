import 'package:haftaa/Library/carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:haftaa/provider/provider.dart';
import 'package:haftaa/ui/pages/add-product.dart';
import 'package:haftaa/ui/widgets/product/favorite-button.dart';
import 'package:haftaa/ui/widgets/product/product-properties/product-category-widget.dart';
import 'package:haftaa/ui/widgets/product/product-properties/product-governorate-widget.dart';
import 'package:haftaa/ui/widgets/product/product-properties/product-region-widget.dart';
import 'package:haftaa/ui/widgets/product/product-properties/product-user-widget.dart';
import 'package:haftaa/ui/widgets/product/product-speedial.dart';
import 'package:haftaa/ui/widgets/share/share-buttons.dart';
import 'package:haftaa/product/sale-product.dart';

import 'package:haftaa/ui/CartUIComponent/CartLayout.dart';
import 'package:haftaa/ui/HomeUIComponent/ChatItem.dart';

import 'package:flutter_rating/flutter_rating.dart';
import 'package:haftaa/search/search.dart';
import 'package:haftaa/ui/widgets/product/product-grid-horezontal.dart';
import 'package:haftaa/ui/pages/products-list.dart';

/// Custom Text Header
var _txtCustomHead = TextStyle(
  color: Colors.black54,
  fontSize: 17.0,
  fontWeight: FontWeight.w600,
  fontFamily: "Gotik",
);

/// Custom Text Detail
var _txtCustomSub = TextStyle(
  color: Colors.black38,
  fontSize: 13.5,
  fontWeight: FontWeight.w500,
  fontFamily: "Gotik",
);

//import 'package:haftaa/product/base-product.dart';
class SaleProductDetails extends StatefulWidget {
  final SaleProduct product;

  SaleProductDetails(this.product);

  @override
  _SaleProductDetailsState createState() => _SaleProductDetailsState();
}

/// Detail Product for Recomended Grid in home screen
class _SaleProductDetailsState extends State<SaleProductDetails> {
  static ProductSearchModel _productSearchModel;
  double rating = 3.5;
  int starCount = 5;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  /// Declaration List item HomeGridItemRe....dart Class

  _SaleProductDetailsState();

  @override
  static BuildContext ctx;
  int valueItemChart = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  /// BottomSheet for view more in specification
  void _bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Container(
                  height: 1500.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Center(
                          child: Text(
                            "نبذة",
                            style: _subHeaderCustomStyle,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
                        child: Text(widget.product.description,
                            style: _detailText),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 20.0),
                      //   child: Text(
                      //     "Spesifications :",
                      //     style: TextStyle(
                      //         fontFamily: "Gotik",
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 15.0,
                      //         color: Colors.black,
                      //         letterSpacing: 0.3,
                      //         wordSpacing: 0.5),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                      //   child: Text(
                      //     " - Lorem ipsum is simply dummy  ",
                      //     style: _detailText,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  /// Custom Text black
  static var _customTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: "Gotik",
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  /// Custom Text for Header title
  static var _subHeaderCustomStyle = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w700,
      fontFamily: "Gotik",
      fontSize: 16.0);

  /// Custom Text for Detail title
  static var _detailText = TextStyle(
      fontFamily: "Gotik",
      color: Colors.black54,
      letterSpacing: 0.3,
      wordSpacing: 0.5);

  Widget build(BuildContext context) {
    _productSearchModel = ProductSearchModel.FromSearchParams(
      categoryId: widget.product.categoryId,
      // productTypeInArabic: 'بيع'
    );

    /// Variable Component UI use in bottom layout "Top Rated Products"
    var _suggestedItem = new ProductGridHorizontal(
        searchModel: _productSearchModel,
        expectedProduct: widget.product,
        hideWidgetWhenEmpty: true);

    return Scaffold(
      floatingActionButton: new ProductSpeeDial(widget.product.user),
      key: _key,
      appBar: AppBar(
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  PageRouteBuilder(pageBuilder: (_, __, ___) => new cart()));
            },
            child: Stack(
              alignment: AlignmentDirectional(-1.0, -0.8),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SystemShareButton(
                        "ألق نظرة على ${widget.product.title} على سوق الهفتاء"),
                    WhatsappShareButton(
                        "ألق نظرة على ${widget.product.title} على سوق الهفتاء")
                  ],
                )

                // IconButton(
                //     onPressed: null,
                //     icon: Icon(
                //       Icons.shopping_cart,
                //       color: Colors.black26,
                //     )),
                // CircleAvatar(
                //   radius: 10.0,
                //   backgroundColor: Colors.red,
                //   child: Text(
                //     valueItemChart.toString(),
                //     style: TextStyle(color: Colors.white, fontSize: 13.0),
                //   ),
                // ),
              ],
            ),
          ),
        ],
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "للبيع | ${widget.product.title}",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black54,
            fontSize: 17.0,
            fontFamily: "Gotik",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// Header image slider
                  Container(
                    height: 300.0,
                    child: Hero(
                      tag: "hero-grid-${widget.product.id}",
                      child: Material(
                        child: new Carousel(
                          dotColor: Colors.black26,
                          dotIncreaseSize: 1.7,
                          dotBgColor: Colors.transparent,
                          autoplay: false,
                          boxFit: BoxFit.cover,
                          // images: [
                          //   AssetImage('assets/img/man.png'),
                          //   AssetImage('assets/img/man.png'),
                          //   AssetImage('assets/img/man.png'),
                          // ],
                          images: List.generate(widget.product.images.length,
                                  (index) {
                                return new NetworkImage(
                                    widget.product.images[index]);
                              })
                            ..add(new NetworkImage(widget.product.mainImage)),
                        ),
                      ),
                    ),
                  ),

                  /// Background white title,price and ratting
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Color(0xFF656565).withOpacity(0.15),
                        blurRadius: 1.0,
                        spreadRadius: 0.2,
                      )
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.product.title,
                            style: _customTextStyle,
                          ),
                          Padding(padding: EdgeInsets.only(top: 5.0)),
                          Text(
                            " ريال",
                            style: _customTextStyle,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10.0)),
                          Divider(
                            color: Colors.black12,
                            height: 1.0,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 30.0,
                                      width: 75.0,
                                      decoration: BoxDecoration(
                                        color: Colors.lightGreen,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            widget.product.used
                                                ? 'مستعمل'
                                                : 'جديد',
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                          Padding(
                                              padding:
                                              EdgeInsets.only(right: 8.0)),
                                          // Icon(
                                          //   Icons.star,
                                          //   color: Colors.white,
                                          //   size: 19.0,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: (Provider.of(context).auth.user !=
                                        null &&
                                        Provider.of(context).auth.user.id ==
                                            widget.product.userId)
                                        ? RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          side: BorderSide(
                                              color: Colors.teal)),
                                      color: Colors.blueAccent,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                                pageBuilder: (_, __,
                                                    ___) =>
                                                new AddProduct.edit(
                                                    widget.product)));
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Text('تعديل'),
                                          Icon(Icons.edit)
                                        ],
                                      ),
                                    )
                                        : Container()),
                                ProductFavoriteButton(widget.product),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    widget.product.formatedCreateDate,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 1.0),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  /// Background white for other product properties
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 250.0,
                      width: 600.0,
                      decoration:
                      BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                        )
                      ]),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, right: 20.0, left: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "القسم",
                                  style: _txtCustomSub,
                                ),
                                ProductCategoryWidget(
                                    widget.product.category,
                                    _txtCustomHead.copyWith(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, right: 20.0, left: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "المحافظة",
                                  style: _txtCustomSub,
                                ),
                                ProductGovernorateWidget(
                                    widget.product.governorate,
                                    _txtCustomHead.copyWith(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, right: 20.0, left: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("المنطقة", style: _txtCustomSub),
                                ProductRegionWidget(
                                    widget.product.region,
                                    _txtCustomHead.copyWith(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, right: 20.0, left: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("صاحب المنتج", style: _txtCustomSub),
                                ProductUserWidget(
                                    widget.product.user,
                                    _txtCustomHead.copyWith(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Background white for description
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 205.0,
                      width: 600.0,
                      decoration:
                      BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                        )
                      ]),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                "نبذة",
                                style: _subHeaderCustomStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0,
                                  right: 20.0,
                                  bottom: 10.0,
                                  left: 20.0),
                              child: Text(widget.product.description,
                                  style: _detailText),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  _bottomSheet();
                                },
                                child: Text(
                                  "قراءة المزيد",
                                  style: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 15.0,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// Background white for chose Size and Color
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10.0),
                  //   child: Container(
                  //     height: 220.0,
                  //     width: 600.0,
                  //     decoration:
                  //         BoxDecoration(color: Colors.white, boxShadow: [
                  //       BoxShadow(
                  //         color: Color(0xFF656565).withOpacity(0.15),
                  //         blurRadius: 1.0,
                  //         spreadRadius: 0.2,
                  //       )
                  //     ]),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Text("Size", style: _subHeaderCustomStyle),
                  //           Row(
                  //             children: <Widget>[
                  //               RadioButtonCustom(
                  //                 txt: "S",
                  //               ),
                  //               Padding(padding: EdgeInsets.only(right: 15.0)),
                  //               RadioButtonCustom(
                  //                 txt: "M",
                  //               ),
                  //               Padding(padding: EdgeInsets.only(right: 15.0)),
                  //               RadioButtonCustom(
                  //                 txt: "L",
                  //               ),
                  //               Padding(padding: EdgeInsets.only(right: 15.0)),
                  //               RadioButtonCustom(
                  //                 txt: "XL",
                  //               ),
                  //             ],
                  //           ),
                  //           Padding(padding: EdgeInsets.only(top: 15.0)),
                  //           Divider(
                  //             color: Colors.black12,
                  //             height: 1.0,
                  //           ),
                  //           Padding(padding: EdgeInsets.only(top: 10.0)),
                  //           Text(
                  //             "Color",
                  //             style: _subHeaderCustomStyle,
                  //           ),
                  //           Row(
                  //             children: <Widget>[
                  //               RadioButtonColor(Colors.black),
                  //               Padding(padding: EdgeInsets.only(right: 15.0)),
                  //               RadioButtonColor(Colors.white),
                  //               Padding(padding: EdgeInsets.only(right: 15.0)),
                  //               RadioButtonColor(Colors.blue),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //new ProductComments(),

                  _suggestedItem
                ],
              ),
            ),
          ),

          /// If user click icon chart SnackBar show
          /// this code to show a SnackBar
          /// and Increase a valueItemChart + 1
          InkWell(
            onTap: () {
              var snackbar = SnackBar(
                content: Text("Item Added"),
              );
              setState(() {
                valueItemChart++;
              });
              _key.currentState.showSnackBar(snackbar);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          color: Colors.white12.withOpacity(0.1),
                          border: Border.all(color: Colors.black12)),
                      child: Center(
                        child: Image.asset(
                          "assets/icon/shopping-cart.png",
                          height: 23.0,
                        ),
                      ),
                    ),

                    /// Chat Icon
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, ___, ____) => new chatItem()));
                      },
                      child: Container(
                        height: 40.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                            color: Colors.white12.withOpacity(0.1),
                            border: Border.all(color: Colors.black12)),
                        child: Center(
                          child: Image.asset("assets/icon/message.png",
                              height: 20.0),
                        ),
                      ),
                    ),

                    /// Button Pay
                    InkWell(
                      onTap: () {
                        widget.product.user.then((user) {
                          ProductSearchModel _searchModel =
                          ProductSearchModel.FromSearchParams(
                              userID: user.id);

                          Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                new ProductList.Search(_searchModel,
                                    'المستخدم (${user.name})'),
                                transitionDuration: Duration(milliseconds: 600),
                                transitionsBuilder: (_,
                                    Animation<double> animation,
                                    __,
                                    Widget child) {
                                  return Opacity(
                                    opacity: animation.value,
                                    child: child,
                                  );
                                }),
                          );
                        });
                      },
                      child: Container(
                        height: 45.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                        ),
                        child: Center(
                            child: ProductUserWidget(
                                widget.product.user,
                                TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700))
                          // Text(
                          //   "Pay",
                          //   style: TextStyle(
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.w700),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRating(
      String date, String details, Function changeRating, String image) {
    return ListTile(
      leading: Container(
        height: 45.0,
        width: 45.0,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
      ),
      title: Row(
        children: <Widget>[
          StarRating(
              size: 20.0,
              rating: 3.5,
              starCount: 5,
              color: Colors.yellow,
              onRatingChanged: changeRating),
          SizedBox(width: 8.0),
          Text(
            date,
            style: TextStyle(fontSize: 12.0),
          )
        ],
      ),
      subtitle: Text(
        details,
        style: _detailText,
      ),
    );
  }
}

/// RadioButton for item choose in size
class RadioButtonCustom extends StatefulWidget {
  String txt;

  RadioButtonCustom({this.txt});

  @override
  _RadioButtonCustomState createState() => _RadioButtonCustomState(this.txt);
}

class _RadioButtonCustomState extends State<RadioButtonCustom> {
  _RadioButtonCustomState(this.txt);

  String txt;
  bool itemSelected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        onTap: () {
          setState(() {
            if (itemSelected == false) {
              setState(() {
                itemSelected = true;
              });
            } else if (itemSelected == true) {
              setState(() {
                itemSelected = false;
              });
            }
          });
        },
        child: Container(
          height: 37.0,
          width: 37.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: itemSelected ? Colors.black54 : Colors.indigoAccent),
              shape: BoxShape.circle),
          child: Center(
            child: Text(
              txt,
              style: TextStyle(
                  color: itemSelected ? Colors.black54 : Colors.indigoAccent),
            ),
          ),
        ),
      ),
    );
  }
}

/// RadioButton for item choose in color
class RadioButtonColor extends StatefulWidget {
  Color clr;

  RadioButtonColor(this.clr);

  @override
  _RadioButtonColorState createState() => _RadioButtonColorState(this.clr);
}

class _RadioButtonColorState extends State<RadioButtonColor> {
  bool itemSelected = true;
  Color clr;

  _RadioButtonColorState(this.clr);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        onTap: () {
          if (itemSelected == false) {
            setState(() {
              itemSelected = true;
            });
          } else if (itemSelected == true) {
            setState(() {
              itemSelected = false;
            });
          }
        },
        child: Container(
          height: 37.0,
          width: 37.0,
          decoration: BoxDecoration(
              color: clr,
              border: Border.all(
                  color: itemSelected ? Colors.black26 : Colors.indigoAccent,
                  width: 2.0),
              shape: BoxShape.circle),
        ),
      ),
    );
  }
}

/// Class for card product in "Top Rated Products"
class FavoriteItem extends StatelessWidget {
  String image, Rating, Salary, title, sale;

  FavoriteItem({this.image, this.Rating, this.Salary, this.title, this.sale});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 4.0,
                spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
              )
            ]),
        child: Wrap(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.0),
                          topRight: Radius.circular(7.0)),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover)),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.black54,
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 1.0)),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                  child: Text(
                    Salary,
                    style: TextStyle(
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(right: 15.0, left: 15.0, top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            Rating,
                            style: TextStyle(
                                fontFamily: "Sans",
                                color: Colors.black26,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14.0,
                          )
                        ],
                      ),
                      Text(
                        sale,
                        style: TextStyle(
                            fontFamily: "Sans",
                            color: Colors.black26,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.black12,
  );
}
