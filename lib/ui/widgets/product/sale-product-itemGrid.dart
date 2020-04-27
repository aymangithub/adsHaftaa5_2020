import 'package:flutter/material.dart';
import 'package:haftaa/ui/pages/sale-product-details.dart';
import 'package:haftaa/ui/theme/theme.dart';
import 'package:haftaa/product/sale-product.dart';

class SaleProductItemGrid extends StatefulWidget {
  SaleProduct productItem;
  SaleProductItemGrid(this.productItem);

  @override
  _ProductItemGridState createState() => _ProductItemGridState();
}

class _ProductItemGridState extends State<SaleProductItemGrid> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
            new SaleProductDetails(widget.productItem),
            transitionDuration: Duration(milliseconds: 900),

            /// Set animation Opacity in route to detailProduk layout
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            }));
      },
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
                /// Set Animation image to detailProduk layout
                Hero(
                  tag: "hero-grid-${widget.productItem.id}",
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return new Material(
                                color: Colors.black54,
                                child: Container(
                                  padding: EdgeInsets.all(30.0),
                                  child: InkWell(
                                    child: Hero(
                                        tag:
                                        "hero-grid-${widget.productItem.id}",
                                        child: Image.network(
                                            widget.productItem.mainImage)

                                      // Image.asset(
                                      //   productItem.img,
                                      //   width: 300.0,
                                      //   height: 300.0,
                                      //   alignment: Alignment.center,
                                      //   fit: BoxFit.contain,
                                      // )

                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },
                            transitionDuration: Duration(milliseconds: 500)));
                      },
                      child: Container(
                        height: mediaQueryData.size.height / 3.3,
                        width: 200.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7.0),
                                topRight: Radius.circular(7.0)),
                            image: DecorationImage(
                                image: new NetworkImage(
                                    widget.productItem.mainImage),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 7.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    widget.productItem.title,
                    overflow: TextOverflow.ellipsis,
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
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    widget.productItem.price == null
                        ? '0'
                        : widget.productItem.price.toString(),
                    //'productItem.price',

                    style: TextStyle(
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            widget.productItem.formatedCreateDate,
                            style: TextStyle(
                                fontFamily: "Sans",
                                color: Colors.black26,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          ),
                          // Icon(
                          //   Icons.star,
                          //   color: Colors.yellow,
                          //   size: 14.0,
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            widget.productItem.arabicTypeName == null
                                ? ''
                                : widget.productItem.arabicTypeName,
                            style: TextStyle(
                                fontFamily: "Sans",
                                color: saleItemsColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          ),
                          // ProductGovernorateWidget(
                          //     widget.productItem.governorate,
                          //     TextStyle(
                          //         fontFamily: "Sans",
                          //         color: Colors.black26,
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 12.0)),
                          //         Text(' | '),
                          // ProductRegionWidget(
                          //     widget.productItem.region,
                          //     TextStyle(
                          //         fontFamily: "Sans",
                          //         color: Colors.black26,
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 12.0))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
