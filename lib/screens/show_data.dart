import 'package:attendance_uni_app/provider/subjects.dart';
import 'package:attendance_uni_app/screens/show_stored_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ShowData extends StatefulWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
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
    final Subjects subjects = Provider.of<Subjects>(context, listen: false);
    final List<Subject> subjectsList = subjects.subjects;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Show Data'),
        ),
        body: Padding(
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
              Expanded(
                child: ListView.builder(
                    itemCount: subjectsList.length,
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                          value: subjectsList[index],
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
                                    title: Text(
                                      subjectsList[index].subName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      textAlign: TextAlign.center,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ShowStored(
                                            subjName:
                                                subjectsList[index].subName,
                                            date: DateFormat('dd-MM-yyyy')
                                                .format(selectedDate),
                                          ),
                                        ),
                                      );
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (context) {
                                      //     return AlertDialog(
                                      //       backgroundColor:
                                      //           Theme.of(context).primaryColor,
                                      //       title: Text(
                                      //         'Choose Please',
                                      //         style: TextStyle(
                                      //             fontWeight: FontWeight.w600,
                                      //             color: Theme.of(context)
                                      //                 .colorScheme
                                      //                 .secondary),
                                      //       ),
                                      //       content: Text(
                                      //         'Please Select Regular students sheet or repeater student sheet',
                                      //         style: TextStyle(
                                      //             color: Theme.of(context)
                                      //                 .colorScheme
                                      //                 .secondary),
                                      //       ),
                                      //       actions: [
                                      //         TextButton(
                                      //             onPressed: () async {
                                      //               await Navigator.of(context)
                                      //                   .push(
                                      //                 MaterialPageRoute(
                                      //                   builder: (context) =>
                                      //                       ShowStored(
                                      //                     subjName:
                                      //                         subjectsList[index]
                                      //                             .subName,
                                      //                     date: DateFormat(
                                      //                             'dd-MM-yyyy')
                                      //                         .format(
                                      //                             selectedDate),
                                      //                   ),
                                      //                 ),
                                      //               );

                                      //               Navigator.of(context).pop();
                                      //             },
                                      //             child: Text(
                                      //               'Regular',
                                      //               style: TextStyle(
                                      //                   fontWeight:
                                      //                       FontWeight.w600,
                                      //                   color: Theme.of(context)
                                      //                       .colorScheme
                                      //                       .secondary),
                                      //             )),
                                      //         TextButton(
                                      //             onPressed: () async {
                                      //               await Navigator.of(context)
                                      //                   .push(MaterialPageRoute(
                                      //                 builder: (context) =>
                                      //                     RepShowStored(
                                      //                         subjName:
                                      //                             subjectsList[
                                      //                                     index]
                                      //                                 .subName),
                                      //               ));
                                      //               Navigator.of(context).pop();
                                      //             },
                                      //             child: Text(
                                      //               'Repeater',
                                      //               style: TextStyle(
                                      //                   fontWeight:
                                      //                       FontWeight.w600,
                                      //                   color: Theme.of(context)
                                      //                       .colorScheme
                                      //                       .secondary),
                                      //             ))
                                      //       ],
                                      //     );
                                    },
                                  ))));
                    }),
              )
            ])));
  }
}
