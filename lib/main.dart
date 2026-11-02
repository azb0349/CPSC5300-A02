import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cozy Cup',
      home: const MyHomePage(title: 'Cozy Cup'),
    );
  }
}

class ListItem extends StatelessWidget {
  final IconData iconData;
  final String itemName;
  final String price;
  final int quantity;
  final VoidCallback onAdd;
  const ListItem({
    super.key,
    required this.iconData,
    required this.itemName,
    required this.price,
    required this.quantity,
    required this.onAdd,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(itemName),
      subtitle: Text(price),
      trailing: ActionItem(counter: quantity, onAdd: onAdd),
    );
  }
}

class ActionItem extends StatelessWidget {
  final int counter;
  final VoidCallback onAdd;

  const ActionItem({super.key, required this.counter, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$counter'),
        IconButton(onPressed: onAdd, icon: const Icon(Icons.add)),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, int> quantities = {
    "Brown Butter Latte": 0,
    "Pistachio Latte": 0,
    'Iced Brown Sugar Shaken Espresso': 0,
    'Banana Bread Latte': 0,
  };
  bool extraShot = false;
  double get total {
    return quantities["Brown Butter Latte"]! * 7.81 +
        quantities["Pistachio Latte"]! * 7.81 +
        quantities["Iced Brown Sugar Shaken Espresso"]! * 6.99 +
        quantities["Banana Bread Latte"]! * 7.81 +
        (extraShot ? 1.00 : 0.00);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDD0),
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Color(0xFF785548),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        foregroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            const SizedBox(height: 25),
            const Icon(Icons.coffee, size: 65, color: Colors.brown),
            const SizedBox(height: 10),
            const Text(
              'Welcome to Cozy cup',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Menu',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            ListItem(
              iconData: Icons.local_cafe,
              itemName: "Brown Butter Latte",
              price: '\$7.81',
              quantity: quantities["Brown Butter Latte"]!,
              onAdd: () {
                setState(() {
                  quantities["Brown Butter Latte"] =
                      quantities["Brown Butter Latte"]! + 1;
                });
              },
            ),

            ListItem(
              iconData: Icons.local_cafe,
              itemName: "Pistachio Latte",
              price: '\$7.81',
              quantity: quantities["Pistachio Latte"]!,
              onAdd: () {
                setState(() {
                  quantities["Pistachio Latte"] =
                      quantities["Pistachio Latte"]! + 1;
                });
              },
            ),

            ListItem(
              iconData: Icons.local_cafe,
              itemName: "Iced Brown Sugar Shaken Espresso",
              price: '\$6.99',
              quantity: quantities["Iced Brown Sugar Shaken Espresso"]!,
              onAdd: () {
                setState(() {
                  quantities["Iced Brown Sugar Shaken Espresso"] =
                      quantities["Iced Brown Sugar Shaken Espresso"]! + 1;
                });
              },
            ),

            ListItem(
              iconData: Icons.local_cafe,
              itemName: "Banana Bread Latte",
              price: '\$7.81',
              quantity: quantities["Banana Bread Latte"]!,
              onAdd: () {
                setState(() {
                  quantities["Banana Bread Latte"] =
                      quantities["Banana Bread Latte"]! + 1;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Add an extra espresso shot'),
              subtitle: const Text('Additional charge:\$1.00'),
              value: extraShot,
              onChanged: (bool value) {
                setState(() {
                  extraShot = value;
                });
              },
            ),
            if (extraShot)
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Extra espresso shot added!',
                  style: TextStyle(color: Colors.brown),
                ),
              ),

            const SizedBox(height: 20),
            //UI element explored was card it helped to organize my interface
            //This was done by displaying my order total in a separate section of the app
            //It also helps the total stand out from the rest of the menu
            Card(
              elevation: 4,
              color: Colors.brown,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Order Total:\$${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade100,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Order Confirmed'),
                      content: Text(
                        'Your Cozy Cup order total is \$${total.toStringAsFixed(2)}.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Alright'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
