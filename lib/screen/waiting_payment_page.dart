import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siapprint/model/payment_type_model.dart';
import 'package:siapprint/repository/status_service.dart';
import 'package:siapprint/config/format_number.dart';

class WaitingPaymentPage extends StatefulWidget {

  const WaitingPaymentPage({ Key? key, this.data }) : super(key: key);

  static String tag = 'waiting-payment-page';
  final String? data;

  @override
  State<StatefulWidget> createState() => _WaitingPaymentPage();

}

class _WaitingPaymentPage extends State<WaitingPaymentPage> {

  String payment_no = '';
  String total_amount = '';
  String phone_no = '';
  PaymentTypeModel? paymentTypeModel;
  bool _isLoading = false;

  final StatusService _statusService = StatusService();

  @override
  void initState() {
    super.initState();

    final json = jsonDecode(widget.data!);
    payment_no = json['payment_no'];
    total_amount = json['total_amount'];
    phone_no = json['phone_no'];
    paymentTypeModel = PaymentTypeModel.fromJson2(json['paymentTypeModel']);

    setState((){
      _isLoading = true;
    });

    _statusService.payment(paymentTypeModel!, payment_no, total_amount, phone_no).then((value) {
      setState((){
        _isLoading = false;
      });
      print(value);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                  child: Column(
                    children: [
                      Text('Pembayaran $payment_no dengan Total ${MyNumber.convertToIdr(double.parse(total_amount))} telah dikirim ke ${paymentTypeModel!.payment_type_name} dengan nomor $phone_no', style: const TextStyle(fontSize: 20),),
                    ],
                  )
              ),
              _isLoading ? Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 10,),
                  Text('Menunggu pembayaran..')
                ],
              )) : Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset('assets/ic_thankyou_payment.png'),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Pembayaran berhasil', style: TextStyle(fontSize: 20))
                ],
              )),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: Colors.transparent)
                          )
                      )
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Tutup'),
                  // child: _isLoading ? const CircularProgressIndicator() : const Text('Log In'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}