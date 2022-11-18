
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/config/format_number.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/finishing_model.dart';
import 'package:siapprint/model/inks_model.dart';
import 'package:siapprint/model/price_model.dart';
import 'package:siapprint/model/size_model.dart';
import 'package:siapprint/repository/form_service.dart';

typedef StringValue = Function(BasketModel);

class FormPrintPage extends StatefulWidget {

  FormPrintPage({ Key? key, required this.basketModel, this.comp_id, this.callback}) : super(key: key);

  static String tag = 'form-print-page';
  final BasketModel basketModel;
  final String? comp_id;
  StringValue? callback;

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
  double _totalWeight = 0;
  double _weightJenisKertas = 0;
  double _weightFinishing = 0;
  final int _totalDelivery = 0;
  final int _total = 0;

  List<String> _ukuranKertas = ['Silahkan pilih'];
  List<String> _jenisKertas =  ['Silahkan pilih'];
  List<String> _finishing =  ['Silahkan pilih'];
  List<SizeModel> _sizeAll = [];
  List<PriceModel> _priceAll = [];
  List<FinishingModel> _finishingAll = [];

  int _pages = 0;
  final TextEditingController _pagesRange = TextEditingController();
  final TextEditingController _copyPage = TextEditingController();
  final List<String> _finishingDocument = <String>['Jilid', 'Polos'];
  final TextEditingController _notesDocument = TextEditingController();

  String _dropDownUkuranKertas = 'Silahkan pilih';
  String _dropDownJenisKertas = 'Silahkan pilih';
  String _dropDownFinishing = 'Silahkan pilih';

  late BasketModel basketModel;

  final _formService = FormService();
  final _fetchData = FetchDataPrint();

  List<InkModel> _dataInk = [];

  @override
  void initState() {

    basketModel = widget.basketModel;

    setState((){
      _is_loading = true;
    });

    _formService.getFieldFormPrint(widget.comp_id!).then((value) {

      final data = jsonDecode(value.body);

      var dataInks = data['result']['inks'] as List;

      final List<InkModel> listInks = dataInks.map((data) => InkModel.fromJson(data) ).toList();
      _fetchData.setData(listInks);

      setState((){
        _is_loading = false;
        _dataInk = listInks;

        /**
         * set to edit
         */
        if (basketModel.printer != 0) {
          _printer = basketModel.printer;
          _onSelectedInk(basketModel.printer);
        }

        if (!basketModel.ukuranKertas.contains('Silahkan pilih')){
          _dropDownUkuranKertas = basketModel.ukuranKertas;
        }

        if (!basketModel.jenisKertas.contains('Silahkan pilih')){

          _onSelectedSize(_printer);

          _dropDownJenisKertas = basketModel.jenisKertas;
        }

        if (!basketModel.finishing.contains('Silahkan pilih')){
          _dropDownFinishing = basketModel.finishing;
        }

        if (basketModel.pages != 0) {
          _pages = basketModel.pages;
          _pagesRange.text = basketModel.pagesRange;
        }

        _copyPage.text = basketModel.copyPage;
        _notesDocument.text = basketModel.notes;

        _priceJenisKertas = basketModel.priceJenisKertas;
        _priceFinishing = basketModel.priceFinishing;
        _weightJenisKertas = basketModel.weightJenisKertas;
        _weightFinishing = basketModel.weightFinishing;
        // _totalPrint = basketModel.total;


      });

    });

    // _total = basketModel.total;
    // _printer = basketModel.printer;
    // _pages = basketModel.pages;
    // _pagesRange.text = basketModel.pagesRange;
    // _copyPage.text = basketModel.copyPage;
    // _notesDocument.text = basketModel.notes;
    // _dropDownUkuranKertas = basketModel.ukuranKertas;
    // _dropDownJenisKertas = basketModel.jenisKertas;
    // _dropDownFinishing = basketModel.finishing;

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
    if (value == 1){
      ink = Constant.INK_LASER;
    } else if (value == 2) {
      ink = Constant.INK_TINTA;
    }

    _ukuranKertas = List.from(_ukuranKertas)..addAll(await _fetchData.getSizeByInk(ink, _dataInk));
    _sizeAll = List.from(_sizeAll)..addAll(await _fetchData.getSizeAll(ink, _dataInk));

    setState(() {
      _isLoading = false;
    });

  }

