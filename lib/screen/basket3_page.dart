

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/company_model.dart';
import 'package:siapprint/model/provinsi_model.dart';
import 'package:siapprint/model/transaction_model.dart';
import 'package:siapprint/repository/basket_service.dart';
import 'package:siapprint/repository/company_serive.dart';
import 'package:siapprint/screen/checkout_page.dart';
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
  Future<List<CompanyModel>>? listCompanyFilter;
  late Future<List<BasketModel>> _listBasket2;

  String _dropDownProvinsi = 'Silahkan pilih';
  List<String> _provinsi = ['Silahkan pilih'];

  CompanyModel? companyModel;
  setCompanySelected(CompanyModel value){
    setState((){
      companyModel = value;
    });
  }

  Widget currentAddress(List<CompanyModel> companyModels) {

    CompanyModel selectedCompanyModel = companyModel == null ? _companyService.listCompany.first : companyModel!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.lightBlue, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(selectedCompanyModel.comp_name != null ? selectedCompanyModel.comp_name! : '-', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(selectedCompanyModel.comp_address != null ? '${selectedCompanyModel.comp_address!}, ${selectedCompanyModel.regencies_name!}, ${selectedCompanyModel.provinces_name!}' : '-'),

          selectedCompanyModel.price_status == null && selectedCompanyModel.price_finish_status == null ?
              const Text('Coming soon')
          :
          companyModel == null ? ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 2),
              onPressed: () {
                setState((){
                  companyModel = selectedCompanyModel;
                });
              },
              child: const Text('Pilih'),
            ) : OutlinedButton(
              onPressed: () {
                setState((){
                  companyModel = null;
                });
              },
            style: ElevatedButton.styleFrom(primary: Colors.white38),
              child: const Text('Batal'),
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
                        style: const TextStyle(fontWeight: FontWeight.bold)),
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
    listCompanyFilter = _companyService.getCompanyFilter(_dropDownProvinsi == 'Silahkan pilih' ? '' : _dropDownProvinsi);

    // _companyService.getProvinsiId(_dropDownProvinsi).then((value) => {
    //   _dropDownProvinsi = value
    // });
  }

  void getDataBasket() async {
    _listBasket = List.from(_listBasket)..addAll(await _basketService.getBasket2());
  }

  void _chooseOtherTapPlace(List<ProvinsiModel> data) async {

    setState((){
      _dropDownProvinsi = 'Silahkan pilih';
    });
    _provinsi = List.from(_provinsi)..addAll(await _companyService.getProvinsiByUser(data));
  }

  Future<void> _refreshBaskets(BuildContext context) async {
    return fetchBasket();
  }

  Future fetchBasket() async {
    _basketService.getBasket2();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child:

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  width: double.infinity,
                  child: const Text('Tempat print yang kami rekomendasikan')
              ),
              const SizedBox(height: 10,),

              Container(
                child: FutureBuilder(
                    future: _companyService.getCompany(),
                    builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {

                      if (snapshot.hasData){
                        if (_companyService.allListCompany.isNotEmpty){
                          return currentAddress(_companyService.allListCompany);
                        }
                        return Container(
                            alignment: Alignment.center,
                            child: Text(_companyService.msg)
                        );
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
                              child: const CircularProgressIndicator(),
                            ),
                            const SizedBox(height: 10,),
                            const Text('Please wait...')
                          ],
                        ),
                      );

                    }
                ),
              ),

              const SizedBox(height: 10,),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {

                    _chooseOtherTapPlace(_companyService.listProvince);

                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context, builder: (BuildContext context) {

                      return StatefulBuilder(builder: (BuildContext context, setState) {
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

                                Container(
                                  padding: const EdgeInsets.all(20),
                                  width: double.infinity,
                                  child: DropdownButton<String>(
                                    value: _dropDownProvinsi,
                                    hint: const Text('Pilih'),
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
                                        _dropDownProvinsi = value!;

                                        listCompanyFilter = _companyService.getCompanyFilter(_dropDownProvinsi == 'Silahkan pilih' ? '' : _dropDownProvinsi);

                                      });

                                    },
                                    items: _provinsi.map<DropdownMenuItem<String>>((String value) {

                                      List<String> list = _companyService.getAllProvinsiByUser(_companyService.listProvince, value);

                                      String text = "Silahkan pilih";
                                      if (list.isNotEmpty) {
                                        text = list.first;
                                      }

                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(text),
                                      );
                                    }).toList(),
                                  ),
                                ),

                                Expanded(
                                  child: FutureBuilder(
                                      future: listCompanyFilter,
                                      builder: (BuildContext context, AsyncSnapshot<List<CompanyModel>> list) {

                                        if (list.hasData) {
                                          if(list.data == null) {
                                            return Container(
                                              alignment: Alignment.center,
                                              child: const Text('data not found'),
                                            );
                                          }
                                          return StatefulBuilder(builder: (BuildContext context, setState) {
                                            return Column(
                                              children: List.generate(list.data!.length, (index) {
                                                return Column(
                                                  children: [
                                                    Container(
                                                      child: Container(
                                                        padding: const EdgeInsets.all(20),
                                                        child: Row(
                                                          children: [
                                                            Expanded(child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(list.data![index].comp_name != null ? list.data![index].comp_name! : '-', style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                Text(list.data![index].comp_address != null ? '${list.data![index].comp_address!}, ${list.data![index].regencies_name!}, ${list.data![index].provinces_name!}' : '-'),
                                                              ],
                                                            )),

                                                            const SizedBox(width: 10),

                                                            list.data![index].price_status == null && list.data![index].price_finish_status == null ?
                                                            const Text('Coming soon') : ElevatedButton(
                                                              style: ElevatedButton.styleFrom(elevation: 2),
                                                              onPressed: () {
                                                                setCompanySelected(list.data![index]);
                                                                Navigator.pop(context);
                                                              },
                                                              child: const Text('Pilih'),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }),
                                            );
                                          });
                                        } else if (list.hasError) {
                                          return Container(
                                            alignment: Alignment.center,
                                            child: const Text('something wrong'),
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

                                      }),
                                ),

                              ],
                            ),
                          ),
                        );
                      });

                    });
                  },
                  child: const Text('Pilih tempat lain'),
                ),
              ),

              const SizedBox(height: 10,),

              Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: double.infinity,
                  child: const Text('List dokumen')
              ),

              Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => _refreshBaskets(context),
                    child: FutureBuilder(
                        future: _listBasket2,
                        builder : (BuildContext context, AsyncSnapshot<List<BasketModel>> snapshot) {

                          if (snapshot.hasData) {

                            if (_basketService.listBasket.isEmpty){
                              return Container(
                                alignment: Alignment.center,
                                child: const Text('List dokumen kosong'),
                              );
                            }

                            return ListView.separated(
                              padding: const EdgeInsets.all(8),
                              itemCount: _basketService.listBasket.length,
                              itemBuilder: (BuildContext context, int index) {
                                return widgetListDocument(index);
                              },
                              separatorBuilder: (BuildContext context, int index) => const Divider(),
                            );
                          } else if (snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              child: const Text('something wrong'),
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


                        }),
                  )
              ),

              const SizedBox(height: 10,),

              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      elevation: 2,
                    ),
                    onPressed: _basketService.listBasket.where((e) => e.is_checked == true).toList().isEmpty ? null : () {

                      Dialogs.materialDialog(
                        context: context,
                        msg: 'Delete file?',
                        title: 'Delete',
                        color: Colors.white,
                        actions: [
                          IconsOutlineButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: 'Cancel',
                            textStyle: const TextStyle(color: Colors.grey),
                          ),
                          IconsButton(
                            onPressed: () {
                              _basketService.deleteFileBasket(_basketService.listBasket.where((e) => e.is_checked == true).toList()).then((value) {
                                setState((){
                                  _basketService.listBasket = value;
                                });
                              });
                              Navigator.of(context).pop();
                            },
                            text: 'Delete',
                            color: Colors.red,
                            textStyle: const TextStyle(color: Colors.white),
                          ),
                        ]
                      );


                    },
                    child: const Text('Hapus'),
                  ),

                  const SizedBox(width: 10,),

                  Expanded(child: Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 2
                      ),
                      onPressed: (){

                        List<BasketModel> basketListSelected = _basketService.listBasket.where((e) => e.is_checked == true).toList();

                        if (companyModel == null) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Mohon tempat print dipilih terlebih dahulu'),
                          ));
                        } else if (basketListSelected.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Mohon pilih dokumen yang akan di print'),
                          ));
                        } else if (_companyService.msg != ''){

                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Mohon untuk lengkapi alamat utama'),
                          ));

                        } else {
                          TransactionModel transactionModel = TransactionModel(
                              listBasketModel: basketListSelected,
                              companyModel: companyModel!,
                              total_print: 0,
                              delivery_id: 0,
                              delivery_code: '',
                              total: 0);

                          Navigator.of(context).pushNamed(CheckoutPage.tag, arguments: transactionModel);
                        }


                      },
                      child: const Text('Proses'),
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