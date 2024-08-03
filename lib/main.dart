import 'package:flutter/material.dart';
import 'api_service.dart';
import 'item_model.dart';
import 'item_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService apiService = ApiService();
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      print('Fetching items...'); // Debug print
      final fetchedItems = await apiService.getItems();
      setState(() {
        items = fetchedItems;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addItem(Item item) async {
    try {
      await apiService.createItem(item);
      fetchItems();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateItem(Item item) async {
    try {
      await apiService.updateItem(item);
      fetchItems();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await apiService.deleteItem(id);
      fetchItems();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter CRUD App'),
      ),
      body: items.isEmpty
          ? Center(child: CircularProgressIndicator()) // Mostrar un indicador de progreso mientras se cargan los datos
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.marca),
            subtitle: Text('${item.modelo} - ${item.tipo}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteItem(item.id),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemForm(
                  item: item,
                  onSave: updateItem,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemForm(
              onSave: addItem,
            ),
          ),
        ),
      ),
    );
  }
}
