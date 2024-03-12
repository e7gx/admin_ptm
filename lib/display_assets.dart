import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';

class DeviceAsset {
  final String? deviceBrand;
  final String? deviceCpu;
  final String? deviceHardDisk;
  final String? deviceLocation;
  final String? macAddress;
  final String? ministryNumber;
  final String? serialNumber;

  DeviceAsset({
    this.deviceBrand,
    this.deviceCpu,
    this.deviceHardDisk,
    this.deviceLocation,
    this.macAddress,
    this.ministryNumber,
    this.serialNumber,
  });

  factory DeviceAsset.fromMap(Map<String, dynamic> data) {
    return DeviceAsset(
      deviceBrand: data['device_brand'] as String?,
      deviceCpu: data['device_cpu'] as String?,
      deviceHardDisk: data['device_hard_disk'] as String?,
      deviceLocation: data['device_location'] as String?,
      macAddress: data['mac_address'] as String?,
      ministryNumber: (data['ministry_number'] is int)
          ? data['ministry_number'].toString()
          : data['ministry_number'] as String?,
      serialNumber: (data['serial_number'] is int)
          ? data['serial_number'].toString()
          : data['serial_number'] as String?,
    );
  }
}

class DisplayAssets extends StatefulWidget {
  const DisplayAssets({super.key});

  @override
  State<DisplayAssets> createState() => _DisplayAssetsState();
}

class _DisplayAssetsState extends State<DisplayAssets> {
  CollectionReference ptm = Firestore.instance.collection('devices_assets');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ptm.get(),
        builder: (context, AsyncSnapshot<List<Document>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            List<DeviceAsset> assets = snapshot.data!.map((Document document) {
              return DeviceAsset.fromMap(document.map);
            }).toList();

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: assets.length,
              itemBuilder: (context, index) {
                DeviceAsset asset = assets[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: 250,
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[
                            Image.asset('assets/images/pc.png'), // صورة الجهاز
                            const SizedBox(height: 50),
                            Text(
                              asset.deviceBrand ??
                                  'غير معروف', // استخدم قيمة افتراضية إذا كانت القيمة فارغة
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              asset.deviceCpu ??
                                  'غير معروف', // استخدم قيمة افتراضية إذا كانت القيمة فارغة
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              asset.deviceLocation ??
                                  'غير معروف', // استخدم قيمة افتراضية إذا كانت القيمة فارغة
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              asset.deviceHardDisk ??
                                  'غير معروف', // استخدم قيمة افتراضية إذا كانت القيمة فارغة
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }

          return const Text('لا يوجد بيانات');
        },
      ),
    );
  }
}
