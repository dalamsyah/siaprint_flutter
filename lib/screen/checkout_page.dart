
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/finishing_model.dart';
import 'package:siapprint/model/inks_model.dart';
import 'package:siapprint/model/price_model.dart';
import 'package:siapprint/model/size_model.dart';
import 'package:siapprint/model/transaction_model.dart';
import 'package:siapprint/repository/checkout_service.dart';
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

  late TransactionModel transactionModel;
  final DeliveryService _deliveryService = DeliveryService();

  int? _delivery = 0;
  int _totalPrint = 0;
  int _totalDelivery = 0;
  int _total = 0;

  @override
  void initState() {
    transactionModel = widget.transactionModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _total = _totalPrint + _totalDelivery;

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
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(child: Text('${transactionModel.listBasketModel[index].filename}')),
                              IconButton(onPressed: (){
                                setState((){
                                  transactionModel.listBasketModel.remove(transactionModel.listBasketModel[index]);
                                });
                                // widget.transactionModel.listBasketModel
                                print(transactionModel.listBasketModel.length);
                                print(transactionModel.listBasketModel);
                              }, icon: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context, builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                          height: 4,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(25.0),
                                                topRight: Radius.circular(25.0),
                                                bottomLeft: Radius.circular(25.0),
                                                bottomRight: Radius.circular(25.0)
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        child: FormPrintPage(
                                          basketModel: transactionModel.listBasketModel[index],
                                          callback: (basketModel) {
                                            // transactionModel.listBasketModel[index] = basketModel;

                                            setState((){
                                              _totalPrint = 0;

                                              transactionModel.listBasketModel.forEach((element) {
                                                _totalPrint += element.total;
                                              });

                                              print(transactionModel.toString());

                                            });

                                          },
                                        )
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                        }
                    )
                );

              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.grey.withAlpha(50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total print: '),
                      Text('Rp ${_totalPrint}')
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: const Text('Pilih pengiriman'),
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
                    InkWell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Delivery by JNE",
                          ),
                          Text('Total biaya pengiriman: Rp $_totalDelivery')
                        ],
                      ),
                      onTap: (){
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context, builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.50,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        height: 4,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(25.0),
                                              topRight: Radius.circular(25.0),
                                              bottomLeft: Radius.circular(25.0),
                                              bottomRight: Radius.circular(25.0)
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                      child:
                                        FutureBuilder<Response>(
                                          future: _deliveryService.getDelivery(),
                                          builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {

                                            if (snapshot.hasData){

                                              final data = jsonDecode(snapshot.data!.body);
                                              var list = data['result']['result_detail'] as List;

                                              return Scaffold(
                                                body: ListView.builder(
                                                    itemCount: list.length,
                                                    itemBuilder: (BuildContext content, int index) {

                                                      String cost = list[index]['cost'][0]['value'].toString();
                                                      double persenUp = double.parse(data['result']['percent_up']);
                                                      double persen = int.parse(cost) * persenUp;

                                                      double a = int.parse(cost) + persen;
                                                      int ongkir = a.toInt();

                                                  return Container(
                                                    padding: EdgeInsets.all(20),
                                                    child: Row(
                                                  children: [
                                                    Expanded(child:
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('Jenis: ${list[index]['service']}'),
                                                            Text('Waktu: ${list[index]['cost'][0]['etd']} hari'),
                                                            Text('Biaya: Rp $ongkir')
                                                          ],
                                                        )
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          elevation: 2
                                                      ),
                                                      onPressed: () {
                                                        setState((){
                                                          _totalDelivery = ongkir;
                                                          _delivery = 2;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      // onPressed: _onSelectCheckBox(),
                                                      child: const Text('Pilih'),
                                                    )
                                                  ],
                                                  ),
                                                  );
                                                })
                                              );
                                            } else if (snapshot.hasError){
                                              return Center(child: Text('error..${snapshot.error}'));
                                            }

                                            return Scaffold(
                                              body: Center(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                    CircularProgressIndicator(),
                                                    SizedBox(height: 10,),
                                                    Text('Please wait...')
                                                  ],
                                                ),
                                              ),
                                            );

                                          }
                                      ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.grey.withAlpha(50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total: '),
                      Text('Rp $_total')
                    ],
                  ),
                ),
              ],
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 2
                ),
                onPressed: () {

                  String errorMsg = '';
                  if (_delivery == 0) {
                    errorMsg = 'Pengiriman harus dipilih';
                  }

                  if (errorMsg != ''){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(errorMsg),
                    ));
                  } else {

                    _deliveryService.saveTransaction(transactionModel);

                  }

                },
                // onPressed: _onSelectCheckBox(),
                child: const Text('Proses'),
              ),
            )
          ],
        ),
      ),
    );
  }



}