  void _onSelectedSize(int value) async {

    String ink = '';
    if (value == 1){
      ink = Constant.INK_LASER;
    } else if (value == 2) {
      ink = Constant.INK_TINTA;
    }

    setState(() {
      _jenisKertas = ['Silahkan pilih'];
      _finishing = ['Silahkan pilih'];
    });

    _jenisKertas = List.from(_jenisKertas)..addAll(await _fetchData.getPriceBySize(ink, _dropDownUkuranKertas, _dataInk));
    _priceAll = List.from(_priceAll)..addAll(await _fetchData.getPriceBySizeAll(ink, _dropDownUkuranKertas, _dataInk));

    _finishing = List.from(_finishing)..addAll(await _fetchData.getFinishingBySize(ink, _dropDownUkuranKertas, _dataInk));
    _finishingAll = List.from(_finishingAll)..addAll(await _fetchData.getFinishingBySizeAll(ink, _dropDownUkuranKertas, _dataInk));

  }

  void setToEdit(String inkCode) async {

    // setState(() {
    //   _ukuranKertas = ['Silahkan pilih'];
    // });

    _ukuranKertas = List.from(_ukuranKertas)..addAll(await _fetchData.getSizeByInk(inkCode, _fetchData._data));
    print(_ukuranKertas.length);
  }

  @override
  Widget build(BuildContext context) {

    _totalPrint = _priceJenisKertas + _priceFinishing;
    _totalWeight = _weightJenisKertas + _weightFinishing;
    print('total : $_weightJenisKertas + $_weightFinishing');
    _totalWeight = double.parse(_totalWeight.toStringAsFixed(3));

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

        const Text(
          "Print Laser",
        ),

        Radio(
          value: 2,
          groupValue: _printer,
          onChanged: (value) {
            setState(() {
              _printer = value as int;
              _onSelectedInk(value);
            });
          },
        ),

        const Text(
          "Print Tinta",
        ),

      ],
    );

    return
      _is_loading ?
          Scaffold(
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
          ) :
    Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [

                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.grey.withAlpha(50),
                  child: const Text('Print',),
                ),
                option,
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.grey.withAlpha(50),
                  child: const Text('Ukuran Kertas'),
                ),

                _isLoading ? const CircularProgressIndicator() :

                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: DropdownButton<String>(
                    value: _dropDownUkuranKertas,
                    hint: const Text('Pilih'),
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

                      _onSelectedSize(_printer);

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
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.grey.withAlpha(50),
                  child: const Text('Jenis Kertas'),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
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

                      List<PriceModel> list = _priceAll.where((element) => element.type_paper_code == value).map((e) => e).toList();

                      setState(() {
                        _dropDownJenisKertas = value!;
                        _priceJenisKertas = int.parse(list.first.price ?? '0');
                        _weightJenisKertas = double.parse(list.first.weight ?? '0');
                        print('weight finishing: ${list.first.weight}');

                        basketModel.priceJenisKertas = _priceJenisKertas;
                        basketModel.weightJenisKertas = _weightJenisKertas;
                      });
                    },
                    items: _jenisKertas.map<DropdownMenuItem<String>>((String value) {

                      List<PriceModel> list = _priceAll.where((element) => element.type_paper_code == value).map((e) => e).toList();

                      String text = "Silahkan pilih";
                      if (list.isNotEmpty) {
                        text = '${list.first.type_paper_name} - ${MyNumber.convertToIdr(int.parse(list.first.price ?? '0'))}';

                      }

                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(text),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.grey.withAlpha(50),
                  child: const Text('Halaman'),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
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

                      const Text(
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

                      const Text(
                        "Page",
                      ),

                      const SizedBox(width: 10,),

                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          controller: _pagesRange,
                          onChanged: (String? value) {
                          },
                          decoration: const InputDecoration(
                            hintText: 'Page range',
                          ),
                        ),
                      )

                    ],
                  ),

                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                  child: const Text('** masukkan range halaman atau per halaman cnth : 1-7 atau 1,2,6,7'),
                ),


                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.grey.withAlpha(50),
                  child: const Text('Copy'),
                ),

                Container(
                  padding: const EdgeInsets.all(20),
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
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.grey.withAlpha(50),
                  child: const Text('Finishing'),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
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
                        _weightFinishing = double.parse(list.first.weight ?? '0');
                        print('weight finishing: ${list.first.weight}');

                        basketModel.priceFinishing = _priceFinishing;
                        basketModel.weightFinishing = _weightFinishing;

                      });

                    },
                    items: _finishing.map<DropdownMenuItem<String>>((String value) {

                      List<FinishingModel> list = _finishingAll.where((element) => element.finish_code == value).map((e) => e).toList();

                      String text = "Silahkan pilih";
                      if (list.isNotEmpty) {
                        text = '${list.first.finish_text} - ${MyNumber.convertToIdr(int.parse(list.first.price ?? '0'))}';
                      }

                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(text),
                      );
                    }).toList(),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.grey.withAlpha(50),
                  child: const Text('Catatan'),
                ),

                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _notesDocument,
                    onChanged: (String? value) {
                    },
                    decoration: const InputDecoration(
                      hintText: 'Catatan untuk dokumen ini',
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.grey.withAlpha(50),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total print: '),
                          Text(MyNumber.convertToIdr(_totalPrint))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total weight: '),
                          Text('$_totalWeight kg')
                        ],
                      ),
                    ],
                  )
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 2
                    ),
                    onPressed: () {

                      String ink = '';
                      if (_printer == 1){
                        ink = Constant.INK_LASER;
                      } else if (_printer == 2) {
                        ink = Constant.INK_TINTA;
                      }

                      basketModel.printer = _printer;
                      basketModel.printer_code = ink;
                      basketModel.ukuranKertas = _dropDownUkuranKertas;
                      basketModel.jenisKertas = _dropDownJenisKertas;
                      basketModel.pages = _pages;
                      basketModel.pagesRange = _pagesRange.text;
                      basketModel.copyPage = _copyPage.text;
                      basketModel.finishing = _dropDownFinishing;
                      basketModel.notes = _notesDocument.text;
                      basketModel.total = _totalPrint;
                      basketModel.totalWeight = _totalWeight;

                      String errorMsg = '';
                      if (basketModel.printer == 0) {
                        errorMsg = 'Printer harus dipilih';
                      } else if (basketModel.ukuranKertas.contains('Silahkan pilih')) {
                        errorMsg = 'Ukuran kertas harus dipilih';
                      } else if (basketModel.jenisKertas.contains('Silahkan pilih')) {
                        errorMsg = 'Jenis kertas harus dipilih';
                      } else if (basketModel.pages == 0) {
                        errorMsg = 'Halaman harus dipilih';
                      } else if (basketModel.copyPage == '' || basketModel.copyPage == '0') {
                        errorMsg = 'Copy harus dipilih';
                      } else if (basketModel.finishing.contains('Silahkan pilih')) {
                        errorMsg = 'Finishing harus dipilih';
                      } else if (basketModel.pages == 2){
                        if (basketModel.pagesRange == '') {
                          errorMsg = 'Page range harus dipilih';
                        }
                      }

                      if (errorMsg != ''){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(errorMsg),
                        ));
                      } else {

                        widget.callback!(basketModel);

                        Navigator.pop(context);
                      }

                    },
                    // onPressed: _onSelectCheckBox(),
                    child: const Text('Simpan'),
                  ),
                ),


              ],
            ),
          ),
        )
      ),
    );

  }
}

