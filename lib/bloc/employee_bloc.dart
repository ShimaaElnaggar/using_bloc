import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/employee.dart';
import '../repository/employee_repository.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository _employeeRepository;
  EmployeeBloc(this._employeeRepository) : super(EmployeeLoadingState()) {
    on<LoadEmployeeEvent>(onEmployeeEventLoad);
  }

  FutureOr<void> onEmployeeEventLoad(
      LoadEmployeeEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoadingState());
    await _employeeRepository.getEmployees().then((employees) {
      emit(EmployeeLoadedState(employees));
    }).catchError((error) {
      emit(EmployeeErrorState(error));
    });
  }
}
