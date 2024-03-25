import 'package:flutter/material.dart';

class KunjunganScreen extends StatefulWidget {
  const KunjunganScreen({Key? key}) : super(key: key);

  @override
  State<KunjunganScreen> createState() => _KunjunganScreenState();
}

class _KunjunganScreenState extends State<KunjunganScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol kembali
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Daftar Kunjungan",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    color: Color(0xffbdbdbd), // Custom color
                    onPressed: () {
                      // Action when search button is pressed
                    },
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari nama',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 23),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue, // Custom color
            tabs: const [
              Tab(
                text: "Permintaan",
              ),
              Tab(
                text: "Diterima",
              ),
              Tab(
                text: "Ditolak",
              ),
              Tab(
                text: "Riwayat",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: 5, // Jumlah item yang ingin ditampilkan
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rahma Bersin",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Lampung",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Action when "Selengkapnya" button is pressed
                                    },
                                    child: Text(
                                      "Selengkapnya >>",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 8),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // Action when "Diterima" button is pressed
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6), // Padding
                                        ),
                                        child: Text(
                                          "Diterima",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Action when "Ditolak" button is pressed
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6), // Padding
                                        ),
                                        child: Text(
                                          "Ditolak",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
