
import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:siapprint/model/inks_model.dart';
import 'package:siapprint/model/price_model.dart';
import 'package:siapprint/model/size_model.dart';
import 'package:siapprint/repository/form_service.dart';

class FormPrintPage extends StatefulWidget {

  const FormPrintPage({ Key? key }) : super(key: key);

  static String tag = 'form-print-page';

  @override
  State<StatefulWidget> createState() => _FormPrintPage();

}

class _FormPrintPage extends State<FormPrintPage> {

  int? _printer = 0;
  SizeModel defaultSizeModel = SizeModel(size_code: '', size_name: '', size_detail: '', size_text: '', active: '', weight: '', uom: '', prices: '');
  PriceModel defaultPreiceMode = PriceModel(price_code: '', size_code: '', ink_code: '', type_paper_code: '', price: '', size_name: '', ink_name: '', type_paper_name: '');

  List<SizeModel> _ukuranKertas = [];
  List<PriceModel> _jenisKertas =  [];
  int? _pages = 0;
  TextEditingController _pagesRange = TextEditingController();
  TextEditingController _copyPage = TextEditingController();
  List<String> _finishingDocument = <String>['Jilid', 'Polos'];
  TextEditingController _notesDocument = TextEditingController();

  String? _dropDownUkuranKertas = 'SIZ001';
  String? _dropDownJenisKertas = '1';
  String? _selectedItem1;
  String? _selectedItem2;

  String _dropDownFinishing = '';
  late String _valProvince;

  final _formService = FormService();

  @override
  void initState() {

    _pagesRange.text = '';
    _copyPage.text = '';
    _notesDocument.text = '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var option = Row(
      children: [
        Radio(
          value: 1,
          groupValue: _printer,
          onChanged: (value) {
            setState(() {
              _printer = value as int?;
            });
          },
        ),

        Text(
          "Print Laser",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),

        Radio(
          value: 2,
          groupValue: _printer,
          onChanged: (value) {
            setState(() {
              _printer = value as int?;
            });
          },
        ),

        Text(
          "Print Tinta",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),

      ],
    );


    return FutureBuilder<Response>(
      //TODO: masih hardcode
        future: _formService.getFieldFormPrint("1"),
        builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {

          if (snapshot.hasData){

            final data = jsonDecode(snapshot.data!.body);

            var dataInks = data['result']['inks'] as List;

            final List<InkModel> listInks = dataInks.map((data) => InkModel.fromJson2(data) ).toList();
            final ink = listInks.first;
            final size = ink.size!.map((e) => SizeModel.fromJson(e));
            _ukuranKertas.clear();
            _ukuranKertas.addAll(size);

            // final selectedSize = size.where((element) => element.size_code == 'SIZ001').toList();
            final selectedSize2 = size.first;

            final paperTypesList = selectedSize2.prices as List;
            final paperType = paperTypesList.map((e) => PriceModel.fromJson(e));

            // _dropDownJenisKertas = paperType.first.price_code!;

            List<DropdownMenuItem<String>> _createList() {
              return _ukuranKertas
                  .map<DropdownMenuItem<String>>(
                    (e) => DropdownMenuItem(
                  value: e.size_code,
                  child: Text('${e.size_name} - ${e.size_text!}')
                ),
              )
                  .toList();
            }
            final dropdown = DropdownButton(
              items: _createList(),
              value: _selectedItem1,
              onChanged: (String? value) => setState(() {
                _selectedItem1 = value;

                SizeModel ss = _ukuranKertas.where((element) => element.size_code == _selectedItem1).first;
                _jenisKertas.clear();

                print(ss.prices);
                final xx = ss.prices as List;
                final list = xx.map((e) => PriceModel.fromJson(e));

                _jenisKertas.addAll(list);

                _selectedItem2 = _jenisKertas.first.price_code;

              }),
            );



            List<DropdownMenuItem<String>> _createList2() {
              return _jenisKertas
                  .map<DropdownMenuItem<String>>(
                    (e) => DropdownMenuItem(
                    value: e.size_code,
                    child: Text('${e.type_paper_name} - Rp ${e.price!}')
                ),
              )
                  .toList();
            }
            final dropdown2 = DropdownButton(
              items: _createList2(),
              value: _selectedItem2,
              onChanged: (String? value) => setState(() {
                _selectedItem2 = value ?? "";

              }),
            );



            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      dropdown,
                      dropdown2,
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: Text('Print'),
                        color: Colors.grey.withAlpha(50),
                      ),
                      option,
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: Text('Ukuran Kertas'),
                        color: Colors.grey.withAlpha(50),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: DropdownButton<String>(
                          value: _dropDownUkuranKertas,
                          hint: Text('Pilih'),
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              _dropDownUkuranKertas = value!;
                            });
                          },
                          items: size.map<DropdownMenuItem<String>>((SizeModel value) {
                            return DropdownMenuItem<String>(
                              value: value.size_code,
                              child: Text('${value.size_name} - ${value.size_text!}'),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: Text('Jenis Kertas'),
                        color: Colors.grey.withAlpha(50),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: DropdownButton<String>(
                          value: _dropDownJenisKertas,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              _dropDownJenisKertas = value!;
                            });
                          },
                          items: paperType.map<DropdownMenuItem<String>>((PriceModel value) {
                            return DropdownMenuItem<String>(
                              value: value.price_code,
                              child: Text('${value.type_paper_name} - Rp ${value.price!}'),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: Text('Halaman'),
                        color: Colors.grey.withAlpha(50),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _pages,
                              onChanged: (value) {
                                setState(() {
                                  _pages = value as int?;
                                });
                              },
                            ),

                            Text(
                              "All",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),

                            Radio(
                              value: 1,
                              groupValue: _pages,
                              onChanged: (value) {
                                setState(() {
                                  _pages = value as int?;
                                });
                              },
                            ),

                            Text(
                              "Page",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),

                            SizedBox(width: 10,),

                            Container(
                              width: 100,
                              child: TextFormField(
                                controller: _pagesRange,
                                decoration: InputDecoration(
                                  hintText: 'Page range',
                                ),
                              ),
                            )

                          ],
                        ),

                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                        child: Text('** masukkan range halaman atau per halaman cnth : 1-7 atau 1,2,6,7'),
                      ),


                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: Text('Copy'),
                        color: Colors.grey.withAlpha(50),
                      ),

                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextFormField(
                          controller: _copyPage,
                          decoration: InputDecoration(
                            hintText: 'Copy',
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: Text('Finishing'),
                        color: Colors.grey.withAlpha(50),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: DropdownButton<String>(
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              _dropDownFinishing = value!;
                            });
                          },
                          items: _finishingDocument.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: Text('Catatan'),
                        color: Colors.grey.withAlpha(50),
                      ),

                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextFormField(
                          controller: _notesDocument,
                          decoration: InputDecoration(
                            hintText: 'Catatan untuk dokumen ini',
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError){
            return Center(child: Text('error..${snapshot.error}'));
          }

          return Scaffold(
            body: Container(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10,),
                    Text('Please wait...')
                  ],
                ),
              ),
            ),
          );

        }
    );

  }
}