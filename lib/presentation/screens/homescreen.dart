import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_state_management/application/student_bloc/student_bloc.dart';
import 'package:student_state_management/presentation/screens/addscreen/addscreens.dart';
import 'package:student_state_management/presentation/screens/profilescreen/profilescreen.dart';
import 'package:student_state_management/presentation/screens/search/search_scrn.dart';

// ValueNotifier<List<StudentModel>> studentlist = ValueNotifier([]);

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StudentBloc>(context).add(StudentGetAll());

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('STUDENT LIST'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value:BlocProvider.of<StudentBloc>(context),
                    child: SearchScreen(),
                  ),
                ));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<StudentBloc>(context),
                  child: ProfileScrn(
                      profile: state.studentlist[index], profileindex: index),
                ),
              )),
              tileColor: Colors.blue[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                radius: 30,
                backgroundImage: imageselector(state.studentlist[index].path),
              ),
              title: Text(state.studentlist[index].name),
              subtitle: Text('${state.studentlist[index].age}'),
              trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete'),
                          content:
                              const Text('Are you sure,\nYou want to delete'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('cancel')),
                            TextButton(
                                onPressed: () {
                                  BlocProvider.of<StudentBloc>(context).add(
                                      StudentRemove(
                                          data: state.studentlist[index]));
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Delete'))
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                    size: 30,
                  )),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: state.studentlist.length,
        );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<StudentBloc>(context),
                child: AddScreen(),
              ),
            ));
          },
          child: const Icon(
            Icons.add,
            size: 35,
          )),
    ));
  }

  // delete(StudentModel data) {
  //   studentDbDelete(data);
  // }

  imageselector(String? path) {
    if (path == null) {
      return const AssetImage('assets/unknown.jpg');
    } else {
      return FileImage(File(path));
    }
  }
}
