
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/finishing_model.dart';
import 'package:siapprint/model/inks_model.dart';
import 'package:siapprint/model/price_model.dart';
import 'package:siapprint/model/size_model.dart';
import 'package:siapprint/repository/form_service.dart';

class FormPrintPage extends StatefulWidget {

  const FormPrintPage({ Key? key, required this.basketModel}) : super(key: key);

  static String tag = 'form-print-page';
  final BasketModel basketModel;

  @override
  State<StatefulWidget> createState() => _FormPrintPage();

}

class _FormPrintPage extends State<FormPrintPage> {

  int _printer = 0;
  bool _isLoading = false;
  bool _is_loading = false;

  int _totalPrint = 0;
  int _priceJenisKertas = 0;
  int _priceFinishing = 0;
  int _totalDelivery = 0;
  int _total = 0;

  List<String> _ukuranKertas = ['Silahkan pilih'];
  List<String> _jenisKertas =  ['Silahkan pilih'];
  List<String> _finishing =  ['Silahkan pilih'];
  List<SizeModel> _sizeAll = [];
  List<PriceModel> _priceAll = [];
  List<FinishingModel> _finishingAll = [];

  int _pages = 0;
  TextEditingController _pagesRange = TextEditingController();
  TextEditingController _copyPage = TextEditingController();
  List<String> _finishingDocument = <String>['Jilid', 'Polos'];
  TextEditingController _notesDocument = TextEditingController();

  String _dropDownUkuranKertas = 'Silahkan pilih';
  String _dropDownJenisKertas = 'Silahkan pilih';
  String _dropDownFinishing = 'Silahkan pilih';

  late BasketModel basketModel;

  final _formService = FormService();
  final _fetchData = FetchDataPrint();

  @override
  void initState() {

    _is_loading = true;

    _formService.getFieldFormPrint("1").then((value) {

      final data = jsonDecode(value.body);

      var dataInks = data['result']['inks'] as List;

      final List<InkModel> listInks = dataInks.map((data) => InkModel.fromJson(data) ).toList();
      _fetchData.setData(listInks);

      // setState((){
      //   _is_loading = false;
      // });

    });

    basketModel = widget.basketModel;
    _total = basketModel.total;
    _printer = basketModel.printer;
    _pages = basketModel.pages;
    _pagesRange.text = basketModel.pagesRange;
    _copyPage.text = basketModel.copyPage;
    _notesDocument.text = basketModel.notes;
    _dropDownUkuranKertas = basketModel.ukuranKertas;
    _dropDownJenisKertas = basketModel.jenisKertas;
    _dropDownFinishing = basketModel.finishing;

    super.initState();
  }

  void _onSelectedInk(int value) async {
    setState(() {
      _ukuranKertas = ['Silahkan pilih'];

      _dropDownUkuranKertas = 'Silahkan pilih';
      _dropDownJenisKertas = 'Silahkan pilih';
      _dropDownFinishing = 'Silahkan pilih';

      _isLoading = true;
    });

    String ink = '';
    if (_printer == 1){
      ink = 'INK001';
    } else if (_printer == 2) {
      ink = 'INK002';
    }

    basketModel.printer = _printer;
    basketModel.printer_code = ink;

    _ukuranKertas = List.from(_ukuranKertas)..addAll(await _fetchData.getSizeByInk('INK001'));
    _sizeAll = List.from(_sizeAll)..addAll(await _fetchData.getSizeAll(ink));

    print(_printer);
    print(ink);
    print(_ukuranKertas.length);

    setState(() {
      _isLoading = false;
    });

  }

  Future<List<String>> getListUkuranKertas() async {
    return List.from(_ukuranKertas)..addAll(await _fetchData.getSizeByInk('INK001'));
  }

  void setToEdit(String inkCode) async {

    // setState(() {
    //   _ukuranKertas = ['Silahkan pilih'];
    // });

    _ukuranKertas = List.from(_ukuranKertas)..addAll(await _fetchData.getSizeByInk(inkCode));
    print(_ukuranKertas.length);
  }

