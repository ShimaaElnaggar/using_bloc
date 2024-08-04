import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_bloc/bloc/employee_bloc.dart';
import 'package:using_bloc/repository/employee_repository.dart';
import 'package:using_bloc/views/show_employees.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => EmployeeBloc(EmployeeRepository()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ShowEmployees(),
    );
  }
}
