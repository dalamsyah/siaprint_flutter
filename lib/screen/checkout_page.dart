
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/finishing_model.dart';
import 'package:siapprint/model/inks_model.dart';
import 'package:siapprint/model/price_model.dart';
import 'package:siapprint/model/size_model.dart';
import 'package:siapprint/model/transaction_model.dart';
import 'package:siapprint/repository/form_service.dart';
import 'package:siapprint/screen/form_print_page.dart';

class CheckoutPage extends StatefulWidget {

  const CheckoutPage({ Key? key, required this.transactionModel }) : super(key: key);

  static String tag = 'checkout-page';
  final TransactionModel transactionModel;

  @override
  State<StatefulWidget> createState() => _CheckoutPage();

}

class _CheckoutPage extends State<CheckoutPage> {

  int? _delivery = 0;
  int _totalPrint = 0;
  int _totalDelivery = 0;
  int _total = 0;

  // TransactionModel transactionModel = TransactionModel(listBasketModel: widget.listBasketModel, total_print: _totalPrint, delivery_id: _delivery, delivery_code: '', total: _total)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: ListView.separated(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: widget.transactionModel.listBasketModel.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    elevation: 3,
                    child: InkWell(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(child: Text('${widget.transactionModel.listBasketModel[index].filename}')),
                              IconButton(onPressed: (){
                                setState((){
                                  widget.transactionModel.listBasketModel.remove(widget.transactionModel.listBasketModel[index]);
                                });
                                // widget.transactionModel.listBasketModel
                                print(widget.transactionModel.listBasketModel.length);
                                print(widget.transactionModel.listBasketModel);
                              }, icon: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                              context: context, builder: (BuildContext context) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height ,
                              child: FormPrintPage(
                                basketModel: widget.transactionModel.listBasketModel[index],
                              ),
                            );
                          });
                        }
                    )
                );

              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            )),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.grey.withAlpha(50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total print: '),
                        Text('Rp ${_totalPrint}')
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Text('Pilih pengiriman'),
                    color: Colors.grey.withAlpha(50),
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _delivery,
                        onChanged: (value) {
                          setState(() {
                            _delivery = value as int?;
                          });
                        },
                      ),
                      const Text(
                        "Pickup by customer",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _delivery,
                        onChanged: (value) {
                          setState(() {
                            _delivery = value as int?;
                          });
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Delivery by JNE",
                          ),
                          Text('Total biaya pengiriman: Rp $_totalDelivery')
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.grey.withAlpha(50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total: '),
                        Text('Rp $_total')
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 2
                ),
                onPressed: () {},
                // onPressed: _onSelectCheckBox(),
                child: Text('Proses'),
              ),
            )
          ],
        ),
      ),
    );
  }



}