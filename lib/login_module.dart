library login_module;

import 'package:flutter/material.dart';
import 'package:login_module/screens/login_screen.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

/*class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  var count = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
       padding: EdgeInsets.all(5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(count.toString(), style: TextStyle(fontSize: 24, color: Colors.black),),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              setState(() {
                count = count+1;
              });
            }, child: const Text("add"))
          ],
        ),
      ),
    );
  }
}*/
