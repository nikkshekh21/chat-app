import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/wether-provider.dart';

class CityBookmark extends StatefulWidget {
  const CityBookmark({super.key});

  @override
  State<CityBookmark> createState() => _CityBookmarkState();
}

class _CityBookmarkState extends State<CityBookmark> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<HomeProvider>();
    final cityName = provider.bookmarkcity ?? '';

    if (cityName.isNotEmpty) {
      provider.getWeatherData(cityName);
      provider.getWeather2Data(cityName);
    } else {
      print("City name is empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmark"),
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
            const SizedBox(height: 60),
            if (context.watch<HomeProvider>().model == null) ...[
              const Center(child: CircularProgressIndicator()),
            ] else ...[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      "${context.watch<HomeProvider>().model?.name}",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${context.watch<HomeProvider>().model?.wether?[0].main}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "${(context.watch<HomeProvider>().model?.mainModel?.temp ?? 0)}°C",
                      style: const TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        weatherDetail(Icons.thermostat,
                            "Feels like ${context.watch<HomeProvider>().model?.mainModel?.temp_min}°C"),
                        weatherDetail(Icons.water_drop,
                            "Humidity ${context.watch<HomeProvider>().model?.mainModel?.humidity}%"),
                        weatherDetail(Icons.visibility,
                            "Visibility ${context.watch<HomeProvider>().model?.visibility}km"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: context.watch<HomeProvider>().model2?.l?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "data : ${context.read<HomeProvider>().model2?.l?[index].mainModal2?.temp}",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget weatherDetail(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
