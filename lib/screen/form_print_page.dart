
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
  bool _isLoading = false;

  List<String> _ukuranKertas = ['Silahkan pilih'];
  List<String> _jenisKertas =  ['Silahkan pilih'];
  List<SizeModel> _sizeAll = [];
  List<PriceModel> _priceAll = [];

  int? _pages = 0;
  TextEditingController _pagesRange = TextEditingController();
  TextEditingController _copyPage = TextEditingController();
  List<String> _finishingDocument = <String>['Jilid', 'Polos'];
  TextEditingController _notesDocument = TextEditingController();

  String? _dropDownUkuranKertas = 'Silahkan pilih';
  String? _dropDownJenisKertas = 'Silahkan pilih';

  String _dropDownFinishing = '';

  final _formService = FormService();
  final _fetchData = FetchDataPrint();

  @override
  void initState() {

    _pagesRange.text = '';
    _copyPage.text = '';
    _notesDocument.text = '';

    super.initState();
  }

  void _onSelectedInk(int value) async {
    setState(() {
      _ukuranKertas = ['Silahkan pilih'];
      _isLoading = true;
    });

    String ink = 'INK002';
    if (_printer == 1){
      ink = 'INK001';
    }

    _ukuranKertas = List.from(_ukuranKertas)..addAll(await _fetchData.getSizeByInk(ink));
    _sizeAll = List.from(_sizeAll)..addAll(await _fetchData.getSizeAll(ink));

    setState(() {
      _isLoading = false;
    });

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
              _onSelectedInk(_printer!);
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
              _onSelectedInk(_printer!);
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

            final List<InkModel> listInks = dataInks.map((data) => InkModel.fromJson(data) ).toList();
            _fetchData.setData(listInks);

            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
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

                      _isLoading ? CircularProgressIndicator() :

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
                          onChanged: (String? value) async {
                            // This is called when the user selects an item.
                            setState(() {
                              _dropDownUkuranKertas = value!;
                              _dropDownJenisKertas = 'Silahkan pilih';

                            });

                            String ink = 'INK002';
                            if (_printer == 1){
                              ink = 'INK001';
                            }
                            _jenisKertas = List.from(_jenisKertas)..addAll(await _fetchData.getPriceBySize(ink, _dropDownUkuranKertas!));
                            _priceAll = List.from(_priceAll)..addAll(await _fetchData.getPriceBySizeAll(ink, _dropDownUkuranKertas!));

                          },
                          items: _ukuranKertas.map<DropdownMenuItem<String>>((String value) {

                            List<SizeModel> list = _sizeAll.where((element) => element.size_code == value).map((e) => e).toList();

                            String text = "Silahkan pilih";
                            if (list.isNotEmpty) {
                              text = '${list.first.size_name} - ${list.first.size_text}';
                            }

                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(text),
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
                          items: _jenisKertas.map<DropdownMenuItem<String>>((String value) {

                            List<PriceModel> list = _priceAll.where((element) => element.price_code == value).map((e) => e).toList();

                            String text = "Silahkan pilih";
                            if (list.isNotEmpty) {
                              text = '${list.first.type_paper_name} - Rp ${list.first.price}';
                            }

                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(text),
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

class FetchDataPrint {

  List<InkModel> _data = [];
  List<InkModel> setData(List<InkModel> list) => _data = list;

  Future<List<String>> getSizeByInk(String state) async {

    return Future.value(_data
        .where((item) => item.ink_code == state)
        .map((e) => e.size!)
        .expand((element) => element)
        .map((e) => SizeModel.fromJson(e))
        .map((e) => e.size_code!)
    // .map((e) => '${e.size_name} - ${e.size_text!}')
        .toList());

  }

  Future<List<String>> getPriceBySize(String ink, String size) async {

    return Future.value(_data
        .where((item) => item.ink_code == ink)
        .map((e) => e.size!)
        .expand((element) => element)
        .map((e) => SizeModel.fromJson(e))
        .where((item) => item.size_code == size)
        .map((e) => e.prices)
        .expand((element) => element)
        .map((e) => PriceModel.fromJson(e))
        .map((e) => e.price_code!)
        .toList());

  }

  Future<List<PriceModel>> getPriceBySizeAll(String ink, String size) async {
    return Future.value(_data
        .where((item) => item.ink_code == ink)
        .map((e) => e.size!)
        .expand((element) => element)
        .map((e) => SizeModel.fromJson(e))
        .where((item) => item.size_code == size)
        .map((e) => e.prices)
        .expand((element) => element)
        .map((e) => PriceModel.fromJson(e))
        .toList());
  }

  Future<List<SizeModel>> getSizeAll(String ink) async {

    return Future.value(_data
        .where((item) => item.ink_code == ink)
        .map((e) => e.size!)
        .expand((element) => element)
        .map((e) => SizeModel.fromJson(e))
        .toList());

  }

}