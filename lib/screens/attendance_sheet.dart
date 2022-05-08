import 'package:attendance_uni_app/models/student.dart';
import 'package:attendance_uni_app/provider/attendance.dart';
import 'package:attendance_uni_app/provider/new_students.dart';
import 'package:attendance_uni_app/utilities/routes.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttendanceSheet extends StatefulWidget {
  final String subjName;
  const AttendanceSheet({Key? key, required this.subjName}) : super(key: key);

  @override
  State<AttendanceSheet> createState() => _AttendanceSheetState();
}

class _AttendanceSheetState extends State<AttendanceSheet> {
  bool _isLoading = false;
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,

      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final Students students = Provider.of<Students>(context);
    final Attendance attendance = Provider.of<Attendance>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.subjName),
        actions: [
          TextButton(
            onPressed: () {
              // attendance.addAttendance(Student(id: '', name: attendance.attendance, rollNo: rollNo))
            },
            child: _isLoading == true
                ? CircularProgressIndicator(
                    color: Theme.of(context).hintColor,
                  )
                : Text('$_counter',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.height * 0.03,
                        fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: FutureBuilder(
          future: students.fetchAndSetStudent(),
          builder: (ctx, dataSnapshot) {
            // if (dataSnapshot.connectionState == ConnectionState.waiting) {
            //   return Center(
            //     child: CircularProgressIndicator(
            //       color: Theme.of(context).primaryColor,
            //     ),
            //   );
            // } else
            if (dataSnapshot.connectionState == ConnectionState.none) {
              return const Center(
                child: Text('Error Occured'),
              );
            } else {
              return students.studentsNew.isEmpty
                  ? Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(MyRoutes.addStudentScreenRoute);
                        },
                        child: Container(
                          height: size.height * 0.25,
                          width: size.width * 0.5,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(size.height * 0.05),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Theme.of(context).hintColor,
                                  Theme.of(context).cardColor,
                                ],
                              )),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Icon(
                                  Icons.info_outline,
                                  size: size.height * 0.07,
                                ),
                                SizedBox(
                                  height: size.height * 0.025,
                                ),
                                Text(
                                  "Please Add Student",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: size.height * 0.027,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Text(
                                  "Click Me to Add Student",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: size.height * 0.018,
                                    // fontWeight: FontWeight.w600
                                  ),
                                ),
                                // const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(size.height * 0.02),
                      child: Column(children: [
                        Text(
                          DateFormat('dd-MM-yyyy').format(selectedDate),
                          style: TextStyle(
                              fontSize: size.width * 0.08,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          onPressed: () => _selectDate(context), // Refer step 3
                          child: Text(
                            'Select date',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: students.studentsNew.length,
                          itemBuilder: (ctx, index) {
                            return Dismissible(
                                key: ValueKey(students.studentsNew[index].id),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  Provider.of<Students>(context, listen: false)
                                      .deleteNewStud(
                                          students.studentsNew[index].id);
                                },
                                confirmDismiss: (direction) {
                                  return showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      backgroundColor:
                                          Theme.of(context).errorColor,
                                      title: Text(
                                        'Are You Sure?',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                      content: Text(
                                        'Do you want to remove this student from the list?',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                          onPressed: () {
                                            Navigator.of(ctx).pop(true);
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            'No',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                          onPressed: () {
                                            Navigator.of(ctx).pop(false);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                                background: Card(
                                  margin: EdgeInsets.all(size.width * 0.05),
                                  color: Theme.of(context).errorColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        size.height * 0.05),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.6),
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                ),
                                child: ChangeNotifierProvider.value(
                                  value: students.studentsNew[index],
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(
                                              size.height * 0.05),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Theme.of(context).hintColor,
                                              Theme.of(context).cardColor,
                                            ],
                                          )),
                                      child: ListTile(
                                        leading: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${index + 1}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                            ),
                                          ],
                                        ),
                                        title: Text(
                                          students.studentsNew[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                          // textAlign: TextAlign.center,
                                        ),
                                        subtitle: Text(
                                          students.studentsNew[index].rollNo,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                        ),
                                        trailing: Wrap(
                                          spacing: 12,
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                                await attendance.addAttendance(
                                                  Student(
                                                    id: '',
                                                    date: DateFormat(
                                                            'dd-MM-yyyy')
                                                        .format(selectedDate),
                                                    subject: widget.subjName,
                                                    name: students
                                                        .studentsNew[index]
                                                        .name,
                                                    rollNo: students
                                                        .studentsNew[index]
                                                        .rollNo,
                                                    isPresent: true,
                                                  ),
                                                );

                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                _incrementCounter();
                                              },
                                              icon: const Icon(
                                                Icons.check,
                                                color: Colors.greenAccent,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                setState(() {
                                                  _isLoading = true;
                                                });

                                                await attendance.addAttendance(
                                                  Student(
                                                    id: '',
                                                    date: DateFormat(
                                                            'dd-MM-yyyy')
                                                        .format(selectedDate),
                                                    subject: widget.subjName,
                                                    name: students
                                                        .studentsNew[index]
                                                        .name,
                                                    rollNo: students
                                                        .studentsNew[index]
                                                        .rollNo,
                                                    isPresent: false,
                                                  ),
                                                );

                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                _incrementCounter();
                                              },
                                              icon: const Icon(
                                                Icons.clear_sharp,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ]));
            }
          }),
      floatingActionButton: FloatingActionButton(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        // ),

        onPressed: () {
          Navigator.of(context).pushNamed(MyRoutes.repAttendanceScreenRoute);
        },
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.horizontal(
        //         left: Radius.elliptical(30, 20),
        //         right: Radius.elliptical(20, 20))),
        child: Text(
          'Repeaters',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).iconTheme.color,
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.013),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
