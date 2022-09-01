import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlng/Controller/CalculateDistatanceController.dart';

import '../CalculateDistanceLocation.dart';

class Result extends GetView<CalculateDistanceController> {
  Result({Key? key}) : super(key: key);

  final controller = Get.put(CalculateDistanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.calculate();
                    controller.update();
                  },
                  child: const Text('Calculate'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.locations.clear();
                    controller.pickCurrentLocation();
                    controller.update();
                  },
                  child: const Text('Pick LatLng'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GeolocatorWidget(),
                      ),
                    );
                  },
                  child: const Text('Move'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.totalDistance.value.toString()),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: _showLocations(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showLocations() {
    var random = Random();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.3),
        border: Border.all(color: Colors.black),
      ),
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              ((context, index) => InkWell(
                    onTap: () {},
                    child: Center(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          '${controller.locations[index].lat} , ${controller.locations[index].lng}',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color.fromRGBO(
                              random.nextInt(255),
                              random.nextInt(155),
                              random.nextInt(255),
                              1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              childCount: controller.locations.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisExtent: 40,
            ),
          )
        ],
      ),
    );
  }
}
