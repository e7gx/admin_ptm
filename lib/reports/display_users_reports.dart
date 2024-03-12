import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:lottie/lottie.dart';

const apiKey = '';
const projectId = 'flutterdatabase-7e044';

class DisplayReports extends StatefulWidget {
  const DisplayReports({super.key});

  @override
  State<DisplayReports> createState() => _DisplayReportsState();
}

class _DisplayReportsState extends State<DisplayReports> {
  late CollectionReference ptm;

  @override
  void initState() {
    super.initState();
    ptm = Firestore.instance.collection('User_Reports');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color.fromARGB(255, 88, 193, 245),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder(
          future: ptm.get(),
          builder: (context, AsyncSnapshot<List<Document>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animation/like1.json',
                        fit: BoxFit.contain, width: 100, height: 100),
                    const Text(
                      'لا يوجد بلاغات',
                      style: TextStyle(
                          fontFamily: 'Cario',
                          color: Colors.black54,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Document document = snapshot.data![index];
                  // Add 1 to index because indexing starts from 0
                  int itemNumber = index + 1;
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.tealAccent,
                          Colors.white,
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: ListTile(
                      leading: Text(
                        '$itemNumber',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      title: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/pc.png',
                              height: 100,
                              width: 100,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              document['location'] ?? 'Location Not Available',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              document['device'] ?? 'Device Not Available',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Expanded(
                              child: Text(
                                document['problem'] ?? 'Problem Not Available',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/animation/like1.json',
                      fit: BoxFit.contain, width: 100, height: 100),
                  const Text(
                    'لا يوجد بلاغات',
                    style: TextStyle(
                        fontFamily: 'Cario',
                        color: Colors.black54,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
