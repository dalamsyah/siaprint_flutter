
import 'package:flutter/material.dart';


class SamplePage extends StatefulWidget {

  const SamplePage({ Key? key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
//   Repository repo = Repository();
//   RepoSampel repo2 = RepoSampel();
//
//   List<String> _states = ["Choose a state"];
//   List<String> _lgas = ["Choose .."];
//   List<String> _lgas2 = ["Choose .."];
//
//   List<SizeModel> sizeModelList = [];
//
//   String _selectedState = "Choose a state";
//   String _selectedLGA = "Choose ..";
//   bool _isLoading = false;
//
//   String _selectedState2 = "Choose a state";
//   String _selectedLGA2 = "Choose ..";
//   bool _isLoading2 = false;
//
//   @override
//   void initState() {
//     // _states = List.from(_states)..addAll(repo.getStates());
//     _states = List.from(_states)..addAll(repo2.getSize());
//
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("STATES MULTI DROPDOWN"),
//         elevation: 0.1,
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
//           child: Column(
//             children: <Widget>[
//
//
//               DropdownButton<String>(
//                 isExpanded: true,
//                 items: _states.map((String dropDownStringItem) {
//                   return DropdownMenuItem<String>(
//                     value: dropDownStringItem,
//                     child: Text(dropDownStringItem),
//                   );
//                 }).toList(),
//                 onChanged: (value) => _onSelectedState2(value!),
//                 value: _selectedState,
//               ),
//
//
//               _isLoading
//                   ? CircularProgressIndicator()
//                   : DropdownButton<String>(
//                 isExpanded: true,
//                 items: _lgas.map((String dropDownStringItem) {
//
//                   List<SizeModel> list = sizeModelList.where((element) => element.size_code == dropDownStringItem).map((e) =>
//                   e
//                   ).toList();
//
//                   String text = "Choose...";
//                   if (list.isNotEmpty) {
//                     text = '${list.first.size_name} - ${list.first.size_text}';
//                   }
//
//                   return DropdownMenuItem<String>(
//                     value: dropDownStringItem,
//                     child: Text(text),
//                   );
//                 }).toList(),
//                 // onChanged: (value) => print(value),
//                 onChanged: (value) => _onSelectedState3(_selectedState, value!),
//                 value: _selectedLGA,
//               ),
//
//
//               _isLoading2
//                   ? CircularProgressIndicator()
//                   : DropdownButton<String>(
//                 isExpanded: true,
//                 items: _lgas2.map((String dropDownStringItem) {
//                   return DropdownMenuItem<String>(
//                     value: dropDownStringItem,
//                     child: Text(dropDownStringItem),
//                   );
//                 }).toList(),
//                 // onChanged: (value) => print(value),
//                 onChanged: (value) => _onSelectedLGA3(value!),
//                 value: _selectedLGA2,
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _onSelectedState(String value) async {
//     setState(() {
//       _selectedLGA = "Choose ..";
//       _selectedState = value;
//       _lgas = ["Choose .."];
//       _isLoading = true;
//     });
//
//     _lgas = List.from(_lgas)..addAll(await repo.getLocalByState(value));
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   void _onSelectedLGA(String value) {
//     setState(() => _selectedLGA = value);
//   }
//
//
//   void _onSelectedState2(String value) async {
//     setState(() {
//       _selectedLGA = "Choose ..";
//       _selectedState = value;
//       _lgas = ["Choose .."];
//       _isLoading = true;
//     });
//
//     _lgas = List.from(_lgas)..addAll(await repo2.getSizeByInk(value));
//     sizeModelList = List.from(sizeModelList)..addAll(await repo2.getSizeByInk2(value));
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   void _onSelectedLGA2(String value) {
//     setState(() => _selectedLGA = value);
//   }
//
//
//   void _onSelectedState3(String value, String size) async {
//
//     setState(() {
//       _selectedLGA2 = "Choose ..";
//       _selectedLGA = size;
//       _lgas2 = ["Choose .."];
//       _isLoading2 = true;
//     });
//
//     _lgas2 = List.from(_lgas2)..addAll(await repo2.getPriceBySize(value, size));
//
//     setState(() {
//       _isLoading2 = false;
//     });
//   }
//
//   void _onSelectedLGA3(String value) {
//     setState(() => _selectedLGA2 = value);
//   }

}

class ResultSample {

}

class RepoSampel {

  // List getAll() => _data;
  //
  // List<String> getSize() => _data.map((e) => InkModel.fromJson(e))
  //     .map((item) => item.ink_code!)
  //     .toList();
  //
  //
  // Future<List<String>> getSizeByInk(String state) async {
  //   await Future.delayed(Duration(seconds: 1), () {
  //     print("Future.delayed");
  //   });
  //
  //   // print( jsonEncode(_data
  //   //     .map((map) => InkModel.fromJson(map))
  //   //     .where((item) => item.ink_code == state)
  //   //     .map((e) => e.size!)
  //   //     .expand((element) => element)
  //   //     .map((e) => SizeModel.fromJson(e))
  //   //     .where((element) => element.size_code == 'SIZ001')
  //   //     .map((e) => e.prices)
  //   //     .expand((element) => element)
  //   //     .map((e) => PriceModel.fromJson(e))
  //   //     .map((e) => e.type_paper_name)
  //   //     .toList()) );
  //
  //
  //   return Future.value(_data
  //       .map((map) => InkModel.fromJson(map))
  //       .where((item) => item.ink_code == state)
  //       .map((e) => e.size!)
  //       .expand((element) => element)
  //       .map((e) => SizeModel.fromJson(e))
  //       .map((e) => e.size_code!)
  //       // .map((e) => '${e.size_name} - ${e.size_text!}')
  //       .toList());
  //
  // }
  //
  //
  // Future<List<SizeModel>> getSizeByInk2(String state) async {
  //   await Future.delayed(Duration(seconds: 1), () {
  //     print("Future.delayed");
  //   });
  //
  //
  //   return Future.value(_data
  //       .map((map) => InkModel.fromJson(map))
  //       .where((item) => item.ink_code == state)
  //       .map((e) => e.size!)
  //       .expand((element) => element)
  //       .map((e) => SizeModel.fromJson(e))
  //       .toList());
  //
  // }
  //
  //
  // Future<List<String>> getPriceBySize(String state, String size) async {
  //   await Future.delayed(Duration(seconds: 1), () {
  //     print("Future.delayed");
  //   });
  //
  //
  //   return Future.value(_data
  //       .map((map) => InkModel.fromJson(map))
  //       .where((item) => item.ink_code == state)
  //       .map((e) => e.size!)
  //       .expand((element) => element)
  //       .map((e) => SizeModel.fromJson(e))
  //       .where((item) => item.size_code == size)
  //       .map((e) => e.prices)
  //       .expand((element) => element)
  //       .map((e) => PriceModel.fromJson(e))
  //       .map((e) => e.type_paper_name!)
  //       .toList());
  //
  //   // .map((item) => item.size)
  //   // .map((item) => item.size_code!)
  //   // .toList());
  // }

  final List _data = [
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
  ];

}

class Repository {
  // http://locationsng-api.herokuapp.com/api/v1/lgas
  // test() => _nigeria.map((map) => StateModel.fromJson(map));
  List getAll() => _nigeria;

  /*getLocalByState(String state) => _nigeria
      .map((map) => StateModel.fromJson(map))
      .where((item) => item.state == state)
      .map((item) => item.lgas)
      .expand((i) => i)
      .toList();*/

  Future<List<String>> getLocalByState(String state) async {
    await Future.delayed(const Duration(seconds: 5), () {
      print("Future.delayed");
    });


    return Future.value(_nigeria
        .map((map) => StateModel.fromJson(map))
        .where((item) => item.state == state)
        .map((item) => item.lgas)
        .expand((i) => i)
        .toList());
  }

  List<String> getStates() => _nigeria
      .map((map) => StateModel.fromJson(map))
      .map((item) => item.state)
      .toList();
  // _nigeria.map((item) => item['state'].toString()).toList();

  final List _nigeria = [
    {
      "state": "Adamawa",
      "alias": "adamawa",
      "lgas": [
        "Demsa",
        "Fufure",
        "Ganye",
        "Gayuk",
        "Gombi",
        "Grie",
        "Hong",
        "Jada",
        "Larmurde",
        "Madagali",
        "Maiha",
        "Mayo Belwa",
        "Michika",
        "Mubi North",
        "Mubi South",
        "Numan",
        "Shelleng",
        "Song",
        "Toungo",
        "Yola North",
        "Yola South"
      ]
    },
    {
      "state": "Akwa Ibom",
      "alias": "akwa_ibom",
      "lgas": [
        "Abak",
        "Eastern Obolo",
        "Eket",
        "Esit Eket",
        "Essien Udim",
        "Etim Ekpo",
        "Etinan",
        "Ibeno",
        "Ibesikpo Asutan",
        "Ibiono-Ibom",
        "Ikot Abasi",
        "Ika",
        "Ikono",
        "Ikot Ekpene",
        "Ini",
        "Mkpat-Enin",
        "Itu",
        "Mbo",
        "Nsit-Atai",
        "Nsit-Ibom",
        "Nsit-Ubium",
        "Obot Akara",
        "Okobo",
        "Onna",
        "Oron",
        "Udung-Uko",
        "Ukanafun",
        "Oruk Anam",
        "Uruan",
        "Urue-Offong/Oruko",
        "Uyo"
      ]
    },
    {
      "state": "Anambra",
      "alias": "anambra",
      "lgas": [
        "Aguata",
        "Anambra East",
        "Anaocha",
        "Awka North",
        "Anambra West",
        "Awka South",
        "Ayamelum",
        "Dunukofia",
        "Ekwusigo",
        "Idemili North",
        "Idemili South",
        "Ihiala",
        "Njikoka",
        "Nnewi North",
        "Nnewi South",
        "Ogbaru",
        "Onitsha North",
        "Onitsha South",
        "Orumba North",
        "Orumba South",
        "Oyi"
      ]
    },
    {
      "state": "Ogun",
      "alias": "ogun",
      "lgas": [
        "Abeokuta North",
        "Abeokuta South",
        "Ado-Odo/Ota",
        "Egbado North",
        "Ewekoro",
        "Egbado South",
        "Ijebu North",
        "Ijebu East",
        "Ifo",
        "Ijebu Ode",
        "Ijebu North East",
        "Imeko Afon",
        "Ikenne",
        "Ipokia",
        "Odeda",
        "Obafemi Owode",
        "Odogbolu",
        "Remo North",
        "Ogun Waterside",
        "Shagamu"
      ]
    },
    {
      "state": "Ondo",
      "alias": "ondo",
      "lgas": [
        "Akoko North-East",
        "Akoko North-West",
        "Akoko South-West",
        "Akoko South-East",
        "Akure North",
        "Akure South",
        "Ese Odo",
        "Idanre",
        "Ifedore",
        "Ilaje",
        "Irele",
        "Ile Oluji/Okeigbo",
        "Odigbo",
        "Okitipupa",
        "Ondo West",
        "Ose",
        "Ondo East",
        "Owo"
      ]
    },
    {
      "state": "Rivers",
      "alias": "rivers",
      "lgas": [
        "Abua/Odual",
        "Ahoada East",
        "Ahoada West",
        "Andoni",
        "Akuku-Toru",
        "Asari-Toru",
        "Bonny",
        "Degema",
        "Emuoha",
        "Eleme",
        "Ikwerre",
        "Etche",
        "Gokana",
        "Khana",
        "Obio/Akpor",
        "Ogba/Egbema/Ndoni",
        "Ogu/Bolo",
        "Okrika",
        "Omuma",
        "Opobo/Nkoro",
        "Oyigbo",
        "Port Harcourt",
        "Tai"
      ]
    },
    {
      "state": "Bauchi",
      "alias": "bauchi",
      "lgas": [
        "Alkaleri",
        "Bauchi",
        "Bogoro",
        "Damban",
        "Darazo",
        "Dass",
        "Gamawa",
        "Ganjuwa",
        "Giade",
        "Itas/Gadau",
        "Jama'are",
        "Katagum",
        "Kirfi",
        "Misau",
        "Ningi",
        "Shira",
        "Tafawa Balewa",
        "Toro",
        "Warji",
        "Zaki"
      ]
    },
    {
      "state": "Benue",
      "alias": "benue",
      "lgas": [
        "Agatu",
        "Apa",
        "Ado",
        "Buruku",
        "Gboko",
        "Guma",
        "Gwer East",
        "Gwer West",
        "Katsina-Ala",
        "Konshisha",
        "Kwande",
        "Logo",
        "Makurdi",
        "Obi",
        "Ogbadibo",
        "Ohimini",
        "Oju",
        "Okpokwu",
        "Oturkpo",
        "Tarka",
        "Ukum",
        "Ushongo",
        "Vandeikya"
      ]
    },
    {
      "state": "Borno",
      "alias": "borno",
      "lgas": [
        "Abadam",
        "Askira/Uba",
        "Bama",
        "Bayo",
        "Biu",
        "Chibok",
        "Damboa",
        "Dikwa",
        "Guzamala",
        "Gubio",
        "Hawul",
        "Gwoza",
        "Jere",
        "Kaga",
        "Kala/Balge",
        "Konduga",
        "Kukawa",
        "Kwaya Kusar",
        "Mafa",
        "Magumeri",
        "Maiduguri",
        "Mobbar",
        "Marte",
        "Monguno",
        "Ngala",
        "Nganzai",
        "Shani"
      ]
    },
    {
      "state": "Bayelsa",
      "alias": "bayelsa",
      "lgas": [
        "Brass",
        "Ekeremor",
        "Kolokuma/Opokuma",
        "Nembe",
        "Ogbia",
        "Sagbama",
        "Southern Ijaw",
        "Yenagoa"
      ]
    },
    {
      "state": "Cross River",
      "alias": "cross_river",
      "lgas": [
        "Abi",
        "Akamkpa",
        "Akpabuyo",
        "Bakassi",
        "Bekwarra",
        "Biase",
        "Boki",
        "Calabar Municipal",
        "Calabar South",
        "Etung",
        "Ikom",
        "Obanliku",
        "Obubra",
        "Obudu",
        "Odukpani",
        "Ogoja",
        "Yakuur",
        "Yala"
      ]
    },
    {
      "state": "Delta",
      "alias": "delta",
      "lgas": [
        "Aniocha North",
        "Aniocha South",
        "Bomadi",
        "Burutu",
        "Ethiope West",
        "Ethiope East",
        "Ika North East",
        "Ika South",
        "Isoko North",
        "Isoko South",
        "Ndokwa East",
        "Ndokwa West",
        "Okpe",
        "Oshimili North",
        "Oshimili South",
        "Patani",
        "Sapele",
        "Udu",
        "Ughelli North",
        "Ukwuani",
        "Ughelli South",
        "Uvwie",
        "Warri North",
        "Warri South",
        "Warri South West"
      ]
    },
    {
      "state": "Ebonyi",
      "alias": "ebonyi",
      "lgas": [
        "Abakaliki",
        "Afikpo North",
        "Ebonyi",
        "Afikpo South",
        "Ezza North",
        "Ikwo",
        "Ezza South",
        "Ivo",
        "Ishielu",
        "Izzi",
        "Ohaozara",
        "Ohaukwu",
        "Onicha"
      ]
    },
    {
      "state": "Edo",
      "alias": "edo",
      "lgas": [
        "Akoko-Edo",
        "Egor",
        "Esan Central",
        "Esan North-East",
        "Esan South-East",
        "Esan West",
        "Etsako Central",
        "Etsako East",
        "Etsako West",
        "Igueben",
        "Ikpoba Okha",
        "Orhionmwon",
        "Oredo",
        "Ovia North-East",
        "Ovia South-West",
        "Owan East",
        "Owan West",
        "Uhunmwonde"
      ]
    },
    {
      "state": "Ekiti",
      "alias": "ekiti",
      "lgas": [
        "Ado Ekiti",
        "Efon",
        "Ekiti East",
        "Ekiti South-West",
        "Ekiti West",
        "Emure",
        "Gbonyin",
        "Ido Osi",
        "Ijero",
        "Ikere",
        "Ilejemeje",
        "Irepodun/Ifelodun",
        "Ikole",
        "Ise/Orun",
        "Moba",
        "Oye"
      ]
    },
    {
      "state": "Enugu",
      "alias": "enugu",
      "lgas": [
        "Awgu",
        "Aninri",
        "Enugu East",
        "Enugu North",
        "Ezeagu",
        "Enugu South",
        "Igbo Etiti",
        "Igbo Eze North",
        "Igbo Eze South",
        "Isi Uzo",
        "Nkanu East",
        "Nkanu West",
        "Nsukka",
        "Udenu",
        "Oji River",
        "Uzo Uwani",
        "Udi"
      ]
    },
    {
      "state": "Federal Capital Territory",
      "alias": "abuja",
      "lgas": [
        "Abaji",
        "Bwari",
        "Gwagwalada",
        "Kuje",
        "Kwali",
        "Municipal Area Council"
      ]
    },
    {
      "state": "Gombe",
      "alias": "gombe",
      "lgas": [
        "Akko",
        "Balanga",
        "Billiri",
        "Dukku",
        "Funakaye",
        "Gombe",
        "Kaltungo",
        "Kwami",
        "Nafada",
        "Shongom",
        "Yamaltu/Deba"
      ]
    },
    {
      "state": "Jigawa",
      "alias": "jigawa",
      "lgas": [
        "Auyo",
        "Babura",
        "Buji",
        "Biriniwa",
        "Birnin Kudu",
        "Dutse",
        "Gagarawa",
        "Garki",
        "Gumel",
        "Guri",
        "Gwaram",
        "Gwiwa",
        "Hadejia",
        "Jahun",
        "Kafin Hausa",
        "Kazaure",
        "Kiri Kasama",
        "Kiyawa",
        "Kaugama",
        "Maigatari",
        "Malam Madori",
        "Miga",
        "Sule Tankarkar",
        "Roni",
        "Ringim",
        "Yankwashi",
        "Taura"
      ]
    },
    {
      "state": "Oyo",
      "alias": "oyo",
      "lgas": [
        "Afijio",
        "Akinyele",
        "Atiba",
        "Atisbo",
        "Egbeda",
        "Ibadan North",
        "Ibadan North-East",
        "Ibadan North-West",
        "Ibadan South-East",
        "Ibarapa Central",
        "Ibadan South-West",
        "Ibarapa East",
        "Ido",
        "Ibarapa North",
        "Irepo",
        "Iseyin",
        "Itesiwaju",
        "Iwajowa",
        "Kajola",
        "Lagelu",
        "Ogbomosho North",
        "Ogbomosho South",
        "Ogo Oluwa",
        "Olorunsogo",
        "Oluyole",
        "Ona Ara",
        "Orelope",
        "Ori Ire",
        "Oyo",
        "Oyo East",
        "Saki East",
        "Saki West",
        "Surulere Oyo State"
      ]
    },
    {
      "state": "Imo",
      "alias": "imo",
      "lgas": [
        "Aboh Mbaise",
        "Ahiazu Mbaise",
        "Ehime Mbano",
        "Ezinihitte",
        "Ideato North",
        "Ideato South",
        "Ihitte/Uboma",
        "Ikeduru",
        "Isiala Mbano",
        "Mbaitoli",
        "Isu",
        "Ngor Okpala",
        "Njaba",
        "Nkwerre",
        "Nwangele",
        "Obowo",
        "Oguta",
        "Ohaji/Egbema",
        "Okigwe",
        "Orlu",
        "Orsu",
        "Oru East",
        "Oru West",
        "Owerri Municipal",
        "Owerri North",
        "Unuimo",
        "Owerri West"
      ]
    },
    {
      "state": "Kaduna",
      "alias": "kaduna",
      "lgas": [
        "Birnin Gwari",
        "Chikun",
        "Giwa",
        "Ikara",
        "Igabi",
        "Jaba",
        "Jema'a",
        "Kachia",
        "Kaduna North",
        "Kaduna South",
        "Kagarko",
        "Kajuru",
        "Kaura",
        "Kauru",
        "Kubau",
        "Kudan",
        "Lere",
        "Makarfi",
        "Sabon Gari",
        "Sanga",
        "Soba",
        "Zangon Kataf",
        "Zaria"
      ]
    },
    {
      "state": "Kebbi",
      "alias": "kebbi",
      "lgas": [
        "Aleiro",
        "Argungu",
        "Arewa Dandi",
        "Augie",
        "Bagudo",
        "Birnin Kebbi",
        "Bunza",
        "Dandi",
        "Fakai",
        "Gwandu",
        "Jega",
        "Kalgo",
        "Koko/Besse",
        "Maiyama",
        "Ngaski",
        "Shanga",
        "Suru",
        "Sakaba",
        "Wasagu/Danko",
        "Yauri",
        "Zuru"
      ]
    },
    {
      "state": "Kano",
      "alias": "kano",
      "lgas": [
        "Ajingi",
        "Albasu",
        "Bagwai",
        "Bebeji",
        "Bichi",
        "Bunkure",
        "Dala",
        "Dambatta",
        "Dawakin Kudu",
        "Dawakin Tofa",
        "Doguwa",
        "Fagge",
        "Gabasawa",
        "Garko",
        "Garun Mallam",
        "Gezawa",
        "Gaya",
        "Gwale",
        "Gwarzo",
        "Kabo",
        "Kano Municipal",
        "Karaye",
        "Kibiya",
        "Kiru",
        "Kumbotso",
        "Kunchi",
        "Kura",
        "Madobi",
        "Makoda",
        "Minjibir",
        "Nasarawa",
        "Rano",
        "Rimin Gado",
        "Rogo",
        "Shanono",
        "Takai",
        "Sumaila",
        "Tarauni",
        "Tofa",
        "Tsanyawa",
        "Tudun Wada",
        "Ungogo",
        "Warawa",
        "Wudil"
      ]
    },
    {
      "state": "Kogi",
      "alias": "kogi",
      "lgas": [
        "Ajaokuta",
        "Adavi",
        "Ankpa",
        "Bassa",
        "Dekina",
        "Ibaji",
        "Idah",
        "Igalamela Odolu",
        "Ijumu",
        "Kogi",
        "Kabba/Bunu",
        "Lokoja",
        "Ofu",
        "Mopa Muro",
        "Ogori/Magongo",
        "Okehi",
        "Okene",
        "Olamaboro",
        "Omala",
        "Yagba East",
        "Yagba West"
      ]
    },
    {
      "state": "Osun",
      "alias": "osun",
      "lgas": [
        "Aiyedire",
        "Atakunmosa West",
        "Atakunmosa East",
        "Aiyedaade",
        "Boluwaduro",
        "Boripe",
        "Ife East",
        "Ede South",
        "Ife North",
        "Ede North",
        "Ife South",
        "Ejigbo",
        "Ife Central",
        "Ifedayo",
        "Egbedore",
        "Ila",
        "Ifelodun",
        "Ilesa East",
        "Ilesa West",
        "Irepodun",
        "Irewole",
        "Isokan",
        "Iwo",
        "Obokun",
        "Odo Otin",
        "Ola Oluwa",
        "Olorunda",
        "Oriade",
        "Orolu",
        "Osogbo"
      ]
    },
    {
      "state": "Sokoto",
      "alias": "sokoto",
      "lgas": [
        "Gudu",
        "Gwadabawa",
        "Illela",
        "Isa",
        "Kebbe",
        "Kware",
        "Rabah",
        "Sabon Birni",
        "Shagari",
        "Silame",
        "Sokoto North",
        "Sokoto South",
        "Tambuwal",
        "Tangaza",
        "Tureta",
        "Wamako",
        "Wurno",
        "Yabo",
        "Binji",
        "Bodinga",
        "Dange Shuni",
        "Goronyo",
        "Gada"
      ]
    },
    {
      "state": "Plateau",
      "alias": "plateau",
      "lgas": [
        "Bokkos",
        "Barkin Ladi",
        "Bassa",
        "Jos East",
        "Jos North",
        "Jos South",
        "Kanam",
        "Kanke",
        "Langtang South",
        "Langtang North",
        "Mangu",
        "Mikang",
        "Pankshin",
        "Qua'an Pan",
        "Riyom",
        "Shendam",
        "Wase"
      ]
    },
    {
      "state": "Taraba",
      "alias": "taraba",
      "lgas": [
        "Ardo Kola",
        "Bali",
        "Donga",
        "Gashaka",
        "Gassol",
        "Ibi",
        "Jalingo",
        "Karim Lamido",
        "Kumi",
        "Lau",
        "Sardauna",
        "Takum",
        "Ussa",
        "Wukari",
        "Yorro",
        "Zing"
      ]
    },
    {
      "state": "Yobe",
      "alias": "yobe",
      "lgas": [
        "Bade",
        "Bursari",
        "Damaturu",
        "Fika",
        "Fune",
        "Geidam",
        "Gujba",
        "Gulani",
        "Jakusko",
        "Karasuwa",
        "Machina",
        "Nangere",
        "Nguru",
        "Potiskum",
        "Tarmuwa",
        "Yunusari"
      ]
    },
    {
      "state": "Zamfara",
      "alias": "zamfara",
      "lgas": [
        "Anka",
        "Birnin Magaji/Kiyaw",
        "Bakura",
        "Bukkuyum",
        "Bungudu",
        "Gummi",
        "Gusau",
        "Kaura Namoda",
        "Maradun",
        "Shinkafi",
        "Maru",
        "Talata Mafara",
        "Tsafe",
        "Zurmi"
      ]
    },
    {
      "state": "Lagos",
      "alias": "lagos",
      "lgas": [
        "Agege",
        "Ajeromi-Ifelodun",
        "Alimosho",
        "Amuwo-Odofin",
        "Badagry",
        "Apapa",
        "Epe",
        "Eti Osa",
        "Ibeju-Lekki",
        "Ifako-Ijaiye",
        "Ikeja",
        "Ikorodu",
        "Kosofe",
        "Lagos Island",
        "Mushin",
        "Lagos Mainland",
        "Ojo",
        "Oshodi-Isolo",
        "Shomolu",
        "Surulere Lagos State"
      ]
    },
    {
      "state": "Katsina",
      "alias": "katsina",
      "lgas": [
        "Bakori",
        "Batagarawa",
        "Batsari",
        "Baure",
        "Bindawa",
        "Charanchi",
        "Danja",
        "Dandume",
        "Dan Musa",
        "Daura",
        "Dutsi",
        "Dutsin Ma",
        "Faskari",
        "Funtua",
        "Ingawa",
        "Jibia",
        "Kafur",
        "Kaita",
        "Kankara",
        "Kankia",
        "Katsina",
        "Kurfi",
        "Kusada",
        "Mai'Adua",
        "Malumfashi",
        "Mani",
        "Mashi",
        "Matazu",
        "Musawa",
        "Rimi",
        "Sabuwa",
        "Safana",
        "Sandamu",
        "Zango"
      ]
    },
    {
      "state": "Kwara",
      "alias": "kwara",
      "lgas": [
        "Asa",
        "Baruten",
        "Edu",
        "Ilorin East",
        "Ifelodun",
        "Ilorin South",
        "Ekiti Kwara State",
        "Ilorin West",
        "Irepodun",
        "Isin",
        "Kaiama",
        "Moro",
        "Offa",
        "Oke Ero",
        "Oyun",
        "Pategi"
      ]
    },
    {
      "state": "Nasarawa",
      "alias": "nasarawa",
      "lgas": [
        "Akwanga",
        "Awe",
        "Doma",
        "Karu",
        "Keana",
        "Keffi",
        "Lafia",
        "Kokona",
        "Nasarawa Egon",
        "Nasarawa",
        "Obi",
        "Toto",
        "Wamba"
      ]
    },
    {
      "state": "Niger",
      "alias": "niger",
      "lgas": [
        "Agaie",
        "Agwara",
        "Bida",
        "Borgu",
        "Bosso",
        "Chanchaga",
        "Edati",
        "Gbako",
        "Gurara",
        "Katcha",
        "Kontagora",
        "Lapai",
        "Lavun",
        "Mariga",
        "Magama",
        "Mokwa",
        "Mashegu",
        "Moya",
        "Paikoro",
        "Rafi",
        "Rijau",
        "Shiroro",
        "Suleja",
        "Tafa",
        "Wushishi"
      ]
    },
    {
      "state": "Abia",
      "alias": "abia",
      "lgas": [
        "Aba North",
        "Arochukwu",
        "Aba South",
        "Bende",
        "Isiala Ngwa North",
        "Ikwuano",
        "Isiala Ngwa South",
        "Isuikwuato",
        "Obi Ngwa",
        "Ohafia",
        "Osisioma",
        "Ugwunagbo",
        "Ukwa East",
        "Ukwa West",
        "Umuahia North",
        "Umuahia South",
        "Umu Nneochi"
      ]
    }
  ];
}

class StateModel {
  String state = '';
  String alias = '';
  List<String> lgas = [];

  StateModel({required this.state, required this.alias, required this.lgas});

  StateModel.fromJson(Map<String, dynamic> json) {
    state = json['state']!;
    alias = json['alias']!;
    lgas = json['lgas']!.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['alias'] = alias;
    data['lgas'] = lgas;
    return data;
  }
}