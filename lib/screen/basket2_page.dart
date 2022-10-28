
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/company_model.dart';
import 'package:siapprint/repository/basket_service.dart';
import 'package:siapprint/screen/form_print_page.dart';

class Basket2Page extends StatefulWidget {

  const Basket2Page({Key? key, required this.onSubmit}) : super(key: key);

  final ValueChanged<int>? onSubmit;

  static String tag = 'basket2-page';

  @override
  State<StatefulWidget> createState() => _Basket2Page();

}

class _Basket2Page extends State<Basket2Page> {

  final _basketService = BasketService();
  bool isChecked = false;
  List<Widget> listDocument = [];

  Widget currentAddress(CompanyModel companyModel) {
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
          Text(companyModel.comp_name != null ? companyModel.comp_name! : '-', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(companyModel.comp_address != null ? '${companyModel.comp_address!}, ${companyModel.regencies_name!}, ${companyModel.provinces_name!}' : '-'),

          ElevatedButton(
            style: ElevatedButton.styleFrom(elevation: 2),
            onPressed: () { },
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
                    _basketService.listBasket[index].is_checked != _basketService.listBasket[index].is_checked;

                    print(_basketService.listBasket[index].toJson());
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
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Response>(
        future: _basketService.getBasket(),
        builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
          if (snapshot.hasData){

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

                      currentAddress(_basketService.listCompany.first),

                      SizedBox(height: 10,),

                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () { },
                          child: Text('Pilih tempat lain'),
                        ),
                      ),

                      SizedBox(height: 10,),

                      Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: double.infinity,
                          child: Text('List dokumen')
                      ),

                      SizedBox(height: 10,),

                      Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: _basketService.listBasket.length,
                            itemBuilder: (BuildContext context, int index) {
                              // return widgetListDocument(index);
                              return Column(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    value: _basketService.listBasket[index].is_checked ?? false,
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        _basketService.listBasket[index].is_checked = true;

                                        print(_basketService.listBasket[index].toJson());
                                      });
                                    },
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                          )
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
                                Navigator.of(context).pushNamed('/form_print');
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
          } else if (snapshot.hasError){
            return Center(child: Text('error..${snapshot.error}'));
          }

          return const CircularProgressIndicator();

        }
    );
  }



}