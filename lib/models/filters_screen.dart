import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../management_app_home_screen.dart';
import '../management_app_theme.dart';
import './calendar_popup_view.dart';
import './patient.dart';
import './station.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final _form = GlobalKey<FormState>();
  List<Station> stationData = Station.station;

  double distValue = 50.0;
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  var _editedPatient = Patient(
    id: '',
    name: '',
    shift: Shift.A,
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 6)),
    station: '',
  );

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        initialEndDate: _editedPatient.endDate,
        initialStartDate: _editedPatient.startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            _editedPatient.startDate = startData;
            _editedPatient.endDate = endData;
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
          ...stationData.map((e) => SimpleDialogOption(
                onPressed: () {
                  _editedPatient.station = e.id;
                  Navigator.of(context).pop();
                },
                child: Text(e.id),
              ))
        ],
      ),
    );
  }

  void showShiftDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('Select Shift'),
        children: <Widget>[
          Row(
            children: [
              Radio<Shift>(
                value: Shift.A,
                groupValue: _editedPatient.shift,
                onChanged: (Shift? value) {
                  setState(() {
                    _editedPatient.shift = value!;
                  });
                },
              ),
              const Text('A'),
            ],
          ),
          Row(
            children: [
              Radio<Shift>(
                value: Shift.B,
                groupValue: _editedPatient.shift,
                onChanged: (Shift? value) {
                  setState(() {
                    _editedPatient.shift = value!;
                  });
                },
              ),
              const Text('B'),
            ],
          ),
          Row(
            children: [
              Radio<Shift>(
                value: Shift.C,
                groupValue: _editedPatient.shift,
                onChanged: (Shift? value) {
                  setState(() {
                    _editedPatient.shift = value!;
                  });
                },
              ),
              const Text('C'),
            ],
          ),
          Row(
            children: [
              Radio<Shift>(
                value: Shift.D,
                groupValue: _editedPatient.shift,
                onChanged: (Shift? value) {
                  setState(() {
                    _editedPatient.shift = value!;
                  });
                },
              ),
              const Text('D'),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    setState(() {});
    // ignore: avoid_print
    print('saveform id: ' + _editedPatient.id);
    try {
      _form.currentState?.save();
      setState(() {});
      await submitPatient(_editedPatient);
      setState(() {});
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const ManagementAppHomeScreen(),
        ),
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<void> submitPatient(Patient patient) async {
    try {
      final newPatient = Patient(
          id: patient.id,
          name: patient.name,
          shift: patient.shift,
          startDate: patient.startDate,
          endDate: patient.endDate,
          station: patient.station);
      Patient.patients.add(newPatient);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagementAppTheme.backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Form(
              key: _form,
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
                            '${dateFormat.format(_editedPatient.startDate)} - ${dateFormat.format(_editedPatient.endDate)}',
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
                          focusColor: ManagementAppTheme.primaryColor,
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
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedPatient = Patient(
                              id: '${Patient.patients.length}',
                              name: value!,
                              shift: _editedPatient.shift,
                              startDate: _editedPatient.startDate,
                              endDate: _editedPatient.endDate,
                              station: _editedPatient.station);
                        },
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
                            _editedPatient.station,
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
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Choose Shift:',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width > 360
                                        ? 18
                                        : 16,
                                fontWeight: FontWeight.normal),
                          ),
                          Radio<Shift>(
                            value: Shift.A,
                            groupValue: _editedPatient.shift,
                            onChanged: (Shift? value) {
                              setState(() {
                                _editedPatient.shift = value!;
                              });
                            },
                          ),
                          const Text('A'),
                          Radio<Shift>(
                            value: Shift.B,
                            groupValue: _editedPatient.shift,
                            onChanged: (Shift? value) {
                              setState(() {
                                _editedPatient.shift = value!;
                              });
                            },
                          ),
                          const Text('B'),
                          Radio<Shift>(
                            value: Shift.C,
                            groupValue: _editedPatient.shift,
                            onChanged: (Shift? value) {
                              setState(() {
                                _editedPatient.shift = value!;
                              });
                            },
                          ),
                          const Text('C'),
                          Radio<Shift>(
                            value: Shift.D,
                            groupValue: _editedPatient.shift,
                            onChanged: (Shift? value) {
                              setState(() {
                                _editedPatient.shift = value!;
                              });
                            },
                          ),
                          const Text('D'),
                        ],
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
                  color: ManagementAppTheme.primaryColor,
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
                      if (_form.currentState!.validate()) {
                        _saveForm();
                      }
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
        color: ManagementAppTheme.backgroundColor,
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
