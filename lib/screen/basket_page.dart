
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/company_model.dart';
import 'package:siapprint/repository/basket_service.dart';

class BasketPage extends StatefulWidget {

  static String tag = 'basket-page';

  @override
  State<StatefulWidget> createState() => _BasketPage();

}




class _BasketPage extends State<BasketPage> {

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

  Widget widgetListDocument(BasketModel basketModel) {

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(basketModel.filename != null ? basketModel.filename! : '-',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(basketModel.pages_tot != null ? 'Total halaman: ${basketModel.pages_tot!}' : '-'),
                  ],
                ),
              )
            ],
          ),
          const Divider(
            height: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          )
        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {


    return FutureBuilder<Response>(
      future: _basketService.getBasket(),
      builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
        if (snapshot.hasData){

          final data = jsonDecode(snapshot.data!.body);
          var dataListCompany = data['result']['company_selected'] as List;
          var dataListBasket = data['result']['basket'] as List;

          final List<CompanyModel> listCompany = dataListCompany.map((data) => CompanyModel.fromJson2(data) ).toList();
          final List<BasketModel> listBasket = dataListBasket.map((data) => BasketModel.fromJson2(data) ).toList();
          
          return Scaffold(
            body: SingleChildScrollView(
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

                    currentAddress(listCompany.first),

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

                    Container(
                      child: Column(
                        children: listBasket.map((data) => widgetListDocument(data)).toList(),
                      ),
                    ),

                    Container(
                      child: Column(
                        children: listBasket.map((data) => widgetListDocument(data)).toList(),
                      ),
                    ),

                    Container(
                      child: Column(
                        children: listBasket.map((data) => widgetListDocument(data)).toList(),
                      ),
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