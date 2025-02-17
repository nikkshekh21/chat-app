import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:wether_api/provider/wether-provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<HomeProvider>();
    final cityName = provider.city ?? '';
    if (cityName.isNotEmpty) {
      provider.getWeatherData(cityName);
      provider.getWeather2Data(cityName);
    } else {
      print("City name is empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = context.watch<HomeProvider>().model;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Page"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/details');
              },
              icon: const Icon(Icons.import_contacts_rounded))
        ],
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
            // Main Weather Container
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
                    "${context.watch<HomeProvider>().model?.wether![0].main}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${context.watch<HomeProvider>().model?.mainModel?.temp}°C",
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
            const SizedBox(height: 20),
            // Hourly Weather Forecast
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: List.generate(8, (index) {
                  return hourlyWeatherCard(
                      "${context.watch<HomeProvider>().model?.dt}",
                      "22°",
                      Icons.cloud);
                }),
              ),
            ),
            // City Weather List
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount:
                        context.watch<HomeProvider>().model2?.wether2?.length,
                    itemBuilder: (context, index) {
                      return Text(
                          "${context.read<HomeProvider>().model2?.wether2?[index].dt_txt}");
                    },
                  )),
            )
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

  Widget hourlyWeatherCard(String time, String temp, IconData icon) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 8),
          Icon(icon, color: Colors.white),
          const SizedBox(height: 8),
          Text(temp, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget cityWeatherCard(String city, String temp, String condition) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                condition,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            temp,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