class FetchDataPrint {

  List<InkModel> _data = [];
  List<InkModel> setData(List<InkModel> list) => _data = list;

  Future<List<String>> getSizeByInk(String state, List<InkModel> data) async {

    return Future.value(data
        .where((item) => item.ink_code == state)
        .map((e) => e.size!)
        .expand((element) => element)
        .map((e) => SizeModel.fromJson(e))
        .map((e) => e.size_code!)
        .toList());

  }

  Future<List<String>> getPriceBySize(String ink, String size, List<InkModel> data) async {

    return Future.value(data
        .where((item) => item.ink_code == ink)
        .map((e) => e.size!)
        .expand((element) => element)
        .map((e) => SizeModel.fromJson(e))
        .where((item) => item.size_code == size)
        .map((e) => e.prices)
        .expand((element) => element)
        .map((e) => PriceModel.fromJson(e))
        .map((e) => e.type_paper_code!)
        .toList());

  }

  Future<List<PriceModel>> getPriceBySizeAll(String ink, String size, List<InkModel> data) async {
    return Future.value(data
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

  Future<List<String>> getFinishingBySize(String ink, String size, List<InkModel> data) async {
    return Future.value(data
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
  
  Future<List<FinishingModel>> getFinishingBySizeAll(String ink, String size, List<InkModel> data) async {
    return Future.value(data
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

  Future<List<SizeModel>> getSizeAll(String ink, List<InkModel> data) async {

    return Future.value(data
        .where((item) => item.ink_code == ink)
        .map((e) => e.size!)
        .expand((element) => element)
        .map((e) => SizeModel.fromJson(e))
        .toList());

  }

}