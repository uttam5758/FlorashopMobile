import 'package:badges/badges.dart';
import 'package:cybershop/models/cart_model.dart';
import 'package:cybershop/screens/cart/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        // backgroundColor: const Color.fromARGB(255, 14, 234, 117),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
                future: cart.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage('assets/image/cart.png'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Your cart is empty 😌',
                                style: Theme.of(context).textTheme.titleLarge),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                'Explore products and shop your\nfavourite items',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall)
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Image(
                                            height: 100,
                                            width: 100,
                                            image: NetworkImage(snapshot
                                                .data![index].image
                                                .toString()),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot.data![index]
                                                          .productName
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          dbHelper!.delete(
                                                              snapshot
                                                                  .data![index]
                                                                  .id!);
                                                          cart.removerCounter();
                                                          cart.removeTotalPrice(
                                                              double.parse(snapshot
                                                                  .data![index]
                                                                  .productPrice
                                                                  .toString()));
                                                        },
                                                        child:
                                                            Icon(Icons.delete))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  snapshot.data![index].unitTag
                                                          .toString() +
                                                      " " +
                                                      r"$" +
                                                      snapshot.data![index]
                                                          .productPrice
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(255, 14,
                                                              234, 117),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  int quantity = snapshot
                                                                      .data![
                                                                          index]
                                                                      .quantity!;
                                                                  int price = snapshot
                                                                      .data![
                                                                          index]
                                                                      .initialPrice!;
                                                                  quantity--;
                                                                  int?
                                                                      newPrice =
                                                                      price *
                                                                          quantity;

                                                                  if (quantity >
                                                                      0) {
                                                                    dbHelper!
                                                                        .updateQuantity(Cart(
                                                                            id: snapshot.data![index].id!,
                                                                            productId: snapshot.data![index].id!.toString(),
                                                                            productName: snapshot.data![index].productName!,
                                                                            initialPrice: snapshot.data![index].initialPrice!,
                                                                            productPrice: newPrice,
                                                                            quantity: quantity,
                                                                            unitTag: snapshot.data![index].unitTag.toString(),
                                                                            image: snapshot.data![index].image.toString()))
                                                                        .then((value) {
                                                                      newPrice =
                                                                          0;
                                                                      quantity =
                                                                          0;
                                                                      cart.removeTotalPrice(double.parse(snapshot
                                                                          .data![
                                                                              index]
                                                                          .initialPrice!
                                                                          .toString()));
                                                                    }).onError((error, stackTrace) {
                                                                      print(error
                                                                          .toString());
                                                                    });
                                                                  }
                                                                },
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            Text(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .quantity
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                            InkWell(
                                                                onTap: () {
                                                                  int quantity = snapshot
                                                                      .data![
                                                                          index]
                                                                      .quantity!;
                                                                  int price = snapshot
                                                                      .data![
                                                                          index]
                                                                      .initialPrice!;
                                                                  quantity++;
                                                                  int?
                                                                      newPrice =
                                                                      price *
                                                                          quantity;

                                                                  dbHelper!
                                                                      .updateQuantity(Cart(
                                                                          id: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .id!,
                                                                          productId: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .id!
                                                                              .toString(),
                                                                          productName: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .productName!,
                                                                          initialPrice: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .initialPrice!,
                                                                          productPrice:
                                                                              newPrice,
                                                                          quantity:
                                                                              quantity,
                                                                          unitTag: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .unitTag
                                                                              .toString(),
                                                                          image: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .image
                                                                              .toString()))
                                                                      .then(
                                                                          (value) {
                                                                    newPrice =
                                                                        0;
                                                                    quantity =
                                                                        0;
                                                                    cart.addTotalPrice(double.parse(snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!
                                                                        .toString()));
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    print(error
                                                                        .toString());
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  }
                  return Text('');
                }),
            Consumer<CartProvider>(
              builder: (context, value, child) {
                return Visibility(
                  visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                      ? false
                      : true,
                  child: Column(
                    children: [
                      ReusableWidget(
                        title: 'Sub Total',
                        value: r'$' + value.getTotalPrice().toStringAsFixed(2),
                      ),
                      ReusableWidget(
                        title: 'Offer Price ',
                        value: r'$' + '0',
                      ),
                      ReusableWidget(
                        title: 'Total',
                        value: r'$' + value.getTotalPrice().toStringAsFixed(2),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/shipping');
                        },
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: const Color.fromARGB(255, 14, 234, 117),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60.0, vertical: 13.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: const Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
