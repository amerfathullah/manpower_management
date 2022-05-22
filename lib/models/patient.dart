import 'package:flutter/cupertino.dart';

enum Shift {
  A,
  B,
  C,
  D,
}

class Patient with ChangeNotifier {
  String id;
  String name;
  Shift? shift;
  DateTime startDate;
  DateTime endDate;
  String station;

  Patient({
    required this.id,
    required this.name,
    required this.shift,
    required this.startDate,
    required this.endDate,
    required this.station,
  });

  static List<Patient> patients = [
    // Patient(
    //   id: '0',
    //   name: 'Amer Fathullah',
    //   shift: Shift.A,
    //   startDate: DateTime.now(),
    //   endDate: DateTime.now().add(const Duration(days: 6)),
    //   station: 'Main Station',
    // ),
    // Patient(
    //   id: '1',
    //   name: 'Fazli Jamaluddin',
    //   shift: Shift.B,
    //   startDate: DateTime.now().add(const Duration(days: 1)),
    //   endDate: DateTime.now().add(const Duration(days: 7)),
    //   station: 'Station A',
    // ),
    // Patient(
    //   id: '2',
    //   name: 'Abdullah Hadi',
    //   shift: Shift.C,
    //   startDate: DateTime.now().add(const Duration(days: 2)),
    //   endDate: DateTime.now().add(const Duration(days: 8)),
    //   station: 'Main Station',
    // ),
  ];

  // Future<void> addPatient(Patient patient) async {
  //   final url = Uri.parse(
  //       'https://manpower-management-427bf-default-rtdb.asia-southeast1.firebasedatabase.app/patients.json');
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode(
  //         {
  //           'name': patient.name,
  //           'shift': patient.shift,
  //           'station': patient.station,
  //           'startDate': patient.startDate.toIso8601String(),
  //           'endDate': patient.endDate.toIso8601String(),
  //         },
  //       ),
  //     );
  //     final newPatient = Patient(
  //       id: json.decode(response.body)['name'],
  //       name: patient.name,
  //       shift: patient.shift,
  //       station: patient.station,
  //       startDate: patient.startDate,
  //       endDate: patient.endDate,
  //     );
  //     patients.add(newPatient);
  //     // _items.insert(0, newChecklist); // at the start of the list
  //     notifyListeners();
  //   } catch (error) {
  //     // ignore: avoid_print
  //     print(error);
  //     rethrow;
  //   }
  // }

  // Future<void> fetchAndSetPatients() async {
  //   final url = Uri.parse(
  //       'https://manpower-management-427bf-default-rtdb.asia-southeast1.firebasedatabase.app/patientss.json');
  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     // ignore: unnecessary_null_comparison
  //     if (extractedData == null) {
  //       return;
  //     }
  //     // final favoriteResponse = await http.get(Uri.parse(
  //     //     'https://cefs-5580c-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken'));
  //     // final favoriteData = json.decode(favoriteResponse.body);
  //     Shift? loadedShift;
  //     final List<Patient> loadedPatients = [];
  //     extractedData.forEach((prodId, prodData) {
  //       if (prodData['shift'] == 'Shift.A') {
  //         loadedShift = Shift.A;
  //       } else if (prodData['shift'] == 'Shift.B') {
  //         loadedShift = Shift.B;
  //       } else if (prodData['shift'] == 'Shift.C') {
  //         loadedShift = Shift.C;
  //       } else if (prodData['shift'] == 'Shift.D') {
  //         loadedShift = Shift.D;
  //       } else {
  //         loadedShift = null;
  //       }
  //       loadedPatients.add(
  //         Patient(
  //           id: prodId,
  //           name: prodData['name'],
  //           shift: loadedShift,
  //           station: prodData['name'],
  //           startDate: prodData['name'],
  //           endDate: prodData['name'],
  //         ),
  //       );
  //     });
  //     patients = loadedPatients;
  //     notifyListeners();
  //   } catch (error) {
  //     rethrow;
  //   }
  // }
}
