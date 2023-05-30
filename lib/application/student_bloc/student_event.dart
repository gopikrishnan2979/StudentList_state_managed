part of 'student_bloc.dart';

class StudentEvent {}

class StudentAdd extends StudentEvent {
  StudentModel data;
  StudentAdd({required this.data});
}

class StudentGetAll extends StudentEvent {}

class StudentRemove extends StudentEvent {
  StudentModel data;
  StudentRemove({required this.data});
}

class StudentEdit extends StudentEvent {
  StudentModel data;
  int editingindex;
  StudentEdit({required this.data, required this.editingindex});
}

class StudentSearch extends StudentEvent {
  String query;
  StudentSearch({required this.query});
}
