import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../data/app_data.dart';
import 'KeyvalueModel.dart';

class DropDown{
  static KeyvalueModel? selectedKey;
  static KeyvalueModel? selectedKey1;
  static staticDropdown(
      String label, String callFrom, List<KeyvalueModel> list, Function fun) {
    return (DropdownSearch<KeyvalueModel>(
      popupProps: PopupProps.modalBottomSheet(
        showSelectedItems: false,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(decoration: InputDecoration(
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(8.0),
          //   //borderSide: BorderSide(color: Colors.blueGrey,width: 1.0),
          //
          //   //gapPadding: 20.0,
          //
          // ),

          //     labelStyle: TextStyle(
          //   color: Colors.blueGrey,
          // ),

          fillColor: Colors.grey,
          hintText: 'Search Here',
          hintStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.all(5.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey,width: 1.0),),
        ),
        ),

      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        //dropdownSearchDecoration: InputDecoration(border: InputBorder.underline),
          dropdownSearchDecoration: InputDecoration(hintText: label,
            hintStyle: TextStyle(color: Colors.black,fontSize: 12),
            contentPadding: EdgeInsets.only(left: 0),
            border: UnderlineInputBorder(
                borderSide:BorderSide(color: Colors.grey)
            ),
            /* border:OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 3.0),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(3.0),
                    bottomRight: Radius.circular(3.0),
                    topRight: Radius.circular(3.0),
                    topLeft: Radius.circular(3.0)),
              ),*/
          ),
          textAlignVertical:TextAlignVertical.center
      ),

      //items: maritalStatus,
      selectedItem: getData(callFrom),
      items: list,

      onChanged: (KeyvalueModel? data) {
        fun(data);
        switch (callFrom) {
          case "district":
            selectedKey = data;
            break;
        }
        //selectbank = data;
      },
    ));
  }

  static KeyvalueModel? getData(String callFor) {
    switch (callFor) {
      case "block":
        return selectedKey1;
        break;
 /*     case "expenseHead":
        return ManageExpense.expenseHead;*/
        break;

    // vencounrty,venstate,venstate
    }
  }


  static networkDropdownGetpart(
      String label, final String API, String callFrom, Function fun,IconData icons) {
    WidgetsFlutterBinding.ensureInitialized();

    return DropdownSearch<KeyvalueModel>(
      popupProps: PopupProps.modalBottomSheet(
        showSelectedItems: false,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(decoration: InputDecoration(
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(8.0),
          //   //borderSide: BorderSide(color: Colors.blueGrey,width: 1.0),
          //
          //   //gapPadding: 20.0,
          //
          // ),

          //     labelStyle: TextStyle(
          //   color: Colors.blueGrey,
          // ),

          fillColor: Colors.grey,
          hintText: 'Search Here',
          hintStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.all(5.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey,width: 1.0),),
        ),
        ),


      ),

      dropdownDecoratorProps: DropDownDecoratorProps(
        //dropdownSearchDecoration: InputDecoration(border: InputBorder.underline),
          dropdownSearchDecoration: InputDecoration(
            hintText: label,
           fillColor: Colors.white,
           filled: true,
           /* hintStyle: TextStyle(color: Colors.black,fontSize: 12),*/
              contentPadding: EdgeInsets.only(left: 0, top: 15, right: 4, bottom: 0),

            border:OutlineInputBorder(
              borderSide:
              BorderSide(width: 0, color: Colors.white), //<-- SEE HERE
              borderRadius: BorderRadius.circular(50.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(width: 0, color: Colors.white), //<-- SEE HERE
              borderRadius: BorderRadius.circular(50.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(width: 0, color: Colors.white), //<-- SEE HERE
              borderRadius: BorderRadius.circular(50.0),
            ) ,
            prefixIcon: Icon(icons, color: Colors.black),
            hintStyle: TextStyle(
              color: AppData.hinttextcolor, // <-- Change this
              fontSize: AppData.hinttextSize,
              // fontWeight: FontWeight.w400,
              // fontStyle: FontStyle.normal,
            ),
            // labelText: hint,
            labelStyle: TextStyle(
              color: AppData.lebletextcolor, // <-- Change this
              fontSize: AppData.lebletextSize,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),


          ),
          textAlignVertical:TextAlignVertical.center,
      ),

      selectedItem: getData(callFrom),


      asyncItems: (String filter) async {
        var response = await Dio().get(
          API,
        );
        var list;
        switch (callFrom) {
          case "city":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "skill":
            list = KeyvalueModel.fromJsonList(response.data["skill_arr"]);
            break;
          case "class":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
        }

        // serveType,itemSubCategory,itemCategory

        return list;
      },
      onChanged: (KeyvalueModel? data) {
        fun(data);
      },
    );
  }

  static networkDropdownGetpartStu(
      String label, final String API, String callFrom, Function fun,IconData icons) {
    WidgetsFlutterBinding.ensureInitialized();

    return DropdownSearch<KeyvalueModel>(
      popupProps: PopupProps.modalBottomSheet(
        showSelectedItems: false,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(decoration: InputDecoration(
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(8.0),
          //   //borderSide: BorderSide(color: Colors.blueGrey,width: 1.0),
          //
          //   //gapPadding: 20.0,
          //
          // ),

          //     labelStyle: TextStyle(
          //   color: Colors.blueGrey,
          // ),

          fillColor: Colors.grey,
          hintText: 'Search Here',
          hintStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.only(left: 0, top: 4, right: 4),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey,width: 1.0),),
        ),
        ),


      ),

      dropdownDecoratorProps: DropDownDecoratorProps(
        //dropdownSearchDecoration: InputDecoration(border: InputBorder.underline),
        dropdownSearchDecoration: InputDecoration(
          hintText: label,
       /*   fillColor: Colors.white,
          filled: true,*/
          /* hintStyle: TextStyle(color: Colors.black,fontSize: 12),*/
          contentPadding: EdgeInsets.only(left: 0, top: 15, right: 4, bottom: 0),

          border:UnderlineInputBorder(
            borderSide:
            BorderSide(width: 0, color: Colors.black), //<-- SEE HERE
            borderRadius: BorderRadius.circular(1.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(width: 0, color: Colors.black), //<-- SEE HERE
            borderRadius: BorderRadius.circular(1.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(width: 0, color: Colors.black), //<-- SEE HERE
            borderRadius: BorderRadius.circular(1.0),
          ) ,
          // prefixIcon: Icon(icons, color: Colors.black),
          hintStyle: TextStyle(
            color: AppData.hinttextcolor, // <-- Change this
            fontSize: AppData.hinttextSize,
            // fontWeight: FontWeight.w400,
            // fontStyle: FontStyle.normal,
          ),
          // labelText: hint,
          labelStyle: TextStyle(
            color: AppData.lebletextcolor, // <-- Change this
            fontSize: AppData.lebletextSize,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),


        ),
        textAlignVertical:TextAlignVertical.center,
      ),

      selectedItem: getData(callFrom),


      asyncItems: (String filter) async {
        var response = await Dio().get(
          API,
        );
        var list;
        switch (callFrom) {
          case "city":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "skill":
            list = KeyvalueModel.fromJsonList(response.data["skill_arr"]);
            break;
          case "class":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "classStu":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
        }

        // serveType,itemSubCategory,itemCategory

        return list;
      },
      onChanged: (KeyvalueModel? data) {
        fun(data);
      },
    );
  }




}