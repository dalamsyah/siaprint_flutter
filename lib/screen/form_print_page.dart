
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
            final size = ink.size!.map((e) => SizeModel.fromJson2(e));
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

class RepoSampel {

  List getAll() => _data;

  // List<InkModel> listInks = _data.map((data) => InkModel.fromJson2(data) ).toList();
  // ink = listInks.first;
  // size = ink.size!.map((e) => SizeModel.fromJson(e));
  //
  // List<String> getStates() => _data
  //     .map((map) => SizeModel.fromJson(map))
  //     .map((item) => item.state)
  //     .toList();

  // Future<List<String>> getLocalByState(String state) async {
  //   await Future.delayed(Duration(seconds: 3), () {
  //     print("Future.delayed");
  //   });
  //
  //
  //   return Future.value(_data
  //       .map((map) => StateModel.fromJson(map))
  //       .where((item) => item.state == state)
  //       .map((item) => item.lgas)
  //       .expand((i) => i)
  //       .toList());
  // }

  List _data = [{
    "result": {
      "inks": [
        {
          "ink_code": "INK001",
          "ink_name": "Print Laser",
          "size": [
            {
              "size_code": "SIZ001",
              "size_name": "A5",
              "size_detail": "14,8cm x 21cm",
              "size_text": "14,8cm x 21cm",
              "active": "Y",
              "weight": null,
              "uom": "KG",
              "prices": [
                {
                  "price_code": "1",
                  "size_code": "SIZ001",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP001",
                  "price": "200",
                  "size_name": "A5",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 70 gram (hitam putih)"
                },
                {
                  "price_code": "3",
                  "size_code": "SIZ001",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP003",
                  "price": "300",
                  "size_name": "A5",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 80 gram (hitam putih)"
                },
                {
                  "price_code": "5",
                  "size_code": "SIZ001",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP005",
                  "price": "350",
                  "size_name": "A5",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 100 gram (hitam putih)"
                }
              ]
            },
            {
              "size_code": "SIZ002",
              "size_name": "A4",
              "size_detail": "21cm x 29,7cm",
              "size_text": "21cm x 29,7cm",
              "active": "Y",
              "weight": "0.07",
              "uom": "KG",
              "prices": [
                {
                  "price_code": "32",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP001",
                  "price": "350",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 70 gram (hitam putih)"
                },
                {
                  "price_code": "33",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP002",
                  "price": "700",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 70 gram (warna)"
                },
                {
                  "price_code": "34",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP003",
                  "price": "500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 80 gram (hitam putih)"
                },
                {
                  "price_code": "35",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP004",
                  "price": "1500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 80 gram (warna)"
                },
                {
                  "price_code": "36",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP005",
                  "price": "600",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 100 gram (hitam putih)"
                },
                {
                  "price_code": "37",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP006",
                  "price": "1800",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 100 gram (warna)"
                },
                {
                  "price_code": "38",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP007",
                  "price": "1500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Manila (hitam putih)"
                },
                {
                  "price_code": "39",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP008",
                  "price": "2500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Manila (warna)"
                },
                {
                  "price_code": "40",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP009",
                  "price": "1500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Kalkir (hitam putih)"
                },
                {
                  "price_code": "41",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP010",
                  "price": "3000",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Kalkir (warna)"
                },
                {
                  "price_code": "42",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP017",
                  "price": "3000",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Acasia"
                },
                {
                  "price_code": "43",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP018",
                  "price": "1500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Artpaper 150 gram"
                },
                {
                  "price_code": "44",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP019",
                  "price": "2000",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Artpaper 210 gram"
                },
                {
                  "price_code": "45",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP020",
                  "price": "2500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Artpaper 260 gram"
                },
                {
                  "price_code": "46",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP021",
                  "price": "3500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "BW paper"
                },
                {
                  "price_code": "47",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP022",
                  "price": "3500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Concorde abu tebal"
                },
                {
                  "price_code": "48",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP023",
                  "price": "3500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Concorde putih tebal"
                },
                {
                  "price_code": "49",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP024",
                  "price": "1000",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Concorde abu tipis"
                },
                {
                  "price_code": "50",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP025",
                  "price": "3500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Gloria (sisi doff)"
                },
                {
                  "price_code": "51",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP026",
                  "price": "3500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Gloria (sisi gloss)"
                },
                {
                  "price_code": "52",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP027",
                  "price": "3500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Ivory"
                },
                {
                  "price_code": "53",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP028",
                  "price": "3000",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Linen putih"
                },
                {
                  "price_code": "54",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP029",
                  "price": "3500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Melon cream"
                },
                {
                  "price_code": "55",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP030",
                  "price": "3500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Jasmine"
                },
                {
                  "price_code": "56",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP031",
                  "price": "3500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Java"
                },
                {
                  "price_code": "57",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP032",
                  "price": "8500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Plastik matte"
                },
                {
                  "price_code": "58",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP033",
                  "price": "3500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Sticker chromo"
                },
                {
                  "price_code": "59",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP034",
                  "price": "3500",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Sticker transparan (hitam putih)"
                },
                {
                  "price_code": "60",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP035",
                  "price": "5000",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Sticker transparan (warna)"
                },
                {
                  "price_code": "61",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP036",
                  "price": "5000",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Sticker vynil gloss"
                },
                {
                  "price_code": "62",
                  "size_code": "SIZ002",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP037",
                  "price": "5000",
                  "size_name": "A4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Sticker vynil doff"
                }
              ]
            },
            {
              "size_code": "SIZ003",
              "size_name": "F4",
              "size_detail": "21,5cm x 33cm",
              "size_text": "21,5cm x 33cm",
              "active": "Y",
              "weight": "0.07",
              "uom": "KG",
              "prices": [
                {
                  "price_code": "63",
                  "size_code": "SIZ003",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP001",
                  "price": "500",
                  "size_name": "F4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 70 gram (hitam putih)"
                },
                {
                  "price_code": "64",
                  "size_code": "SIZ003",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP002",
                  "price": "900",
                  "size_name": "F4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 70 gram (warna)"
                },
                {
                  "price_code": "65",
                  "size_code": "SIZ003",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP003",
                  "price": "600",
                  "size_name": "F4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 80 gram (hitam putih)"
                },
                {
                  "price_code": "66",
                  "size_code": "SIZ003",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP004",
                  "price": "1750",
                  "size_name": "F4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 80 gram (warna)"
                },
                {
                  "price_code": "67",
                  "size_code": "SIZ003",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP005",
                  "price": "750",
                  "size_name": "F4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 100 gram (hitam putih)"
                },
                {
                  "price_code": "68",
                  "size_code": "SIZ003",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP006",
                  "price": "2000",
                  "size_name": "F4",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 100 gram (warna)"
                }
              ]
            },
            {
              "size_code": "SIZ004",
              "size_name": "A3",
              "size_detail": "29,7cm x 42cm",
              "size_text": "29,7cm x 42cm",
              "active": "Y",
              "weight": "0.07",
              "uom": "KG",
              "prices": [
                {
                  "price_code": "96",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP003",
                  "price": "1000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 80 gram (hitam putih)"
                },
                {
                  "price_code": "97",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP004",
                  "price": "2500",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "HVS 80 gram (warna)"
                },
                {
                  "price_code": "100",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP007",
                  "price": "2500",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Manila (hitam putih)"
                },
                {
                  "price_code": "101",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP008",
                  "price": "4500",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Manila (warna)"
                },
                {
                  "price_code": "102",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP009",
                  "price": "3000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Kalkir (hitam putih)"
                },
                {
                  "price_code": "103",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP010",
                  "price": "6000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Kalkir (warna)"
                },
                {
                  "price_code": "104",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP017",
                  "price": "4500",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Acasia"
                },
                {
                  "price_code": "105",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP018",
                  "price": "2500",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Artpaper 150 gram"
                },
                {
                  "price_code": "106",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP019",
                  "price": "3000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Artpaper 210 gram"
                },
                {
                  "price_code": "107",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP020",
                  "price": "3500",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Artpaper 260 gram"
                },
                {
                  "price_code": "108",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP021",
                  "price": "6500",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "BW paper"
                },
                {
                  "price_code": "109",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP022",
                  "price": "6000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Concorde abu tebal"
                },
                {
                  "price_code": "110",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP023",
                  "price": "5000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Concorde putih tebal"
                },
                {
                  "price_code": "112",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP025",
                  "price": "6000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Gloria (sisi doff)"
                },
                {
                  "price_code": "113",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP026",
                  "price": "6000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Gloria (sisi gloss)"
                },
                {
                  "price_code": "114",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP027",
                  "price": "5000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Ivory"
                },
                {
                  "price_code": "115",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP028",
                  "price": "4500",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Linen putih"
                },
                {
                  "price_code": "116",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP029",
                  "price": "5000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Melon cream"
                },
                {
                  "price_code": "117",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP030",
                  "price": "5000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Jasmine"
                },
                {
                  "price_code": "118",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP031",
                  "price": "5000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Java"
                },
                {
                  "price_code": "119",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP032",
                  "price": "16000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Plastik matte"
                },
                {
                  "price_code": "120",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP033",
                  "price": "6000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Sticker chromo"
                },
                {
                  "price_code": "121",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP034",
                  "price": "6000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Sticker transparan (hitam putih)"
                },
                {
                  "price_code": "122",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP035",
                  "price": "10000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Sticker transparan (warna)"
                },
                {
                  "price_code": "123",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP036",
                  "price": "9000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Sticker vynil gloss"
                },
                {
                  "price_code": "124",
                  "size_code": "SIZ004",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP037",
                  "price": "10000",
                  "size_name": "A3",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Sticker vynil doff"
                }
              ]
            },
            {
              "size_code": "SIZ005",
              "size_name": "A2",
              "size_detail": "42cm x 59,4cm",
              "size_text": "42cm x 59,4cm",
              "active": "Y",
              "weight": null,
              "uom": "KG",
              "prices": 0
            },
            {
              "size_code": "SIZ006",
              "size_name": "A1",
              "size_detail": "59,4cm x 84cm",
              "size_text": "59,4cm x 84cm",
              "active": "Y",
              "weight": null,
              "uom": "KG",
              "prices": 0
            },
            {
              "size_code": "SIZ008",
              "size_name": "KN",
              "size_detail": "Kartu Nama (9cm x 5,5cm)",
              "size_text": "9cm x 5,5cm",
              "active": "Y",
              "weight": null,
              "uom": null,
              "prices": [
                {
                  "price_code": "218",
                  "size_code": "SIZ008",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP017",
                  "price": "30000",
                  "size_name": "KN",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Acasia"
                },
                {
                  "price_code": "219",
                  "size_code": "SIZ008",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP019",
                  "price": "22000",
                  "size_name": "KN",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Artpaper 210 gram"
                },
                {
                  "price_code": "220",
                  "size_code": "SIZ008",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP020",
                  "price": "27000",
                  "size_name": "KN",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Artpaper 260 gram"
                },
                {
                  "price_code": "221",
                  "size_code": "SIZ008",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP021",
                  "price": "35000",
                  "size_name": "KN",
                  "ink_name": "Print Laser",
                  "type_paper_name": "BW paper"
                },
                {
                  "price_code": "222",
                  "size_code": "SIZ008",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP022",
                  "price": "35000",
                  "size_name": "KN",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Concorde abu tebal"
                },
                {
                  "price_code": "223",
                  "size_code": "SIZ008",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP026",
                  "price": "35000",
                  "size_name": "KN",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Gloria (sisi gloss)"
                },
                {
                  "price_code": "224",
                  "size_code": "SIZ008",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP028",
                  "price": "30000",
                  "size_name": "KN",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Linen putih"
                },
                {
                  "price_code": "225",
                  "size_code": "SIZ008",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP029",
                  "price": "35000",
                  "size_name": "KN",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Melon cream"
                },
                {
                  "price_code": "226",
                  "size_code": "SIZ008",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP030",
                  "price": "35000",
                  "size_name": "KN",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Jasmine"
                },
                {
                  "price_code": "227",
                  "size_code": "SIZ008",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP031",
                  "price": "35000",
                  "size_name": "KN",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Java"
                },
                {
                  "price_code": "228",
                  "size_code": "SIZ008",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP032",
                  "price": "80000",
                  "size_name": "KN",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Plastik matte"
                }
              ]
            },
            {
              "size_code": "SIZ009",
              "size_name": "MB",
              "size_detail": "Mini X Banner (25cm x 35cm)",
              "size_text": "25cm x 35cm",
              "active": "Y",
              "weight": null,
              "uom": null,
              "prices": [
                {
                  "price_code": "229",
                  "size_code": "SIZ009",
                  "ink_code": "INK001",
                  "type_paper_code": "TPP032",
                  "price": "35000",
                  "size_name": "MB",
                  "ink_name": "Print Laser",
                  "type_paper_name": "Plastik matte"
                }
              ]
            }
          ]
        },
        {
          "ink_code": "INK002",
          "ink_name": "Print Tinta",
          "size": [
            {
              "size_code": "SIZ001",
              "size_name": "A5",
              "size_detail": "14,8cm x 21cm",
              "size_text": "14,8cm x 21cm",
              "active": "Y",
              "weight": null,
              "uom": "KG",
              "prices": [
                {
                  "price_code": "230",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP001",
                  "price": "150",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 70 gram (hitam putih)"
                },
                {
                  "price_code": "231",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP002",
                  "price": "400",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 70 gram (warna)"
                },
                {
                  "price_code": "232",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP003",
                  "price": "150",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 80 gram (hitam putih)"
                },
                {
                  "price_code": "233",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP004",
                  "price": "500",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 80 gram (warna)"
                },
                {
                  "price_code": "234",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP005",
                  "price": "250",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 100 gram (hitam putih)"
                },
                {
                  "price_code": "235",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP006",
                  "price": "800",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 100 gram (warna)"
                },
                {
                  "price_code": "236",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP007",
                  "price": "600",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Manila (hitam putih)"
                },
                {
                  "price_code": "237",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP008",
                  "price": "1200",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Manila (warna)"
                },
                {
                  "price_code": "246",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP017",
                  "price": "1500",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Acasia"
                },
                {
                  "price_code": "247",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP021",
                  "price": "1500",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "BW paper"
                },
                {
                  "price_code": "248",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP022",
                  "price": "1500",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Concorde abu tebal"
                },
                {
                  "price_code": "249",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP023",
                  "price": "1500",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Concorde putih tebal"
                },
                {
                  "price_code": "251",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP025",
                  "price": "1500",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Gloria (sisi doff)"
                },
                {
                  "price_code": "252",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP028",
                  "price": "1500",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Linen putih"
                },
                {
                  "price_code": "253",
                  "size_code": "SIZ001",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP029",
                  "price": "1500",
                  "size_name": "A5",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Melon cream"
                }
              ]
            },
            {
              "size_code": "SIZ002",
              "size_name": "A4",
              "size_detail": "21cm x 29,7cm",
              "size_text": "21cm x 29,7cm",
              "active": "Y",
              "weight": "0.07",
              "uom": "KG",
              "prices": [
                {
                  "price_code": "257",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP001",
                  "price": "250",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 70 gram (hitam putih)"
                },
                {
                  "price_code": "258",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP002",
                  "price": "700",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 70 gram (warna)"
                },
                {
                  "price_code": "259",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP003",
                  "price": "300",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 80 gram (hitam putih)"
                },
                {
                  "price_code": "260",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP004",
                  "price": "900",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 80 gram (warna)"
                },
                {
                  "price_code": "261",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP005",
                  "price": "350",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 100 gram (hitam putih)"
                },
                {
                  "price_code": "262",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP006",
                  "price": "1000",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 100 gram (warna)"
                },
                {
                  "price_code": "263",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP007",
                  "price": "1000",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Manila (hitam putih)"
                },
                {
                  "price_code": "264",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP008",
                  "price": "2000",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Manila (warna)"
                },
                {
                  "price_code": "265",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP009",
                  "price": "1500",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Kalkir (hitam putih)"
                },
                {
                  "price_code": "266",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP010",
                  "price": "2500",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Kalkir (warna)"
                },
                {
                  "price_code": "267",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP011",
                  "price": "3000",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Inkjet paper 130 gram"
                },
                {
                  "price_code": "268",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP012",
                  "price": "4000",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Matte paper 230 gram"
                },
                {
                  "price_code": "269",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP013",
                  "price": "4000",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Glossy photopaper 230 gram"
                },
                {
                  "price_code": "270",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP014",
                  "price": "6000",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Silky photopaper"
                },
                {
                  "price_code": "271",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP015",
                  "price": "6000",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Wove photopaper"
                },
                {
                  "price_code": "272",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP016",
                  "price": "3000",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Sticker Glossy"
                },
                {
                  "price_code": "273",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP017",
                  "price": "2500",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Acasia"
                },
                {
                  "price_code": "274",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP021",
                  "price": "2500",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "BW paper"
                },
                {
                  "price_code": "275",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP022",
                  "price": "2500",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Concorde abu tebal"
                },
                {
                  "price_code": "276",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP023",
                  "price": "2500",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Concorde putih tebal"
                },
                {
                  "price_code": "277",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP024",
                  "price": "750",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Concorde abu tipis"
                },
                {
                  "price_code": "278",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP025",
                  "price": "2500",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Gloria (sisi doff)"
                },
                {
                  "price_code": "279",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP028",
                  "price": "2500",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Linen putih"
                },
                {
                  "price_code": "280",
                  "size_code": "SIZ002",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP029",
                  "price": "2500",
                  "size_name": "A4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Melon cream"
                }
              ]
            },
            {
              "size_code": "SIZ003",
              "size_name": "F4",
              "size_detail": "21,5cm x 33cm",
              "size_text": "21,5cm x 33cm",
              "active": "Y",
              "weight": "0.07",
              "uom": "KG",
              "prices": [
                {
                  "price_code": "284",
                  "size_code": "SIZ003",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP001",
                  "price": "300",
                  "size_name": "F4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 70 gram (hitam putih)"
                },
                {
                  "price_code": "285",
                  "size_code": "SIZ003",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP002",
                  "price": "900",
                  "size_name": "F4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 70 gram (warna)"
                },
                {
                  "price_code": "286",
                  "size_code": "SIZ003",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP003",
                  "price": "400",
                  "size_name": "F4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 80 gram (hitam putih)"
                },
                {
                  "price_code": "287",
                  "size_code": "SIZ003",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP004",
                  "price": "1000",
                  "size_name": "F4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 80 gram (warna)"
                },
                {
                  "price_code": "288",
                  "size_code": "SIZ003",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP005",
                  "price": "500",
                  "size_name": "F4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 100 gram (hitam putih)"
                },
                {
                  "price_code": "289",
                  "size_code": "SIZ003",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP006",
                  "price": "1200",
                  "size_name": "F4",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 100 gram (warna)"
                }
              ]
            },
            {
              "size_code": "SIZ004",
              "size_name": "A3",
              "size_detail": "29,7cm x 42cm",
              "size_text": "29,7cm x 42cm",
              "active": "Y",
              "weight": "0.07",
              "uom": "KG",
              "prices": [
                {
                  "price_code": "313",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP003",
                  "price": "1000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 80 gram (hitam putih)"
                },
                {
                  "price_code": "314",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP004",
                  "price": "2000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 80 gram (warna)"
                },
                {
                  "price_code": "317",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP007",
                  "price": "2000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Manila (hitam putih)"
                },
                {
                  "price_code": "318",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP008",
                  "price": "4000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Manila (warna)"
                },
                {
                  "price_code": "319",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP009",
                  "price": "3000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Kalkir (hitam putih)"
                },
                {
                  "price_code": "320",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP010",
                  "price": "5000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Kalkir (warna)"
                },
                {
                  "price_code": "321",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP011",
                  "price": "6000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Inkjet paper 130 gram"
                },
                {
                  "price_code": "322",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP012",
                  "price": "8000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Matte paper 230 gram"
                },
                {
                  "price_code": "323",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP013",
                  "price": "8000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Glossy photopaper 230 gram"
                },
                {
                  "price_code": "327",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP017",
                  "price": "5000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Acasia"
                },
                {
                  "price_code": "328",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP021",
                  "price": "5000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "BW paper"
                },
                {
                  "price_code": "330",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP023",
                  "price": "5000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Concorde putih tebal"
                },
                {
                  "price_code": "332",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP025",
                  "price": "5000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Gloria (sisi doff)"
                },
                {
                  "price_code": "333",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP028",
                  "price": "5000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Linen putih"
                },
                {
                  "price_code": "334",
                  "size_code": "SIZ004",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP029",
                  "price": "5000",
                  "size_name": "A3",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Melon cream"
                }
              ]
            },
            {
              "size_code": "SIZ005",
              "size_name": "A2",
              "size_detail": "42cm x 59,4cm",
              "size_text": "42cm x 59,4cm",
              "active": "Y",
              "weight": null,
              "uom": "KG",
              "prices": [
                {
                  "price_code": "340",
                  "size_code": "SIZ005",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP003",
                  "price": "4000",
                  "size_name": "A2",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 80 gram (hitam putih)"
                },
                {
                  "price_code": "341",
                  "size_code": "SIZ005",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP004",
                  "price": "7000",
                  "size_name": "A2",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 80 gram (warna)"
                },
                {
                  "price_code": "344",
                  "size_code": "SIZ005",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP007",
                  "price": "5000",
                  "size_name": "A2",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Manila (hitam putih)"
                },
                {
                  "price_code": "345",
                  "size_code": "SIZ005",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP008",
                  "price": "10000",
                  "size_name": "A2",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Manila (warna)"
                },
                {
                  "price_code": "346",
                  "size_code": "SIZ005",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP009",
                  "price": "6000",
                  "size_name": "A2",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Kalkir (hitam putih)"
                },
                {
                  "price_code": "347",
                  "size_code": "SIZ005",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP010",
                  "price": "10000",
                  "size_name": "A2",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Kalkir (warna)"
                },
                {
                  "price_code": "348",
                  "size_code": "SIZ005",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP011",
                  "price": "16000",
                  "size_name": "A2",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Inkjet paper 130 gram"
                },
                {
                  "price_code": "359",
                  "size_code": "SIZ005",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP025",
                  "price": "12000",
                  "size_name": "A2",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Gloria (sisi doff)"
                }
              ]
            },
            {
              "size_code": "SIZ006",
              "size_name": "A1",
              "size_detail": "59,4cm x 84cm",
              "size_text": "59,4cm x 84cm",
              "active": "Y",
              "weight": null,
              "uom": "KG",
              "prices": [
                {
                  "price_code": "367",
                  "size_code": "SIZ006",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP003",
                  "price": "10000",
                  "size_name": "A1",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 80 gram (hitam putih)"
                },
                {
                  "price_code": "368",
                  "size_code": "SIZ006",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP004",
                  "price": "18000",
                  "size_name": "A1",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "HVS 80 gram (warna)"
                },
                {
                  "price_code": "371",
                  "size_code": "SIZ006",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP007",
                  "price": "10000",
                  "size_name": "A1",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Manila (hitam putih)"
                },
                {
                  "price_code": "372",
                  "size_code": "SIZ006",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP008",
                  "price": "20000",
                  "size_name": "A1",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Manila (warna)"
                },
                {
                  "price_code": "373",
                  "size_code": "SIZ006",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP009",
                  "price": "12000",
                  "size_name": "A1",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Kalkir (hitam putih)"
                },
                {
                  "price_code": "374",
                  "size_code": "SIZ006",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP010",
                  "price": "20000",
                  "size_name": "A1",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Kalkir (warna)"
                },
                {
                  "price_code": "375",
                  "size_code": "SIZ006",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP011",
                  "price": "36000",
                  "size_name": "A1",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Inkjet paper 130 gram"
                },
                {
                  "price_code": "386",
                  "size_code": "SIZ006",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP025",
                  "price": "25000",
                  "size_name": "A1",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Gloria (sisi doff)"
                }
              ]
            },
            {
              "size_code": "SIZ007",
              "size_name": "PP",
              "size_detail": "Pas Photo",
              "size_text": "Pas Photo",
              "active": "Y",
              "weight": null,
              "uom": null,
              "prices": [
                {
                  "price_code": "432",
                  "size_code": "SIZ007",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP038",
                  "price": "5000",
                  "size_name": "PP",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "ukuran 2cmx3cm = 25 pcs"
                },
                {
                  "price_code": "433",
                  "size_code": "SIZ007",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP039",
                  "price": "5000",
                  "size_name": "PP",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "ukuran 3cmx4cm = 15 pcs"
                },
                {
                  "price_code": "434",
                  "size_code": "SIZ007",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP040",
                  "price": "5000",
                  "size_name": "PP",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "ukuran 4cmx6cm = 8 pcs"
                },
                {
                  "price_code": "435",
                  "size_code": "SIZ007",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP041",
                  "price": "5000",
                  "size_name": "PP",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "lengkap uk 2x3 (5 pcs); 3x4 (5 pcs); 4x6 (4 pcs) "
                }
              ]
            },
            {
              "size_code": "SIZ008",
              "size_name": "KN",
              "size_detail": "Kartu Nama (9cm x 5,5cm)",
              "size_text": "9cm x 5,5cm",
              "active": "Y",
              "weight": null,
              "uom": null,
              "prices": [
                {
                  "price_code": "419",
                  "size_code": "SIZ008",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP012",
                  "price": "40000",
                  "size_name": "KN",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Matte paper 230 gram"
                },
                {
                  "price_code": "420",
                  "size_code": "SIZ008",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP013",
                  "price": "40000",
                  "size_name": "KN",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Glossy photopaper 230 gram"
                },
                {
                  "price_code": "421",
                  "size_code": "SIZ008",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP017",
                  "price": "25000",
                  "size_name": "KN",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Acasia"
                },
                {
                  "price_code": "422",
                  "size_code": "SIZ008",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP021",
                  "price": "25000",
                  "size_name": "KN",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "BW paper"
                },
                {
                  "price_code": "423",
                  "size_code": "SIZ008",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP022",
                  "price": "25000",
                  "size_name": "KN",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Concorde abu tebal"
                },
                {
                  "price_code": "424",
                  "size_code": "SIZ008",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP028",
                  "price": "25000",
                  "size_name": "KN",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Linen putih"
                },
                {
                  "price_code": "425",
                  "size_code": "SIZ008",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP029",
                  "price": "25000",
                  "size_name": "KN",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Melon cream"
                }
              ]
            },
            {
              "size_code": "SIZ010",
              "size_name": "IC",
              "size_detail": "ID Card (8,5cm x 5,3cm)",
              "size_text": "8,5cm x 5,3cm",
              "active": "Y",
              "weight": null,
              "uom": null,
              "prices": [
                {
                  "price_code": "436",
                  "size_code": "SIZ010",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP042",
                  "price": "3500",
                  "size_name": "IC",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "ID Card (1 sisi)"
                },
                {
                  "price_code": "437",
                  "size_code": "SIZ010",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP043",
                  "price": "6000",
                  "size_name": "IC",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "ID Card (2 sisi)"
                }
              ]
            },
            {
              "size_code": "SIZ011",
              "size_name": "ST",
              "size_detail": "STEMPEL (hitam, biru, merah, hijau, orange)",
              "size_text": "STEMPEL (hitam, biru, merah, hijau, orange)",
              "active": "Y",
              "weight": null,
              "uom": null,
              "prices": [
                {
                  "price_code": "438",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP044",
                  "price": "60000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 1 warna uk 17 mm x 55 mm"
                },
                {
                  "price_code": "439",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP045",
                  "price": "65000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 1 warna uk 22 mm x 43 mm"
                },
                {
                  "price_code": "440",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP046",
                  "price": "70000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 1 warna uk 27 mm x 43 mm"
                },
                {
                  "price_code": "441",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP047",
                  "price": "85000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 1 warna uk 32 mm x 55 mm"
                },
                {
                  "price_code": "442",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP048",
                  "price": "95000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 1 warna uk 32 mm x 67 mm"
                },
                {
                  "price_code": "443",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP049",
                  "price": "60000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 1 warna uk 26 mm x 26 mm"
                },
                {
                  "price_code": "444",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP050",
                  "price": "70000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 1 warna uk 35 mm x 35 mm"
                },
                {
                  "price_code": "445",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP051",
                  "price": "50000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Lingkaran 1 warna D = 25 mm"
                },
                {
                  "price_code": "446",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP052",
                  "price": "70000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Lingkaran 1 warna D = 35 mm"
                },
                {
                  "price_code": "447",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP053",
                  "price": "90000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Lingkaran 1 warna D = 45 mm"
                },
                {
                  "price_code": "448",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP054",
                  "price": "70000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Oval 1 warna uk 35 mm x 51 mm"
                },
                {
                  "price_code": "449",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP055",
                  "price": "70000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 2 warna uk 17 mm x 55 mm"
                },
                {
                  "price_code": "450",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP056",
                  "price": "75000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 2 warna uk 22 mm x 43 mm"
                },
                {
                  "price_code": "451",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP057",
                  "price": "80000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 2 warna uk 27 mm x 43 mm"
                },
                {
                  "price_code": "452",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP058",
                  "price": "95000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 2 warna uk 32 mm x 55 mm"
                },
                {
                  "price_code": "453",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP059",
                  "price": "105000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 2 warna uk 32 mm x 67 mm"
                },
                {
                  "price_code": "454",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP060",
                  "price": "70000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 2 warna uk 26 mm x 26 mm"
                },
                {
                  "price_code": "455",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP061",
                  "price": "80000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Persegi 2 warna uk 35 mm x 35 mm"
                },
                {
                  "price_code": "456",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP062",
                  "price": "60000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Lingkaran 2 warna D = 25 mm"
                },
                {
                  "price_code": "457",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP063",
                  "price": "80000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Lingkaran 2 warna D = 35 mm"
                },
                {
                  "price_code": "458",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP064",
                  "price": "100000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Lingkaran 2 warna D = 45 mm"
                },
                {
                  "price_code": "459",
                  "size_code": "SIZ011",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP065",
                  "price": "80000",
                  "size_name": "ST",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Oval 2 warna uk 35 mm x 51 mm"
                }
              ]
            },
            {
              "size_code": "SIZ012",
              "size_name": "FP",
              "size_detail": "FOTO POLAROID",
              "size_text": "FOTO POLAROID",
              "active": "Y",
              "weight": null,
              "uom": null,
              "prices": [
                {
                  "price_code": "460",
                  "size_code": "SIZ012",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP066",
                  "price": "500",
                  "size_name": "FP",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Instax Wide (108 mm x 86 mm)"
                },
                {
                  "price_code": "461",
                  "size_code": "SIZ012",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP067",
                  "price": "500",
                  "size_name": "FP",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Instax Square (71 mm x 86 mm)"
                },
                {
                  "price_code": "462",
                  "size_code": "SIZ012",
                  "ink_code": "INK002",
                  "type_paper_code": "TPP068",
                  "price": "500",
                  "size_name": "FP",
                  "ink_name": "Print Tinta",
                  "type_paper_name": "Instax Mini (54 mm x 86 mm)"
                }
              ]
            }
          ]
        }
      ]
    }
  }];

}