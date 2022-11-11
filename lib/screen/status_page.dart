import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/format_number.dart';
import 'package:siapprint/model/status_detail_model.dart';
import 'package:siapprint/model/status_model.dart';
import 'package:siapprint/model/user_model.dart';
import 'package:siapprint/repository/login_service.dart';
import 'package:siapprint/repository/status_service.dart';
import 'package:siapprint/screen/account_setting.dart';
import 'package:siapprint/screen/basket3_page.dart';
import 'package:siapprint/screen/home_page.dart';
import 'package:siapprint/screen/naivgation/app_navigation.dart';
import 'package:siapprint/screen/naivgation/bottom_bar.dart';
import 'package:siapprint/screen/upload_page.dart';

class StatusPage extends StatefulWidget {

  static String tag = 'status-page';

  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatusPage();

}

class _StatusPage extends State<StatusPage> {

  StatusService _statusService = StatusService();
  String _statuscode = 'Sedang berjalan';

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
                            padding: EdgeInsets.all(20),
                            child: Text('Sedang berjalan',),
                          ),
                          _statuscode.contains('Sedang berjalan') ? Container(height: 2, color: Colors.lightBlue, width: double.infinity,) : Container(height: 2, color: Colors.white38, width: double.infinity,)
                        ],
                      ),
                    ),
                    onTap: () {
                      setState((){
                        _statuscode = 'Sedang berjalan';
                      });
                    },
                  )),

                  Expanded(child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Text('Selesai',),
                          ),
                          _statuscode.contains('Selesai') ? Container(height: 2, color: Colors.lightBlue, width: double.infinity,) : Container(height: 2, color: Colors.white38, width: double.infinity,)
                        ],
                      ),
                    ),
                    onTap: () {
                      setState((){
                        _statuscode = 'Selesai';
                      });
                    },
                  )),

                ],
              ),
            ),

            Expanded(child: FutureBuilder(
                future: _statusService.getListStatus(_statuscode),
                builder: (BuildContext context,
                    AsyncSnapshot<List<StatusModel>> snapshot){

                  if (snapshot.hasData) {

                    if (snapshot.data!.isEmpty){
                      return const Center(child: Text('No data'));
                    }

                    final list = snapshot.data!;

                    return ListView.separated(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext content, int index) {

                          final detail = snapshot.data![index].status_detail as List;
                          final listDetail = detail.map((data) => StatusDetailModel.fromJson2(data) ).toList();

                          return InkWell(
                            onTap: (){
                              showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: (BuildContext context) {
                                return StatefulBuilder(builder: (BuildContext context, setState){
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

                                          Expanded(child: Container(
                                            child: ListView.separated(
                                                itemCount: listDetail.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Column(
                                                    children: [
                                                      Text('${listDetail[index].filename}'),
                                                      Text('${listDetail[index].ink_name} | '
                                                          '${listDetail[index].size_name} | '
                                                          '${listDetail[index].type_paper_name} | '
                                                          '${listDetail[index].finish_text} | '
                                                          'copy: ${listDetail[index].copy} | '
                                                          'total hal:${listDetail[index].total_pages} | '
                                                          '${listDetail[index].pages_remarks} | '
                                                          '${listDetail[index].ntgew_d}kg | '
                                                          '${MyNumber.convertToIdr(double.parse(listDetail[index].amount_d!))} | '
                                                          'catatan: ${listDetail[index].remarks_d} '
                                                      )
                                                    ],
                                                  );
                                                }, separatorBuilder: (BuildContext context, int index) => const Divider()),
                                          ))
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text('ID: ${list[index].print_h_code} | ${list[index].company_name}'),
                                  Text('${list[index].comp_address}, ${list[index].regencies_name}, ${list[index].provinces_name}',
                                    style: TextStyle(fontSize: 12),),

                                  SizedBox(height: 20,),

                                  Container(
                                    width: double.infinity,
                                    child: Text('Pengiriman: ${list[index].delv_name}'),
                                  ),

                                  SizedBox(height: 20,),

                                  Container(
                                      width: double.infinity,
                                      child: Text(
                                        '${list[index].created_at} | '
                                            '${list[index].ntgew_h} | '
                                            '${list[index].ntgew_uom_h} | '
                                            '${MyNumber.convertToIdr(double.parse(list[index].amount_p!))} | '
                                            '${MyNumber.convertToIdr(double.parse(list[index].delv_cost!))} | '
                                            '${MyNumber.convertToIdr(double.parse(list[index].amount_h!))}', style: TextStyle(fontSize: 12),)
                                  )
                                ],
                              ),
                            ),
                          );

                        }, separatorBuilder: (BuildContext context, int index) => const Divider(),);

                  } else if (snapshot.hasError){
                    return Center(child: Text('error..${snapshot.error}'));
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


                }))

          ],
        ),
      )
    );
  }


}