import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../management_app_theme.dart';
import '../main.dart';
import '../../main.dart';
import '../models/patient.dart';
import '../models/station.dart';
import '../ui_view/mediterranean_diet_view.dart';
import '../ui_view/wave_view.dart';

class OperationUnitView extends StatefulWidget {
  const OperationUnitView({
    Key? key,
    this.mainScreenAnimationController,
    this.mainScreenAnimation,
    required this.currentDate,
  }) : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  final DateTime currentDate;

  @override
  _OperationUnitViewState createState() => _OperationUnitViewState();
}

class _OperationUnitViewState extends State<OperationUnitView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<Station> stationData = Station.station;
  List<Patient> patientData = Patient.patients;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Column(
              children: [
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, right: 16, left: 16),
                    itemCount: stationData.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          stationData.length > 10 ? 10 : stationData.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return OperationView(
                        stationData: stationData[index],
                        animation: animation,
                        animationController: animationController!,
                        currentDate: widget.currentDate,
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    itemCount: stationData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          stationData.length > 10 ? 10 : stationData.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return MediterranesnDietView(
                        stationData: stationData[index],
                        animation: animation,
                        animationController: animationController!,
                        currentDate: widget.currentDate,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OperationView extends StatefulWidget {
  const OperationView({
    Key? key,
    this.stationData,
    this.animationController,
    this.animation,
    required this.currentDate,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;
  final Station? stationData;
  final DateTime currentDate;

  @override
  State<OperationView> createState() => _OperationViewState();
}

class _OperationViewState extends State<OperationView> {
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd-MMM");
    List<Patient> displayedPatient = Patient.patients.where((p) {
      String now = dateFormat.format(widget.currentDate);
      String start = dateFormat.format(p.startDate);
      String end = dateFormat.format(p.endDate);
      if (widget.currentDate.isAfter(p.startDate) &&
              widget.currentDate.isBefore(p.endDate) ||
          now.compareTo(start) == 0 ||
          now.compareTo(end) == 0) {
        return p.station.contains(widget.stationData!.id);
      } else {
        return p.station.contains('none');
      }
    }).toList();
    double percent = 100;
    setState(() {
      percent = ((widget.stationData!.total - displayedPatient.length) /
              widget.stationData!.total) *
          100;
    });
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - widget.animation!.value), 0.0, 0.0),
            child: Row(
              children: [
                SizedBox(
                  width: 130,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32, left: 8, right: 8, bottom: 16),
                        child: InkWell(
                          onTap: () {
                            // FocusScope.of(context).requestFocus(FocusNode());
                            // showCard(
                            //     context: context,
                            //     currentDate: widget.currentDate);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color:
                                        HexColor(widget.stationData!.endColor)
                                            .withOpacity(0.6),
                                    offset: const Offset(1.1, 4.0),
                                    blurRadius: 8.0),
                              ],
                              gradient: LinearGradient(
                                colors: <HexColor>[
                                  HexColor(widget.stationData!.startColor),
                                  HexColor(widget.stationData!.endColor),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(54.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 60, left: 16, right: 16, bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.stationData!.id,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: ManagementAppTheme.fontName,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 0.2,
                                      color: ManagementAppTheme.white,
                                    ),
                                  ),
                                  const Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 8, bottom: 8),
                                    ),
                                  ),
                                  widget.stationData?.total != 0
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Container(
                                                width: 60,
                                                height: 160,
                                                decoration: BoxDecoration(
                                                  color: HexColor('#E8EDFE'),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  80.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  80.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  80.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  80.0)),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                        color:
                                                            ManagementAppTheme
                                                                .grey
                                                                .withOpacity(
                                                                    0.4),
                                                        offset:
                                                            const Offset(2, 2),
                                                        blurRadius: 4),
                                                  ],
                                                ),
                                                child: WaveView(
                                                  percentageValue: percent,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color:
                                                ManagementAppTheme.nearlyWhite,
                                            shape: BoxShape.circle,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: ManagementAppTheme
                                                      .nearlyBlack
                                                      .withOpacity(0.4),
                                                  offset:
                                                      const Offset(8.0, 8.0),
                                                  blurRadius: 8.0),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(
                                              Icons.add,
                                              color: HexColor(
                                                  widget.stationData!.endColor),
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            color:
                                ManagementAppTheme.nearlyWhite.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.asset(widget.stationData!.imagePath),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showCard({BuildContext? context, required DateTime currentDate}) {
    DateFormat dateFormat = DateFormat("dd-MMM");
    List<Patient> displayedPatient = Patient.patients.where((p) {
      String now = dateFormat.format(currentDate);
      String start = dateFormat.format(p.startDate);
      String end = dateFormat.format(p.endDate);
      if (widget.currentDate.isAfter(p.startDate) &&
              widget.currentDate.isBefore(p.endDate) ||
          now.compareTo(start) == 0 ||
          now.compareTo(end) == 0) {
        return p.station.contains(widget.stationData!.id);
      } else {
        return p.station.contains('none');
      }
    }).toList();
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => SimpleDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.stationData!.id),
            Text(dateFormat.format(currentDate)),
          ],
        ),
        children: <Widget>[
          Center(child: Text('Total Manpower: ${widget.stationData!.total}')),
          Center(child: Text('No. of patients: ${displayedPatient.length}')),
          ...displayedPatient.map(
            (e) => Center(
              child: Text(e.name),
            ),
          ),
        ],
      ),
    );
  }
}