  @override
  Widget build(BuildContext context) {

    _totalPrint = _priceJenisKertas + _priceFinishing;
    _total = _totalPrint + _totalDelivery;

    _fetchData.setData(_formService.listInkModel);

    var option = Row(
      children: [
        Radio(
          value: 1,
          groupValue: _printer,
          onChanged: (value) {
            setState(() {
              _printer = value as int;
              _onSelectedInk(value);
            });

          },
        ),

        Text(
          "Print Laser",
        ),

        Radio(
          value: 2,
          groupValue: _printer,
          onChanged: (value) {
            setState(() {
              _printer = value as int;
              _onSelectedInk(_printer);
            });
          },
        ),

        Text(
          "Print Tinta",
        ),

      ],
    );

    return
      // _is_loading ?
      //     Scaffold(
      //       body: Center(
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           children: const [
      //             CircularProgressIndicator(),
      //             SizedBox(height: 10,),
      //             Text('Please wait...')
      //           ],
      //         ),
      //       ),
      //     ) :
    Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Text('Print',),
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
                        _dropDownFinishing = 'Silahkan pilih';
                      });

                      String ink = 'INK002';
                      if (_printer == 1){
                        ink = 'INK001';
                      }
                      _jenisKertas = List.from(_jenisKertas)..addAll(await _fetchData.getPriceBySize(ink, _dropDownUkuranKertas));
                      _priceAll = List.from(_priceAll)..addAll(await _fetchData.getPriceBySizeAll(ink, _dropDownUkuranKertas));

                      _finishing = List.from(_finishing)..addAll(await _fetchData.getFinishingBySize(ink, _dropDownUkuranKertas));
                      _finishingAll = List.from(_finishingAll)..addAll(await _fetchData.getFinishingBySizeAll(ink, _dropDownUkuranKertas));

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

                      List<PriceModel> list = _priceAll.where((element) => element.price_code == value).map((e) => e).toList();

