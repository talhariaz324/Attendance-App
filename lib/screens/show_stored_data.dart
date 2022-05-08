import 'package:attendance_uni_app/provider/attendance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowStored extends StatelessWidget {
  final String subjName;
  final String date;
  const ShowStored({Key? key, required this.subjName, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Attendance data = Provider.of<Attendance>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(subjName),
      ),
      body: FutureBuilder(
          future: data.fetchAndSetData(date: date, subject: subjName),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else if (dataSnapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Text(
                  'Error Occured',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: size.width * 0.05),
                ),
              );
            } else if (data.attendance.isEmpty) {
              return Center(
                child: Text(
                  'No result found of this date',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: size.width * 0.05),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: data.attendance.length,
                itemBuilder: (ctx, index) {
                  return ChangeNotifierProvider.value(
                    value: data.attendance[index],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
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
                        child: ListTile(
                          // leading: ,
                          title: Text(
                            data.attendance[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary),
                            // textAlign: TextAlign.center,
                          ),
                          subtitle: Text(
                            data.attendance[index].rollNo,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          trailing: data.attendance[index].isPresent == true
                              ? IconButton(
                                  onPressed: () {
                                    // student.changeStatus();
                                  },
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.greenAccent,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    // student.changeStatus();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
      // floatingActionButton: FloatingActionButton(
      //   // shape: RoundedRectangleBorder(
      //   //   borderRadius: BorderRadius.circular(10.0),
      //   // ),

      //   onPressed: () {
      //     Navigator.of(context).pushNamed(MyRoutes.repShowDataScreenRoute);
      //   },
      //   // shape: const RoundedRectangleBorder(
      //   //     borderRadius: BorderRadius.horizontal(
      //   //         left: Radius.elliptical(30, 20),
      //   //         right: Radius.elliptical(20, 20))),
      //   child: Text(
      //     'Repeaters',
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //         color: Theme.of(context).iconTheme.color,
      //         fontWeight: FontWeight.bold,
      //         fontSize: size.height * 0.013),
      //   ),
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
    );
  }
}
