import 'package:flutter/material.dart';

class GridTwo extends StatefulWidget {
  @override
  _GridTwoState createState() => _GridTwoState();
}

class _GridTwoState extends State<GridTwo> {
  final piclinks = [
    'https://live.staticflickr.com/7500/15532817839_5a448732bd_b.jpg',
    'https://live.staticflickr.com/2909/33293655780_7c8b784ca7_b.jpg',
    'https://i.pinimg.com/originals/35/fc/4b/35fc4b9ce62164fcded3200cfa462bda.jpg',
    'https://bangladeshtourismguide.com/wp-content/uploads/2017/08/DONG-810x495.jpg',
    'https://live.staticflickr.com/7236/7356748408_68ec0b38a1_b.jpg',
    'http://bangladeshtourismguide.com/wp-content/uploads/2017/09/2-1.jpg',
    'https://i.pinimg.com/originals/2f/84/86/2f8486200b8b9ea1362c5bbbea910570.jpg',
    'https://i.pinimg.com/736x/90/48/39/904839b12712d9c4f5f56ce7f265f4b0.jpg',
  ];

  final names = [
    'Keokradong',
    'Tajingdong',
    'Safafang',
    'Chimbuk hill',
    'Dumlong',
    'Maraingtong',
    'Hanglang',
    'Panglong',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(8, (index) {
          return Card(
            elevation: 10.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  piclinks[index],
                  height: 140,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 3.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    names[index],
                    style: TextStyle(fontSize: 15, color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
