import 'package:flutter/material.dart';

class AdminData {
  final String name;
  final String email;

  AdminData({required this.name, required this.email});
}

class DataAdminPage extends StatelessWidget {
  final List<AdminData> adminList = [
    AdminData(name: 'John Doe', email: 'john.doe@example.com'),
    AdminData(name: 'Jane Smith', email: 'jane.smith@example.com'),
    // Tambahkan data admin lainnya di sini sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Admin'),
      ),
      body: ListView.builder(
        itemCount: adminList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(adminList[index].name),
            subtitle: Text(adminList[index].email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Tambahkan logika untuk mengedit admin
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Edit Admin'),
                          content: Text('Anda dapat mengedit admin di sini.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Tutup'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Tambahkan logika untuk menghapus admin
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Hapus Admin'),
                          content: Text('Anda yakin ingin menghapus admin ini?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Tambahkan logika untuk menghapus admin
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Hapus',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DataAdminPage(),
  ));
}