                      setState(() {
                        _dropDownJenisKertas = value!;
                        _priceJenisKertas = int.parse(list.first.price ?? '0');
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
                            _pages = value as int;
                          });
                        },
                      ),

                      Text(
                        "All",
                      ),

                      Radio(
                        value: 2,
                        groupValue: _pages,
                        onChanged: (value) {
                          setState(() {
                            _pages = value as int;
                          });
                        },
                      ),

                      Text(
                        "Page",
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
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
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
                    value: _dropDownFinishing,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) async {
                      List<FinishingModel> list = _finishingAll.where((element) => element.finish_code == value).map((e) => e).toList();

                      setState(() {
                        _dropDownFinishing = value!;
                        _priceFinishing = int.parse(list.first.price ?? '0');
                      });

                    },
                    items: _finishing.map<DropdownMenuItem<String>>((String value) {

                      List<FinishingModel> list = _finishingAll.where((element) => element.finish_code == value).map((e) => e).toList();

                      String text = "Silahkan pilih";
                      if (list.isNotEmpty) {
                        text = '${list.first.finish_text} - Rp ${list.first.price}';
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
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 2
                    ),
                    onPressed: () {},
                    // onPressed: _onSelectCheckBox(),
                    child: Text('Simpan'),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );

    // return FutureBuilder<Response>(
    //     //TODO: masih hardcode
    //     future: _formService.getFieldFormPrint("1"),
    //     builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
    //
    //       if (snapshot.hasData){
    //
    //         final data = jsonDecode(snapshot.data!.body);
    //
    //         var dataInks = data['result']['inks'] as List;
    //
    //         final List<InkModel> listInks = dataInks.map((data) => InkModel.fromJson(data) ).toList();
    //         _fetchData.setData(listInks);
    //
    //         /**
    //          * set data if exist
    //          */
    //
    //         return Scaffold(
    //           body: Container(
    //             child: SingleChildScrollView(
    //               child: Container(
    //                 alignment: Alignment.center,
    //                 child: Column(
    //                   children: [
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       width: double.infinity,
    //                       child: Text('Print',),
    //                       color: Colors.grey.withAlpha(50),
    //                     ),
    //                     option,
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       width: double.infinity,
    //                       child: Text('Ukuran Kertas'),
    //                       color: Colors.grey.withAlpha(50),
    //                     ),
    //
    //                     _isLoading ? CircularProgressIndicator() :
    //
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       width: double.infinity,
    //                       child: DropdownButton<String>(
    //                         value: _dropDownUkuranKertas,
    //                         hint: Text('Pilih'),
    //                         icon: const Icon(Icons.arrow_downward),
    //                         elevation: 16,
    //                         style: const TextStyle(color: Colors.deepPurple),
    //                         underline: Container(
    //                           height: 2,
    //                           color: Colors.deepPurpleAccent,
    //                         ),
    //                         onChanged: (String? value) async {
    //                           // This is called when the user selects an item.
    //                           setState(() {
    //                             _dropDownUkuranKertas = value!;
    //                             _dropDownJenisKertas = 'Silahkan pilih';
    //                             _dropDownFinishing = 'Silahkan pilih';
    //                           });
    //
    //                           String ink = 'INK002';
    //                           if (_printer == 1){
    //                             ink = 'INK001';
    //                           }
    //                           _jenisKertas = List.from(_jenisKertas)..addAll(await _fetchData.getPriceBySize(ink, _dropDownUkuranKertas));
    //                           _priceAll = List.from(_priceAll)..addAll(await _fetchData.getPriceBySizeAll(ink, _dropDownUkuranKertas));
    //
    //                           _finishing = List.from(_finishing)..addAll(await _fetchData.getFinishingBySize(ink, _dropDownUkuranKertas));
    //                           _finishingAll = List.from(_finishingAll)..addAll(await _fetchData.getFinishingBySizeAll(ink, _dropDownUkuranKertas));
    //
    //                         },
    //                         items: _ukuranKertas.map<DropdownMenuItem<String>>((String value) {
    //
    //                           List<SizeModel> list = _sizeAll.where((element) => element.size_code == value).map((e) => e).toList();
    //
    //                           String text = "Silahkan pilih";
    //                           if (list.isNotEmpty) {
    //                             text = '${list.first.size_name} - ${list.first.size_text}';
    //                           }
    //
    //                           return DropdownMenuItem<String>(
    //                             value: value,
    //                             child: Text(text),
    //                           );
    //                         }).toList(),
    //                       ),
    //                     ),
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       width: double.infinity,
    //                       child: Text('Jenis Kertas'),
    //                       color: Colors.grey.withAlpha(50),
    //                     ),
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       width: double.infinity,
    //                       child: DropdownButton<String>(
    //                         value: _dropDownJenisKertas,
    //                         icon: const Icon(Icons.arrow_downward),
    //                         elevation: 16,
    //                         style: const TextStyle(color: Colors.deepPurple),
    //                         underline: Container(
    //                           height: 2,
    //                           color: Colors.deepPurpleAccent,
    //                         ),
    //                         onChanged: (String? value) {
    //
    //                           List<PriceModel> list = _priceAll.where((element) => element.price_code == value).map((e) => e).toList();
    //
    //                           setState(() {
    //                             _dropDownJenisKertas = value!;
    //                             _priceJenisKertas = int.parse(list.first.price ?? '0');
    //                           });
    //                         },
    //                         items: _jenisKertas.map<DropdownMenuItem<String>>((String value) {
    //
    //                           List<PriceModel> list = _priceAll.where((element) => element.price_code == value).map((e) => e).toList();
    //
    //                           String text = "Silahkan pilih";
    //                           if (list.isNotEmpty) {
    //                             text = '${list.first.type_paper_name} - Rp ${list.first.price}';
    //
    //                           }
    //
    //                           return DropdownMenuItem<String>(
    //                             value: value,
    //                             child: Text(text),
    //                           );
    //                         }).toList(),
    //                       ),
    //                     ),
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       width: double.infinity,
    //                       child: Text('Halaman'),
    //                       color: Colors.grey.withAlpha(50),
    //                     ),
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       child: Row(
    //                         children: [
    //                           Radio(
    //                             value: 1,
    //                             groupValue: _pages,
    //                             onChanged: (value) {
    //                               setState(() {
    //                                 _pages = value as int;
    //                               });
    //                             },
    //                           ),
    //
    //                           Text(
    //                             "All",
    //                           ),
    //
    //                           Radio(
    //                             value: 2,
    //                             groupValue: _pages,
    //                             onChanged: (value) {
    //                               setState(() {
    //                                 _pages = value as int;
    //                               });
    //                             },
    //                           ),
    //
    //                           Text(
    //                             "Page",
    //                           ),
    //
    //                           SizedBox(width: 10,),
    //
    //                           Container(
    //                             width: 100,
    //                             child: TextFormField(
    //                               controller: _pagesRange,
    //                               decoration: InputDecoration(
    //                                 hintText: 'Page range',
    //                               ),
    //                             ),
    //                           )
    //
    //                         ],
    //                       ),
    //
    //                     ),
    //                     Container(
    //                       padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
    //                       child: Text('** masukkan range halaman atau per halaman cnth : 1-7 atau 1,2,6,7'),
    //                     ),
    //
    //
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       width: double.infinity,
    //                       child: Text('Copy'),
    //                       color: Colors.grey.withAlpha(50),
    //                     ),
    //
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       child: TextFormField(
    //                         controller: _copyPage,
    //                         keyboardType: TextInputType.number,
    //                         inputFormatters: <TextInputFormatter>[
    //                           FilteringTextInputFormatter.digitsOnly
    //                         ],
    //                         decoration: const InputDecoration(
    //                           hintText: 'Copy',
    //                         ),
    //                       ),
    //                     ),
    //
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       width: double.infinity,
    //                       child: Text('Finishing'),
    //                       color: Colors.grey.withAlpha(50),
    //                     ),
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       width: double.infinity,
    //                       child: DropdownButton<String>(
    //                         value: _dropDownFinishing,
    //                         icon: const Icon(Icons.arrow_downward),
    //                         elevation: 16,
    //                         style: const TextStyle(color: Colors.deepPurple),
    //                         underline: Container(
    //                           height: 2,
    //                           color: Colors.deepPurpleAccent,
    //                         ),
    //                         onChanged: (String? value) async {
    //                           List<FinishingModel> list = _finishingAll.where((element) => element.finish_code == value).map((e) => e).toList();
    //
    //                           setState(() {
    //                             _dropDownFinishing = value!;
    //                             _priceFinishing = int.parse(list.first.price ?? '0');
    //                           });
    //
    //                         },
    //                         items: _finishing.map<DropdownMenuItem<String>>((String value) {
    //
    //                           List<FinishingModel> list = _finishingAll.where((element) => element.finish_code == value).map((e) => e).toList();
    //
    //                           String text = "Silahkan pilih";
    //                           if (list.isNotEmpty) {
    //                             text = '${list.first.finish_text} - Rp ${list.first.price}';
    //                           }
    //
    //                           return DropdownMenuItem<String>(
    //                             value: value,
    //                             child: Text(text),
    //                           );
    //                         }).toList(),
    //                       ),
    //                     ),
    //
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       width: double.infinity,
    //                       child: Text('Catatan'),
    //                       color: Colors.grey.withAlpha(50),
    //                     ),
    //
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       child: TextFormField(
    //                         controller: _notesDocument,
    //                         decoration: InputDecoration(
    //                           hintText: 'Catatan untuk dokumen ini',
    //                         ),
    //                       ),
    //                     ),
    //
    //                     Container(
    //                       padding: EdgeInsets.all(20),
    //                       color: Colors.grey.withAlpha(50),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text('Total print: '),
    //                           Text('Rp ${_totalPrint}')
    //                         ],
    //                       ),
    //                     ),
    //
    //                     Container(
    //                       width: double.infinity,
    //                       padding: EdgeInsets.all(20),
    //                       child: ElevatedButton(
    //                         style: ElevatedButton.styleFrom(
    //                             elevation: 2
    //                         ),
    //                         onPressed: () {},
    //                         // onPressed: _onSelectCheckBox(),
    //                         child: Text('Simpan'),
    //                       ),
    //                     )
    //
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //
    //       } else if (snapshot.hasError){
    //         return Center(child: Text('error..${snapshot.error}'));
    //       }
    //
    //       return Scaffold(
    //         body: Container(
    //           child: Center(
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 CircularProgressIndicator(),
    //                 SizedBox(height: 10,),
    //                 Text('Please wait...')
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //
    //     }
    // );

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

  Future<List<String>> getFinishingBySize(String ink, String size) async {
    return Future.value(_data
        .where((item) => item.ink_code == ink)
        .map((e) => e.size!)
        .expand((element) => element)
        .map((e) => SizeModel.fromJson(e))
        .where((item) => item.size_code == size)
        .map((e) => e.finishing)
        .expand((element) => element)
        .map((e) => FinishingModel.fromJson(e))
        .map((e) => e.finish_code!)
        .toList());
  }
  
  Future<List<FinishingModel>> getFinishingBySizeAll(String ink, String size) async {
    return Future.value(_data
        .where((item) => item.ink_code == ink)
        .map((e) => e.size!)
        .expand((element) => element)
        .map((e) => SizeModel.fromJson(e))
        .where((item) => item.size_code == size)
        .map((e) => e.finishing)
        .expand((element) => element)
        .map((e) => FinishingModel.fromJson(e))
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