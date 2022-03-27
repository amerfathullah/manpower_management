import 'package:intl/intl.dart';

import '../fitness_app_theme.dart';
import '../main.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../models/patient.dart';
import '../models/station.dart';
import '../ui_view/wave_view.dart';

class MealsListView extends StatefulWidget {
  const MealsListView({
    Key? key,
    this.mainScreenAnimationController,
    this.mainScreenAnimation,
  }) : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<Station> stationData = Station.station;
  List<Patient> patientData = Patient.patients;

  // get displayedPatients => patientData.where((p) {return p.station.contains(stationData[index].id);});

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
            child: SizedBox(
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

                  // var displayedPatients = patientData.where((p) {return p.station.contains(stationData[index].id);});
                  return MealsView(
                    stationData: stationData[index],
                    animation: animation,
                    animationController: animationController!,
                  );
                },
                // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                //   maxCrossAxisExtent: 200,
                //   childAspectRatio: 1,
                //   crossAxisSpacing: 20,
                //   mainAxisSpacing: 20,
                // ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MealsView extends StatefulWidget {
  const MealsView(
      {Key? key,
      this.stationData,
      this.animationController,
      this.animation,
      this.patientData})
      : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;
  final Station? stationData;
  final Patient? patientData;

  @override
  State<MealsView> createState() => _MealsViewState();
}

class _MealsViewState extends State<MealsView> {
  @override
  Widget build(BuildContext context) {
    List<Patient> displayedPatient = Patient.patients.where((p) {
      return p.station.contains(widget.stationData!.id);
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
                            FocusScope.of(context).requestFocus(FocusNode());
                            // setState(() {
                            //   isDatePopupOpen = true;
                            // });
                            showCard(context: context);
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
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 0.2,
                                      color: FitnessAppTheme.white,
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
                                                        color: FitnessAppTheme
                                                            .grey
                                                            .withOpacity(0.4),
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
                                            color: FitnessAppTheme.nearlyWhite,
                                            shape: BoxShape.circle,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: FitnessAppTheme
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
                            color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
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

  void showCard({BuildContext? context}) {
    List<Patient> displayedPatient = Patient.patients.where((p) {
      return p.station.contains(widget.stationData!.id);
    }).toList();
    DateTime currentDate = DateTime.now();
    DateFormat dateFormat = DateFormat("dd-MMM");
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
