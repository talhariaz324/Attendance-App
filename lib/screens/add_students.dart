import 'package:attendance_uni_app/configs/images_paths.dart';
import 'package:attendance_uni_app/models/student.dart';
import 'package:attendance_uni_app/provider/new_students.dart';
import 'package:attendance_uni_app/provider/repeater_students.dart';
import 'package:attendance_uni_app/widgets/valid_text_form_rollno.dart';
import 'package:attendance_uni_app/widgets/valid_text_form_stu_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final TextEditingController _stuName = TextEditingController();
  final TextEditingController _rollNoName = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final students = Provider.of<Students>(context, listen: false);
    final repStudents = Provider.of<RepStudents>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              // SizedBox(height: size.height * 0.1),
              SizedBox(
                height: size.height * 0.4,
                // width: size.width * 0.5,
                // padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  uniLogo,
                ),
              ),
              Center(
                child: Text(
                  'Recommendation: If repeater then add rep with student name ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).errorColor,
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              ValideStuNameTextFormField(name: _stuName),
              SizedBox(height: size.height * 0.02),
              ValideRollNoNameTextFormField(name: _rollNoName),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.all(size.width * 0.09),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () async {
                              if (_globalKey.currentState!.validate()) {
                                try {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await students.addNewStudent(Student(
                                      id: '',
                                      name: _stuName.text,
                                      rollNo: _rollNoName.text));
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          'Student added successfully'),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  );
                                } catch (error) {
                                  await showDialog<void>(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text('An error occurred!'),
                                      content:
                                          const Text('Something went wrong.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Okay'),
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text(
                              'Regular',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          // SizedBox(
                          //   width: size.width * 0.1,
                          // ),
                          TextButton(
                            onPressed: () async {
                              if (_globalKey.currentState!.validate()) {
                                try {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await repStudents.addRepeaterStudent(Student(
                                      id: '',
                                      name: _stuName.text,
                                      rollNo: _rollNoName.text));
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          'Student added successfully'),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  );
                                } catch (error) {
                                  await showDialog<void>(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text('An error occurred!'),
                                      content:
                                          const Text('Something went wrong.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Okay'),
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text(
                              'Repeater',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
