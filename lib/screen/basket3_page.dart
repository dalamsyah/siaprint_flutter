
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/company_model.dart';
import 'package:siapprint/model/transaction_model.dart';
import 'package:siapprint/repository/basket_service.dart';
import 'package:siapprint/repository/company_serive.dart';
import 'package:siapprint/screen/checkout_page.dart';
import 'package:siapprint/screen/form_print_page.dart';
import 'package:siapprint/screen/naivgation/tab_navigator.dart';
import 'package:siapprint/screen/utils/custom_widget.dart';

class Basket3Page extends StatefulWidget {

  static String tag = 'basket3-page';

  const Basket3Page({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Basket3Page();

}

class _Basket3Page extends State<Basket3Page> {

  CustomWidget customWidget = CustomWidget();
  final _basketService = BasketService();
  final _companyService = CompanyService();
  bool isChecked = false;
  List<Widget> listDocument = [];
  List<BasketModel> _listBasket = [];
  late Future<List<BasketModel>> _listBasket2;

  Widget currentAddress(List<CompanyModel> companyModels) {

    CompanyModel selectedCompanyModel = _companyService.listCompany.first;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.lightBlue, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(selectedCompanyModel.comp_name != null ? selectedCompanyModel.comp_name! : '-', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(selectedCompanyModel.comp_address != null ? '${selectedCompanyModel.comp_address!}, ${selectedCompanyModel.regencies_name!}, ${selectedCompanyModel.provinces_name!}' : '-'),

          selectedCompanyModel.price_status == null && selectedCompanyModel.price_finish_status == null ?
              Text('Coming soon')
          :
            ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 2),
              onPressed: () {



              },
              child: Text('Pilih'),
            ),

          

        ],
      ),
    );
  }

  Widget widgetListDocument(int index) {

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: _basketService.listBasket[index].is_checked ?? false,
                onChanged: (bool? value) async {
                  setState(() {
                    _basketService.listBasket[index].is_checked = value;
                  });
                },
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_basketService.listBasket[index].filename != null ? _basketService.listBasket[index].filename! : '-',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(_basketService.listBasket[index].pages_tot != null ? 'Total halaman: ${_basketService.listBasket[index].pages_tot!}' : '-'),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );

  }

  @override
  void initState() {
    super.initState();
    // getDataBasket();
    _listBasket2 = _basketService.getBasket2();
  }

  void getDataBasket() async {
    _listBasket = List.from(_listBasket)..addAll(await _basketService.getBasket2());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          child:

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  width: double.infinity,
                  child: Text('Tempat print yang kami rekomendasikan')
              ),
              SizedBox(height: 10,),

              Container(
                child: FutureBuilder(
                    future: _companyService.getCompany(),
                    builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {

                      if (snapshot.hasData){
                        return currentAddress(_companyService.allListCompany);
                      } else if (snapshot.hasError) {
                        return Container(
                            alignment: Alignment.center,
                            child: Text('something wrong ${snapshot.error}')
                        );
                      }

                      return Center(
                        child: Column(
                          children: [
                            Transform.scale(
                              scale: 0.5,
                              child: CircularProgressIndicator(),
                            ),
                            SizedBox(height: 10,),
                            Text('Please wait...')
                          ],
                        ),
                      );

                    }
                ),
              ),

              SizedBox(height: 10,),

              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context, builder: (BuildContext context) {

                      return SizedBox(
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
                              Column(
                                children: List.generate(_companyService.allListCompany.length, (index) {
                                  return Column(
                                    children: [
                                      Text(_companyService.allListCompany[index].comp_name != null ? _companyService.allListCompany[index].comp_name! : '-', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(_companyService.allListCompany[index].comp_address != null ? '${_companyService.allListCompany[index].comp_address!}, ${_companyService.allListCompany[index].regencies_name!}, ${_companyService.allListCompany[index].provinces_name!}' : '-'),

                                      _companyService.allListCompany[index].price_status == null && _companyService.allListCompany[index].price_finish_status == null ?
                                      Text('Coming soon') : Text('')
                                    ],
                                  );
                                }),
                              )

                            ],
                          ),
                        ),
                      );

                    });
                  },
                  child: Text('Pilih tempat lain'),
                ),
              ),

              SizedBox(height: 10,),

              Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: double.infinity,
                  child: Text('List dokumen')
              ),

              Expanded(
                  child: FutureBuilder(
                      future: _listBasket2,
                      builder : (BuildContext context, AsyncSnapshot<List<BasketModel>> snapshot) {

                        if (snapshot.hasData) {
                          return ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: _basketService.listBasket.length,
                            itemBuilder: (BuildContext context, int index) {

                              if (_basketService.listBasket.isEmpty){
                                return Container(
                                  alignment: Alignment.center,
                                  child: Text('List dokumen kosong'),
                                );
                              }

                              return widgetListDocument(index);
                            },
                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                          );
                        } else if (snapshot.hasError) {
                          return Container(
                            alignment: Alignment.center,
                            child: Text('something wrong'),
                          );
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
              ),

              SizedBox(height: 10,),

              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      elevation: 2,
                    ),
                    onPressed: null,
                    child: Text('Hapus'),
                  ),

                  SizedBox(width: 10,),

                  Expanded(child: Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 2
                      ),
                      onPressed: (){
                        List<BasketModel> basketListSelected = _basketService.listBasket.where((e) => e.is_checked == true).toList();
                        TransactionModel transactionModel = TransactionModel(
                            listBasketModel: basketListSelected,
                            companyModel: _companyService.listCompany.first,
                            total_print: 0,
                            delivery_id: 0,
                            delivery_code: '',
                            total: 0);

                        Navigator.of(context).pushNamed(CheckoutPage.tag, arguments: transactionModel);
                      },
                      child: Text('Proses'),
                    ),
                  ))
                ],
              )

            ],
          ),

        ),
      ),
    );

  }



}