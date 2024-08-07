import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_bloc/bloc/employee_bloc.dart';
import '../models/employee.dart';

class ShowEmployees extends StatefulWidget {
  const ShowEmployees({
    super.key,
  });

  @override
  State<ShowEmployees> createState() => _ShowEmployess();
}

class _ShowEmployess extends State<ShowEmployees> {
  @override
  void initState() {
    context.read<EmployeeBloc>().add(LoadEmployeeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade100,
        title: const Text(
          'Show Employees',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo.shade100,
        onPressed: () => buildEmployeeDialoge( context ),
        child: const Icon(Icons.add,color: Colors.indigo,),
      ),
      body: buildEmployeeList(),
    );
  }
Future<void> buildEmployeeDialoge(BuildContext context)async{
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Employee'),
          content: const TextField(),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel',style: TextStyle(color: Colors.indigo),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: BlocBuilder<EmployeeBloc,EmployeeState>(
                buildWhen: (previous,current)=> current is EmployeeAddedState,
                builder: (context, state) {
                  if (state is EmployeeAddingSuccessfulState) {
                    Navigator.pop(context);
                    return const SizedBox.shrink();
                  }
                  if (state is EmployeeAddingLoadingState) {
                    return const Center(child: CircularProgressIndicator(color:Colors.indigo ,));
                  } else if (state is EmployeeErrorState) {
                    return Text('Error: ${state.errorMessage}');
                  } else {
                    return const Text('Add',style: TextStyle(color: Colors.indigo));
                  }
                },
              ),
              onPressed: () {
                var emp = Employee.fromJson(
                  {
                    "username": "nada22",
                    "password": "revolver",
                    "name": {
                      "first": "nada",
                      "last": "Ahmed"
                    },
                    "ssn": "815-56-8221",
                    "dob": "1992-12-17T06:00:00.000Z",
                    "hiredOn": "2013-01-17T06:00:00.000Z",
                    "terminatedOn": null,
                    "email": "nada.gutierrez33@company.com",
                    "phones": [
                      {
                        "type": "office",
                        "number": "601-692-3621"
                      },
                      {
                        "type": "home",
                        "number": "577-170-8972"
                      }
                    ],
                    "address": {
                      "street": "9977 Saddle Dr",
                      "city": "Mesquite",
                      "state": "Idaho",
                      "zip": "52655"
                    },
                    "roles": [
                      "salaried",
                      "part time",
                      "contractor"
                    ],
                    "department": "Sales",
                    "gender": "female",
                    "portrait": "portraits/ticklishdog505.jpg",
                    "thumbnail": "portraits/ticklishdog505-thumb.jpg"
                  },
                );
                context.read<EmployeeBloc>().add(AddEmployeeEvent(emp));
              },
            ),
          ],
        );
      });
}

  Center buildEmployeeList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BlocBuilder<EmployeeBloc, EmployeeState>(
            buildWhen: (prevoius,current)=> current is! EmployeeAddedState,
              builder: (context, state) {
            if (state is EmployeeLoadedState) {
              if (state.employees.isEmpty) {
                return const Center(child: Text('No Data Available'));
              } else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.employees.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: buildEmployeeCard(state, index),
                        );
                      }),
                );
              }
            } else if (state is EmployeeErrorState) {
              return Text('Error: ${state.errorMessage}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ],
      ),
    );
  }

  Card buildEmployeeCard(EmployeeLoadedState state, int index) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.all(8.0),
      color: Colors.white,
      shadowColor: Colors.indigo,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Text(
          "${state.employees[index].name?.first ?? 'No Name'} ${state
              .employees[index].name?.last ?? 'No Name'}",
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          state.employees[index].email.toString(),
          style: const TextStyle(color: Colors.indigo),
        ),
        trailing: Text(
          state.employees[index].address?.city ??
              'No Adress',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
