
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/finishing_model.dart';
import 'package:siapprint/model/inks_model.dart';
import 'package:siapprint/model/price_model.dart';
import 'package:siapprint/model/size_model.dart';
import 'package:siapprint/repository/form_service.dart';
import 'package:siapprint/screen/form_print_page.dart';

class CheckoutPage extends StatefulWidget {

  const CheckoutPage({ Key? key, required this.listBasketModel }) : super(key: key);

  static String tag = 'checkout-page';
  final List<BasketModel> listBasketModel;

  @override
  State<StatefulWidget> createState() => _CheckoutPage();

}

class _CheckoutPage extends State<CheckoutPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: widget.listBasketModel.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 3,
            child: InkWell(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(child: Text('${widget.listBasketModel[index].filename}')),
                      IconButton(onPressed: (){

                      }, icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: (BuildContext context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height ,
                      child: FormPrintPage(),
                    );
                  });
                }
            )
          );

        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }



}