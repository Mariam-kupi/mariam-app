import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class WasteItem {
  final String category;
  final String name;
  final String imageUrl;
  final int price;

  WasteItem({
    required this.category,
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

List<WasteItem> PlasticsItems = [
  WasteItem(
    category: 'Plastics',
    name: 'Agent 111',
    imageUrl: "https://th.bing.com/th/id/OIP.ZeFqpvKpaxd2y40a46wOqQHaC9?rs=1&pid=ImgDetMain",
    price: 230,
  ),
  WasteItem(
    category: 'Plastics',
    name: 'Agent 222',
    imageUrl: "https://th.bing.com/th/id/OIP.ZeFqpvKpaxd2y40a46wOqQHaC9?rs=1&pid=ImgDetMain",
    price: 230,
  ),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TYPES OF WASTE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text("TYPES OF WASTE"),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://i.pinimg.com/736x/96/7d/b6/967db683e191acc49969bfd49a0c1056.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          WasteCategoriesList(),
        ],
      ),
    );
  }
}

class WasteCategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1, // Changed to 1 for simplicity
      itemBuilder: (context, index) {
        String category = 'Plastics'; // Default category
        return ListTile(
          title: Text(
            category,
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WasteItemsScreen(category: category),
              ),
            );
          },
        );
      },
    );
  }
}

class WasteItemsScreen extends StatefulWidget {
  final String category;

  WasteItemsScreen({required this.category});
  @override
  _WasteItemsScreenState createState() => _WasteItemsScreenState();
}

class _WasteItemsScreenState extends State<WasteItemsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    List<WasteItem> items;
    switch (widget.category) {
      case 'Plastics':
        items = PlasticsItems;
        break;
      default:
        items = [];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(item.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Price per kg: \$${item.price}'),
                          SizedBox(width: 20),
                          Text('Total: \$${item.price * quantity}'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Quantity: '),
                          SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              });
                            },
                          ),
                          Text('$quantity'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    item.imageUrl,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
