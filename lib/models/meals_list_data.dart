class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    // this.meals,
    this.total = 0,
    this.patients = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  // List<String>? meals;
  int total;
  int patients;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/cefs.png',
      titleTxt: 'Main Station',
      total: 64,
      patients: 1,
      // meals: <String>['Bread,', 'Peanut butter,', 'Apple'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/cefs.png',
      titleTxt: 'Station A',
      total: 43,
      patients: 2,
      // meals: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/cefs.png',
      titleTxt: 'Station B',
      total: 37,
      patients: 3,
      // meals: <String>['Recommend:', '800 kcal'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/cefs.png',
      titleTxt: 'FTG',
      total: 6,
      patients: 4,
      // meals: <String>['Recommend:', '703 kcal'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
