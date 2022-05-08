import 'package:attendance_uni_app/configs/images_paths.dart';
import 'package:attendance_uni_app/provider/subjects.dart';
import 'package:attendance_uni_app/widgets/valid_text_form_sub_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSubject extends StatefulWidget {
  const AddSubject({Key? key}) : super(key: key);
  @override
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  final TextEditingController subName = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final subjects = Provider.of<Subjects>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Add Subject'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              // SizedBox(height: size.height * 0.1),
              SizedBox(
                height: size.height * 0.5,
                // width: size.width * 0.5,
                // padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  uniLogo,
                ),
              ),
              ValideSubNameTextFormField(name: subName),
              SizedBox(height: size.height * 0.02),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : IconButton(
                      onPressed: () async {
                        if (_globalKey.currentState!.validate()) {
                          try {
                            setState(() {
                              _isLoading = true;
                            });
                            await subjects.addSubject(
                                Subject(subName: subName.text, id: ''));
                            setState(() {
                              _isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    const Text('Subject added successfully'),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            );
                          } catch (error) {
                            await showDialog<void>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('An error occurred!'),
                                content: const Text('Something went wrong.'),
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
                      icon: Icon(
                        Icons.add,
                        size: size.height * 0.09,
                        color: Theme.of(context).primaryColor,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
