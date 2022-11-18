import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:siapprint/config/format_number.dart';
import 'package:siapprint/model/payment_type_model.dart';
import 'package:siapprint/model/status_detail_date_model.dart';
import 'package:siapprint/model/status_detail_model.dart';
import 'package:siapprint/model/status_model.dart';
import 'package:siapprint/repository/status_service.dart';
import 'package:siapprint/screen/waiting_payment_page.dart';

class StatusPage extends StatefulWidget {

  static String tag = 'status-page';

  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatusPage();

}

class _StatusPage extends State<StatusPage> {

  final StatusService _statusService = StatusService();
  String _statuscode = 'Sedang berjalan';
  final bool _isLoading = false;
  final TextEditingController _controllerNoHp = TextEditingController();

  List<StatusModel> _listStatus = [];

  Future<void>? _initStatusData;

  Future<void> _initStatus() async {
    final list = await _statusService.getListStatus(_statuscode);
    _listStatus = list;
  }

  Future<void> _refreshStatus() async {
    final list = await _statusService.getListStatus(_statuscode);
    setState(() {
      _listStatus = list;
    });
  }

  @override
  void initState() {
    super.initState();

    _controllerNoHp.text = '';
    _initStatusData = _initStatus();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [

                  Expanded(child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: const Text('Sedang berjalan',),
                          ),
                          _statuscode.contains('Sedang berjalan') ? Container(height: 2, color: Colors.lightBlue, width: double.infinity,) : Container(height: 2, color: Colors.white38, width: double.infinity,)
                        ],
                      ),
                    ),
                    onTap: () {
                      setState((){
                        _statuscode = 'Sedang berjalan';
                      });
                      _refreshStatus();
                    },
                  )),

                  Expanded(child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: const Text('Selesai',),
                          ),
                          _statuscode.contains('Selesai') ? Container(height: 2, color: Colors.lightBlue, width: double.infinity,) : Container(height: 2, color: Colors.white38, width: double.infinity,)
                        ],
                      ),
                    ),
                    onTap: () {
                      setState((){
                        _statuscode = 'Selesai';
                      });
                      _refreshStatus();
                    },
                  )),

                ],
              ),
            ),

            Expanded(
                child: FutureBuilder(
                    future: _initStatusData,
                    builder: (BuildContext context, snapshot) {

                      switch (snapshot.connectionState) {
                        case ConnectionState.active: {
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
                        case ConnectionState.done: {

                          if (_listStatus.isEmpty) {
                            return Scaffold(
                              body: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text('No data')
                                  ],
                                ),
                              ),
                            );
                          }

                          return RefreshIndicator(
                            onRefresh: _refreshStatus,
                            child: ListView.separated(
                            itemCount: _listStatus.length,
                            itemBuilder: (BuildContext content, int index) {

                              final detail = _listStatus[index].status_detail as List;
                              final dateDetail = _listStatus[index].status_detail_date as List;
                              final listDetail = detail.map((data) => StatusDetailModel.fromJson2(data) ).toList();
                              final listDateDetail = dateDetail.map((data) => StatusDetailDateModel.fromJson2(data) ).toList();
                              final list = _listStatus;

                              return InkWell(
                                onTap: () {
                                  onClickStatus(list[index], listDetail, listDateDetail);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Text('ID: ${list[index].print_h_code} | ${list[index].company_name}'),
                                      Text('${list[index].comp_address}, ${list[index].regencies_name}, ${list[index].provinces_name}',
                                        style: const TextStyle(fontSize: 12),),

                                      const SizedBox(height: 20,),

                                      SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Pengiriman: ${list[index].delv_name}'),
                                            Text('Penerima: ${list[index].shipp_receiver}'),
                                          ],
                                        )
                                      ),

                                      const SizedBox(height: 20,),

                                      SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            '${list[index].created_at} | '
                                                '${list[index].ntgew_h} | '
                                                '${list[index].ntgew_uom_h} | '
                                                '${MyNumber.convertToIdr(double.parse(list[index].amount_p!))} | '
                                                '${MyNumber.convertToIdr(double.parse(list[index].delv_cost!))} | '
                                                '${MyNumber.convertToIdr(double.parse(list[index].amount_h!))}', style: const TextStyle(fontSize: 12),)
                                      ),

                                      const SizedBox(height: 10,),

                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            statusWidget(list[index].trsc_h_status_text!),

                                            buttonPayment(list[index].trsc_h_status_text!, list[index].print_h_code!, list[index].amount_h!),

                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );

                            }, separatorBuilder: (BuildContext context, int index) => const Divider(),),
                          );
                        }
                        case ConnectionState.none:
                          break;
                        case ConnectionState.waiting:
                          break;
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

                    })
            )

          ],
        ),
      )
    );
  }

  onClickStatus(StatusModel model, List<StatusDetailModel> listDetail, List<StatusDetailDateModel> listDateDetail) {
    showModalBottomSheet(backgroundColor: Colors.transparent, isScrollControlled: true, context: context, builder: (BuildContext context) {
      return StatefulBuilder(builder: (BuildContext context, setState){
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: SingleChildScrollView(
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


                  model.delv_name!.contains('Pickup') ? Container() : Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        child: const Text('Alamat penerima', textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold),),
                      ),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${model.shipp_receiver}'),
                            Text('${model.shipp_phone}'),
                            Text('${model.shipp_address}, ${model.shipp_postcode}'),
                            Text('Resi: ${model.delv_text2 ?? '-'}'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20,),
                    ],
                  ),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: const Text('Keterangan', textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold),),
                  ),

                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: List.generate(listDateDetail.length, (index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          color: index % 2 == 0 ? Colors.grey.withOpacity(0.2) : Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${listDateDetail[index].text}'),
                              const SizedBox(width: 20,),
                              Text(listDateDetail[index].date ?? '-')
                            ],
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: const Text('Files', textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold),),
                  ),

                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: List.generate(listDetail.length, (index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.grey.withOpacity(0.2),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(child: Text('${listDetail[index].filename}'))
                                ],
                              ),
                            ),
                            Padding(padding: const EdgeInsets.all(10), child:
                            Table(
                              columnWidths: const {
                                0: FlexColumnWidth(10),
                                1: FlexColumnWidth(20),
                              },
                              children: [
                                TableRow(
                                    children: [
                                      const Text('Tipe printer'),
                                      Text(': ${listDetail[index].ink_name}')
                                    ]
                                ),
                                TableRow(
                                    children: [
                                      const Text('Jenis kertas'),
                                      Text(': ${listDetail[index].size_name}')
                                    ]
                                ),
                                TableRow(
                                    children: [
                                      const Text('Ukuran kertas'),
                                      Text(': ${listDetail[index].type_paper_name}')
                                    ]
                                ),
                                TableRow(
                                    children: [
                                      const Text('Finishing'),
                                      Text(': ${listDetail[index].finish_text}')
                                    ]
                                ),
                                TableRow(
                                    children: [
                                      const Text('Copy'),
                                      Text(': ${listDetail[index].copy}')
                                    ]
                                ),
                                TableRow(
                                    children: [
                                      const Text('Total halaman'),
                                      Text(': ${listDetail[index].total_pages}')
                                    ]
                                ),
                                TableRow(
                                    children: [
                                      const Text('Print halaman'),
                                      Text(': ${listDetail[index].pages_remarks}')
                                    ]
                                ),
                                TableRow(
                                    children: [
                                      const Text('Total berat:'),
                                      Text(': ${listDetail[index].ntgew_d}kg')
                                    ]
                                ),
                                TableRow(
                                    children: [
                                      const Text('Total harga'),
                                      Text(': ${MyNumber.convertToIdr(double.parse(listDetail[index].amount_d!))}')
                                    ]
                                ),
                                TableRow(
                                    children: [
                                      const Text('Catatan'),
                                      Text(': ${listDetail[index].remarks_d != '' ? listDetail[index].remarks_d : '-'}')
                                    ]
                                ),
                              ],
                            ),),
                          ],
                        );
                      }),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      });
    });
  }

  showProgress() {
    if (_isLoading){
      Dialogs.materialDialog(
          context: context,
          barrierDismissible: false,
          actions: [
            Container(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 10,),
                  Text('Mohon tunggu'),
                ],
              ),
            )
          ]
      );
    }
  }

  btnPayment(PaymentTypeModel paymentTypeModel, String  paymentNo, String totalAmount) {

    var logoPayment = Container();
    if (paymentTypeModel.payment_type_name!.contains('OVO')){
      logoPayment = Container(
        height: 25,
        child: Image.asset('assets/ic_ovo.png'),
      );
    } else if (paymentTypeModel.payment_type_name!.contains('GOPAY')) {
      logoPayment = Container(
        height: 25,
        child: Image.asset('assets/ic_gopay.png'),
      );
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: OutlinedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.7)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(color: Colors.transparent)
                )
            )
        ),
        onPressed: () {

          final data = {
            'payment_no': paymentNo,
            'total_amount': totalAmount,
            'phone_no': _controllerNoHp.text,
            'paymentTypeModel': paymentTypeModel.toJson(),
          };

          // Navigator.of(context).pushNamed(WaitingPaymentPage.tag, arguments: jsonEncode(data));
          // Navigator.of(context).pushReplacementNamed(WaitingPaymentPage.tag, arguments: jsonEncode(data));

          Navigator.of(context).pop();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
            return WaitingPaymentPage(data: jsonEncode(data),);
          }));

          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
          //   return WaitingPaymentPage(data: jsonEncode(data),);
          // }), (r){
          //   return false;
          // });

          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (BuildContext context) => const WaitingPaymentPage()),
          //     ModalRoute.withName(SingleNavigationPage.tag),
          // );

        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${paymentTypeModel.payment_type_text}'),
              const SizedBox(width: 20,),
              logoPayment
            ],
          ),
        ),
        // child: _isLoading ? const CircularProgressIndicator() : const Text('Log In'),
      ),
    );
  }

  buttonPayment(String status, String printHCode, String total){

    final noHp = TextFormField(
      controller: _controllerNoHp,
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'No Hp',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    if (status.contains('Menunggu pembayaran')){
      return Row(
        children: [
          ElevatedButton(
              onPressed: (){
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context, builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
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

                          Container(
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pembayaran $printHCode', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold) ),
                                  Text('Total ${MyNumber.convertToIdr(double.parse(total))}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                                  const SizedBox(height: 10,),
                                  noHp,
                                  const SizedBox(height: 10,),

                                  Column(
                                    children: List.generate(_statusService.paymentTypeList.length, (index) {
                                      return btnPayment(_statusService.paymentTypeList[index], printHCode, total);
                                    }),
                                  ),

                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text('Bayar')
          ),
          const SizedBox(width: 10,),
          ElevatedButton(
              onPressed: (){

                Dialogs.materialDialog(
                    context: context,
                    msg: 'Batalkan transaksi $printHCode?',
                    title: 'Transaksi',
                    color: Colors.white,
                    actions: [
                      IconsOutlineButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Tidak',
                        textStyle: const TextStyle(color: Colors.grey),
                      ),
                      IconsButton(
                        onPressed: () {
                          Navigator.of(context).pop();

                          progressDialog(true, context);

                          _statusService.cancelTransaction(printHCode).then((value) {

                            progressDialog(false, context);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(value),
                            ));

                            _refreshStatus();

                          });

                        },
                        text: 'Ya',
                        color: Colors.red,
                        textStyle: const TextStyle(color: Colors.white),
                      ),
                    ]
                );

              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text('Batal')
          ),
        ],
      );
    }

    return Row();
  }

  progressDialog(bool isLoading, BuildContext context) {
    AlertDialog dialog = AlertDialog(
      content: SizedBox(
          height: 40.0,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                CircularProgressIndicator(),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Text("Please wait")
              ],
            ),
          )),
      contentPadding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
    );
    if (!isLoading) {
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: null, child: dialog);
        },
        useRootNavigator: true,
      );
    }
  }

  statusWidget(String status){
    if (status.contains('Sudah dibayar') || status.contains('Selesai')){
      return Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Text(status, style: const TextStyle(fontSize: 12, color: Colors.white)),
      );
    } else if (status.contains('Proses Printing')) {
      return Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Text(status, style: const TextStyle(fontSize: 12)),
      );
    }

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Text(status, style: const TextStyle(fontSize: 12, color: Colors.white)),
    );
    
  }

}