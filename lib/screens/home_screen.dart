import 'dart:async';

import 'package:attendance_uni_app/configs/images_paths.dart';
import 'package:attendance_uni_app/provider/subjects.dart';
import 'package:attendance_uni_app/screens/attendance_sheet.dart';
import 'package:attendance_uni_app/screens/repeaters_attendance_sheet.dart';
import 'package:attendance_uni_app/utilities/routes.dart';
import 'package:attendance_uni_app/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refreshIndic(BuildContext context) async {
    await Provider.of<Subjects>(context, listen: false).fetchAndSet();
  }

  @override
  Widget build(BuildContext context) {
    final Subjects mySubjects = Provider.of<Subjects>(context);
    // final List<Subject> subjectsList = subjects.subjects;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('SUBJECTS'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(MyRoutes.addSubjectScreenRoute);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
          future: mySubjects.fetchAndSet(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else if (dataSnapshot.connectionState == ConnectionState.none) {
              return const Center(
                child: Text('Error Occured'),
              );
            } else {
              return RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  onRefresh: () => _refreshIndic(context),
                  child: Stack(children: [
                    Container(
                      height: size.height,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.7), BlendMode.dstATop),
                          image: const AssetImage(splashBack),
                        ),
                      ),
                    ),
                    mySubjects.subjects.isEmpty
                        ? Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(MyRoutes.addSubjectScreenRoute);
                              },
                              child: Container(
                                height: size.height * 0.25,
                                width: size.width * 0.5,
                                decoration: BoxDecoration(
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
                                        "Please Add Subject",
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
                                        "Click Me to Add Subject",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
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
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 15,
                            ),
                            itemCount: mySubjects.subjects.length,
                            itemBuilder: (ctx, index) {
                              return Dismissible(
                                key: Key(mySubjects.subjects[index].id),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  Provider.of<Subjects>(context, listen: false)
                                      .deleteSubj(
                                          mySubjects.subjects[index].id);
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
                                  margin: EdgeInsets.all(size.width * 0.08),
                                  color: Theme.of(context).errorColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        size.height * 0.05),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.1),
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                ),
                                child: Column(children: [
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  ChangeNotifierProvider.value(
                                    value: mySubjects.subjects[index],
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(size.height * 0.035),
                                      child: SizedBox(
                                        height: size.height * 0.1,
                                        child: GridTile(
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      title: Text(
                                                        'Choose Please',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary),
                                                      ),
                                                      content: Text(
                                                        'Please Select Regular students sheet or repeater student sheet',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              await Navigator.of(
                                                                      context)
                                                                  .push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => AttendanceSheet(
                                                                      subjName: mySubjects
                                                                          .subjects[
                                                                              index]
                                                                          .subName),
                                                                ),
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              'Regular',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary),
                                                            )),
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              await Navigator.of(
                                                                      context)
                                                                  .push(
                                                                      MaterialPageRoute(
                                                                builder: (context) => RepeaterAttendanceSheet(
                                                                    subjName: mySubjects
                                                                        .subjects[
                                                                            index]
                                                                        .subName),
                                                              ));
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              'Repeater',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary),
                                                            ))
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              // height: size.height * 0.1,
                                              // width: 10,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          size.height * 0.05),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      Theme.of(context)
                                                          .hintColor,
                                                      Theme.of(context)
                                                          .cardColor,
                                                    ],
                                                  )),
                                              child: Center(
                                                child: Text(
                                                  mySubjects
                                                      .subjects[index].subName,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      fontSize:
                                                          size.height * 0.027,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              );
                            })
                  ]));
            }
          }),
      floatingActionButton: FloatingActionButton(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        // ),

        onPressed: () {
          Navigator.of(context).pushNamed(MyRoutes.addStudentScreenRoute);
        },
        child: Text(
          'Add Student',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).iconTheme.color,
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.017),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
    // floatingActionButtonLocation: FloatingActionButtonLocation,
  }
}
