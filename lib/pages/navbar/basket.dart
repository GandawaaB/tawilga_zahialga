import 'package:flutter/material.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 130,
              child: Card(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Image(
                        image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/furniture-app-6fd25.appspot.com/o/ItemsImages%2F1684740848842?alt=media&token=5f07e604-5bdc-4122-b9b5-208da131e32a "),
                        fit: BoxFit.cover,
                        width: 150,
                        height: 130,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Product Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black54),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "\$322",
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Тоо ширхэг: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black38),
                                ),
                                Text(
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.amber),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.remove))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 15,
              ),
              Text(
                "Нийт: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                "\$322",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Color.fromARGB(255, 245, 63, 50)),
              )
            ],
          )
        ],
      ),
    );
  }
}
