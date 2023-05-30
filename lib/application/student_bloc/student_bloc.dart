import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_state_management/domain/model/modal.dart';
import 'package:student_state_management/infrastructure/functions/functions.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {

  StudentBloc() : super(StudentState(studentlist: [])) {
    on<StudentGetAll>((event, emit) async {
      List<StudentModel> value = await fetchAllData();
      return emit(StudentState(studentlist: value));
    });

    on<StudentAdd>((event, emit) {
      List<StudentModel> value =
          studentDbAdd(data: event.data, studentlist: state.studentlist);
      return emit(StudentState(studentlist: value));
    });

    on<StudentRemove>((event, emit) {
      List<StudentModel> value =
          studentDbDelete(data: event.data, studentlist: state.studentlist);
      return emit(StudentState(studentlist: value));
    });

    on<StudentEdit>((event, emit) {
      List<StudentModel> value = studentEdit(
          data: event.data,
          studentlist: state.studentlist,
          editingindex: event.editingindex);
      return emit(StudentState(studentlist: value));
    });

    on<StudentSearch>((event, emit) {
      state.searchlist = searchdata(event.query, state.studentlist);
      return emit(StudentState(
          studentlist: state.studentlist, searchlist: state.searchlist));
    });
  }
}
