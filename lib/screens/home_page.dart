import 'package:core_flutter_11am/utils/all_product_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selDropDownValue;

  RangeValues values = const RangeValues(0, 1750);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("cart_page");
              },
              child: Badge(
                label: Text(
                  "${ProductData.cartProductData.length}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    DropdownButton(
                      onChanged: (val) {
                        setState(() {
                          selDropDownValue = val as String;
                        });
                      },
                      hint: const Text(
                        "Select category...",
                        style: TextStyle(fontSize: 18),
                      ),
                      value: selDropDownValue,
                      items: ProductData.allProductsData
                          .map(
                            (e) => DropdownMenuItem(
                              value: e['categoryName'],
                              child: Text(
                                e['categoryName'],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(width: 10),
                    (selDropDownValue != null)
                        ? ActionChip(
                            onPressed: () {
                              setState(() {
                                selDropDownValue = null;
                                values = const RangeValues(0, 1750);
                              });
                            },
                            avatar: const Icon(Icons.close),
                            label: const Text("Clear"),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (selDropDownValue != null)
                        ? Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "From",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "\$ ${values.start.toInt()}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: RangeSlider(
                                    min: 0,
                                    max: 1750,
                                    values: values,
                                    onChanged: (RangeValues val) {
                                      setState(() {
                                        values = val;
                                      });
                                    },
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "To",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "\$ ${values.end.toInt()}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    ...ProductData.allProductsData.map(
                      (val) =>
                          ((selDropDownValue == val['categoryName']) ||
                                  selDropDownValue == null)
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  width: double.infinity,
                                  height: 400,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${val['categoryName']}",
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 16,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ...val['categoryProducts'].map(
                                                  (Map<String, dynamic> e) {
                                                return (e['price'] >=
                                                            values.start &&
                                                        e['price'] <=
                                                            values.end)
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "detail_page",
                                                                  arguments: e);
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 5,
                                                            bottom: 5,
                                                            left: 5,
                                                            right: 15,
                                                          ),
                                                          width: 220,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        22),
                                                            boxShadow: <BoxShadow>[
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                                spreadRadius: 2,
                                                                blurRadius: 2,
                                                                offset:
                                                                    const Offset(
                                                                        0, 2),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        "${e['thumbnail']}",
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              22),
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child:
                                                                      Container(
                                                                    height: 42,
                                                                    width: 85,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: Colors
                                                                          .red,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(22),
                                                                        bottomRight:
                                                                            Radius.circular(12),
                                                                      ),
                                                                    ),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      "${e['discountPercentage']}%",
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          12),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .vertical(
                                                                      bottom: Radius
                                                                          .circular(
                                                                              22),
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${e['title']}",
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "\$ ${e['price']}",
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      RatingBar(
                                                                        initialRating:
                                                                            double.parse(
                                                                          e["rating"]
                                                                              .toString(),
                                                                        ),
                                                                        direction:
                                                                            Axis.horizontal,
                                                                        allowHalfRating:
                                                                            true,
                                                                        itemCount:
                                                                            5,
                                                                        itemSize:
                                                                            18,
                                                                        ignoreGestures:
                                                                            true,
                                                                        ratingWidget:
                                                                            RatingWidget(
                                                                          full:
                                                                              const Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Colors.amber,
                                                                          ),
                                                                          half:
                                                                              const Icon(
                                                                            Icons.star_half,
                                                                            color:
                                                                                Colors.amber,
                                                                          ),
                                                                          empty:
                                                                              const Icon(
                                                                            Icons.star_border,
                                                                            color:
                                                                                Colors.amber,
                                                                          ),
                                                                        ),
                                                                        onRatingUpdate:
                                                                            (double
                                                                                rating) {},
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Container();
                                              }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
