import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_state_management/application/student_bloc/student_bloc.dart';
import 'package:student_state_management/domain/model/modal.dart';
import 'package:student_state_management/presentation/screens/profilescreen/profilescreen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final TextEditingController _searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          SizedBox(
            child: SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.black,
                  controller: _searchcontroller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFDDDCDC),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (value) {
                    BlocProvider.of<StudentBloc>(context)
                        .add(StudentSearch(query: value));
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<StudentBloc, StudentState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                  child: (_searchcontroller.text.isNotEmpty ||
                              _searchcontroller.text.trim().isNotEmpty) &&
                          state.searchlist!.isEmpty
                      ? const Center(
                          child: Text('Item not found'),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                StudentModel data = _searchcontroller
                                            .text.isEmpty ||
                                        _searchcontroller.text.trim().isEmpty
                                    ? state.studentlist[index]
                                    : state.searchlist![index];
                                int idx =
                                    profilefinder(data, state.studentlist);
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ProfileScrn(
                                      profile: _searchcontroller.text.isEmpty ||
                                              _searchcontroller.text
                                                  .trim()
                                                  .isEmpty
                                          ? state.studentlist[index]
                                          : state.searchlist![index],
                                      profileindex: idx),
                                ));
                              },
                              tileColor: Colors.blue[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              leading: CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 30,
                                backgroundImage: imageselector(_searchcontroller
                                            .text.isEmpty ||
                                        _searchcontroller.text.trim().isEmpty
                                    ? state.studentlist[index].path
                                    : state.searchlist![index].path),
                              ),
                              title: Text(_searchcontroller.text.isEmpty ||
                                      _searchcontroller.text.trim().isEmpty
                                  ? state.studentlist[index].name
                                  : state.searchlist![index].name),
                              subtitle: Text(
                                  '${(_searchcontroller.text.isEmpty || _searchcontroller.text.trim().isEmpty) ? state.studentlist[index].age : state.searchlist![index].age}'),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: _searchcontroller.text.isEmpty ||
                                  _searchcontroller.text.trim().isEmpty
                              ? state.studentlist.length
                              : state.searchlist!.length,
                        ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }

  int profilefinder(StudentModel data, List<StudentModel> studentlist) {
    int index = -1;
    for (int i = 0; i < studentlist.length; i++) {
      if (studentlist[i] == data) {
        index = i;
        break;
      }
    }
    return index;
  }

  imageselector(String? path) {
    if (path == null) {
      return const AssetImage('assets/unknown.jpg');
    } else {
      return FileImage(File(path));
    }
  }
}
