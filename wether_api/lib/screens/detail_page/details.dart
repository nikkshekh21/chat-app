import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/wether-provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter City Name',
                suffixIcon: IconButton(
                  onPressed: () {
                    String text = controller.text;
                    context.read<HomeProvider>().getWeatherData(text);
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 20),
            context.watch<HomeProvider>().bookmarkcity != null
                ? Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal,
                    ),
                    child: ListTile(
                      title:
                          Text("${context.read<HomeProvider>().bookmarkcity}"),
                      subtitle: Text(
                          "${context.read<HomeProvider>().model?.mainModel?.temp} K"),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
