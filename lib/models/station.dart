class Station {
  Station({
    this.id = '',
    this.total = 0,
    this.imagePath = '',
    this.startColor = '',
    this.endColor = '',
  });

  String id;
  int total;
  String imagePath;
  String startColor;
  String endColor;

  static List<Station> station = [
    Station(
      id: 'Main Station',
      total: 64,
      imagePath: 'assets/fitness_app/cefs.png',
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    Station(
      id: 'Station A',
      total: 43,
      imagePath: 'assets/fitness_app/cefs.png',
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    Station(
      id: 'Station B',
      total: 37,
      imagePath: 'assets/fitness_app/cefs.png',
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    Station(
      id: 'FTG',
      total: 6,
      imagePath: 'assets/fitness_app/cefs.png',
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
