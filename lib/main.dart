// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:student_state_management/application/student_bloc/student_bloc.dart';
// import 'package:student_state_management/domain/modal/modal.dart';
// import 'package:student_state_management/presentation/screens/homescreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_state_management/application/student_bloc/student_bloc.dart';
import 'package:student_state_management/domain/model/modal.dart';
import 'package:student_state_management/presentation/screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentBloc>(
      create: (context) => StudentBloc(),
      child: MaterialApp(
        theme:
            ThemeData(primaryColor: Colors.green, primarySwatch: Colors.green),
        title: 'StudentList',
        debugShowCheckedModeBanner: false,
        home: const MyHome(),
      ),
    );
  }
}


