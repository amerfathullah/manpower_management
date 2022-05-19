import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../management_app_theme.dart';
import '../models/patient.dart';
import './operation_unit_view.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen>
    with TickerProviderStateMixin, ChangeNotifier {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  DateTime currentDate = DateTime.now();
  DateFormat dateFormat = DateFormat("dd-MMM");

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;
    listViews.add(
      OperationUnitView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: const Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
        currentDate: currentDate,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  Future<void> refreshPatients(BuildContext context) async {
    await fetchAndSetPatients();
  }

  Future<void> fetchAndSetPatients() async {
    final url = Uri.parse(
        'https://manpower-management-427bf-default-rtdb.asia-southeast1.firebasedatabase.app/patients.json');
    try {
      final response = await http.get(url);
      // print(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      // ignore: unnecessary_null_comparison
      if (extractedData == null) {
        return;
      }
      Shift? loadedShift;
      final List<Patient> loadedPatients = [];
      extractedData.forEach((prodId, prodData) {
        if (prodData['shift'] == 'Shift.A') {
          loadedShift = Shift.A;
        } else if (prodData['shift'] == 'Shift.B') {
          loadedShift = Shift.B;
        } else if (prodData['shift'] == 'Shift.C') {
          loadedShift = Shift.C;
        } else if (prodData['shift'] == 'Shift.D') {
          loadedShift = Shift.D;
        } else {
          loadedShift = null;
        }
        loadedPatients.add(
          Patient(
            id: prodId,
            name: prodData['name'],
            shift: loadedShift,
            station: prodData['station'],
            startDate: DateTime.parse(prodData['startDate']),
            endDate: DateTime.parse(prodData['endDate']),
          ),
        );
      });
      Patient.patients = loadedPatients;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagementAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: refreshPatients(context),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () => refreshPatients(context),
                        child: Stack(
                          children: <Widget>[
                            getMainListViewUI(),
                            getAppBarUI(),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      )),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  30,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ManagementAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: ManagementAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Manpower Management',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: ManagementAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: ManagementAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 38,
                            //   width: 38,
                            //   child: InkWell(
                            //     highlightColor: Colors.transparent,
                            //     borderRadius: const BorderRadius.all(
                            //         Radius.circular(32.0)),
                            //     onTap: () {
                            //       setState(() {
                            //         DateTime previousDate = currentDate
                            //             .subtract(const Duration(days: 1));
                            //         currentDate = previousDate;
                            //       });
                            //     },
                            //     child: const Center(
                            //       child: Icon(
                            //         Icons.keyboard_arrow_left,
                            //         color: ManagementAppTheme.grey,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: ManagementAppTheme.grey,
                                      size: 18,
                                    ),
                                  ),
                                  Text(
                                    dateFormat.format(currentDate),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontFamily: ManagementAppTheme.fontName,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      letterSpacing: -0.2,
                                      color: ManagementAppTheme.darkerText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 38,
                            //   width: 38,
                            //   child: InkWell(
                            //     highlightColor: Colors.transparent,
                            //     borderRadius: const BorderRadius.all(
                            //         Radius.circular(32.0)),
                            //     onTap: () {
                            //       setState(() {
                            //         DateTime nextDate = currentDate
                            //             .add(const Duration(days: 1));
                            //         currentDate = nextDate;
                            //       });
                            //     },
                            //     child: const Center(
                            //       child: Icon(
                            //         Icons.keyboard_arrow_right,
                            //         color: ManagementAppTheme.grey,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
