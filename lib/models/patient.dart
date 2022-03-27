enum Shift {
  A,
  B,
  C,
  D,
}

class Patient {
  String id;
  String name;
  Shift shift;
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
    Patient(
      id: '1',
      name: 'Amer Fathullah',
      shift: Shift.A,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 6)),
      station: 'Main Station',
    ),
    Patient(
      id: '2',
      name: 'Fazli Jamaluddin',
      shift: Shift.B,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 6)),
      station: 'Station A',
    ),
    Patient(
      id: '3',
      name: 'Abdullah Hadi',
      shift: Shift.C,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 6)),
      station: 'Main Station',
    ),
  ];

  List<Patient> get patient {
    return [...patients];
  }
}
