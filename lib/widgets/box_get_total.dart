import 'package:flutter/material.dart';


class GetTotalContainer extends StatelessWidget {
  Icon icon;
  String text;
  Future<int> service;

  GetTotalContainer({
    super.key,
    required this.icon,
    required this.text,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: service,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final int count = snapshot.data ?? 0;
          return Expanded(
              child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '$count',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: icon,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 10, left: 15),
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ));
        }
      },
    );
  }
}
