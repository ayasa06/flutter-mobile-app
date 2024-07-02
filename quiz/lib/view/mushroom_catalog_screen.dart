import 'package:flutter/material.dart';

class MushroomCatalogScreen extends StatelessWidget {
  final List<Map<String, String>> mushrooms = [
    {'name': 'アイシメジ', 'image': 'assets/mushrooms/aisimezi.jpg'},
    {'name': 'アカハツ', 'image': 'assets/mushrooms/akahatu.jpg', 'toxic': 'assets/skull.png'},
    {'name': 'アカチシオタケ', 'image': 'assets/mushrooms/akashitiotake.jpg'},
    {'name': 'アカモミタケタケ', 'image': 'assets/mushrooms/akamomitake.jpg'},
    {'name': 'アミガサタケ', 'image': 'assets/mushrooms/amigasatake.jpg'},
    {'name': 'アミタケ', 'image': 'assets/mushrooms/amitake.jpg'},
    {'name': 'アミハナイグチ', 'image': 'assets/mushrooms/amihanaiguchi.jpg'},
    {'name': 'アワタケ', 'image': 'assets/mushrooms/awatake.jpg'},
    // 他のキノコも同様に追加
  ];

  @override
  Widget build(BuildContext context) {
    // 名前の最初の文字でグループ分け
    Map<String, List<Map<String, String>>> groupedMushrooms = {};
    for (var mushroom in mushrooms) {
      String firstLetter = mushroom['name']![0];
      if (!groupedMushrooms.containsKey(firstLetter)) {
        groupedMushrooms[firstLetter] = [];
      }
      groupedMushrooms[firstLetter]!.add(mushroom);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('きのこ図鑑'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Image.asset('assets/left.png'), // 左矢印の画像
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Container(
                  padding: EdgeInsets.all(5.0), // Add padding to shrink the icon
                  child: Image.asset('assets/search.png', height: 20.0), // 虫眼鏡の画像を小さくする
                ),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: groupedMushrooms.keys.length,
              itemBuilder: (context, index) {
                String key = groupedMushrooms.keys.elementAt(index);
                List<Map<String, String>> group = groupedMushrooms[key]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        key,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...group.map((mushroom) {
                      return ListTile(
                        leading: Container(
                          width: 50, // 固定の横幅を設定
                          height: 50, // 固定の縦幅を設定
                          child: Image.asset(
                            mushroom['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(mushroom['name']!),
                        trailing: mushroom.containsKey('toxic') ? Image.asset(mushroom['toxic']!) : null,
                        onTap: () {
                          Navigator.pushNamed(context, '/mushroom_detail', arguments: mushroom);
                        },
                      );
                    }).toList(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 40.0,
        color: Colors.orange,
      ),
    );
  }
}
