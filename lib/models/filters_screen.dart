// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:html';

import 'package:flutter/material.dart';
// import 'range_slider_view.dart';
// import 'slider_view.dart';
import '../fitness_app_theme.dart';
import 'calendar_popup_view.dart';
import 'popular_filter_list.dart';
import '../models/meals_list_data.dart';
import 'package:intl/intl.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<PopularFilterListData> popularFilterListData =
      PopularFilterListData.popularFList;
  List<PopularFilterListData> accomodationListData =
      PopularFilterListData.accomodationList;
  List<MealsListData> mealsListData = MealsListData.tabIconsList;

  // RangeValues _values = const RangeValues(100, 600);
  double distValue = 50.0;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 6));
  String chosenStation = '';
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }

  void showStationDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('Select Station'),
        children: <Widget>[
          ...mealsListData.map((e) => SimpleDialogOption(
                onPressed: () {
                  chosenStation = e.titleTxt;
                  Navigator.of(context).pop();
                },
                child: Text(e.titleTxt),
              ))
          // SimpleDialogOption(
          //   onPressed: () {},
          //   child: Text('${mealsListData.length}'),
          // ),
          // SimpleDialogOption(
          //   onPressed: () {},
          //   child: Text('${mealsListData.length}'),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              // setState(() {
                              //   isDatePopupOpen = true;
                              // });
                              showDemoDialog(context: context);
                            },
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 360
                                          ? 18
                                          : 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Text(
                            '${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width > 360
                                        ? 18
                                        : 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        // initialValue: _initValues['title'],
                        decoration: InputDecoration(
                          focusColor: FitnessAppTheme.primaryColor,
                          labelText: 'Name',
                          border: const OutlineInputBorder(),
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width > 360
                                  ? 18
                                  : 16,
                              fontWeight: FontWeight.normal),
                        ),
                        textInputAction: TextInputAction.next,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context).requestFocus(_priceFocusNode);
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please provide a value.';
                        //   }
                        //   return null;
                        // },
                        // onSaved: (value) {
                        //   _editedProduct = Product(
                        //     title: value,
                        //     price: _editedProduct.price,
                        //     description: _editedProduct.description,
                        //     imageUrl: _editedProduct.imageUrl,
                        //     id: _editedProduct.id,
                        //     isFavorite: _editedProduct.isFavorite,
                        //   );
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              // setState(() {
                              //   isDatePopupOpen = true;
                              // });
                              showStationDialog(context: context);
                            },
                            child: Text(
                              'Choose Station',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 360
                                          ? 18
                                          : 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Text(
                            chosenStation,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width > 360
                                        ? 18
                                        : 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          focusColor: FitnessAppTheme.primaryColor,
                          labelText: 'Shift',
                          border: const OutlineInputBorder(),
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width > 360
                                  ? 18
                                  : 16,
                              fontWeight: FontWeight.normal),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: FitnessAppTheme.primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: FitnessAppTheme.backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Add New Patient',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
