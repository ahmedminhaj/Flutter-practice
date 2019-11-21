import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(4, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(5, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(2, 1),
];

List<Widget> _tiles = const <Widget>[
  const _ImageTile(
      'https://live.staticflickr.com/7500/15532817839_5a448732bd_b.jpg'),
  const _ImageTile(
      'https://live.staticflickr.com/2909/33293655780_7c8b784ca7_b.jpg'),
  const _ImageTile(
      'https://i.pinimg.com/originals/35/fc/4b/35fc4b9ce62164fcded3200cfa462bda.jpg'),
  const _ImageTile(
      'https://bangladeshtourismguide.com/wp-content/uploads/2017/08/DONG-810x495.jpg'),
  const _ImageTile(
      'https://live.staticflickr.com/7236/7356748408_68ec0b38a1_b.jpg'),
  const _ImageTile(
      'http://bangladeshtourismguide.com/wp-content/uploads/2017/09/2-1.jpg'),
  const _ImageTile(
      'https://i.pinimg.com/originals/2f/84/86/2f8486200b8b9ea1362c5bbbea910570.jpg'),
  const _ImageTile(
      'https://cdn.pixabay.com/photo/2019/03/07/21/32/bangladesh-4041183_960_720.jpg'),
  const _ImageTile(
      'https://www.kinderweltreise.de/fileadmin/_processed_/7/1/csm_berge-gras-bangladesch_4aa3837b93.jpg'),
  const _ImageTile(
      'https://kwerfeldein.de/wp-content/uploads/2016/01/Claas-Jaehne-27.jpg'),
  const _ImageTile(
      'https://res-4.cloudinary.com/enchanting/images/w_1600,h_700,c_fill/et-web/2015/05/destination-uganda-1/uganda-safarireise-8211-primaten-und-wilde-landschaften-urlaub-2.jpg'),
];

class CustomGrid extends StatefulWidget {
  @override
  _CustomGridState createState() => _CustomGridState();
}

class _CustomGridState extends State<CustomGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 1.0),
        child: new StaggeredGridView.count(
          crossAxisCount: 5,
          staggeredTiles: _staggeredTiles,
          children: _tiles,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          padding: const EdgeInsets.all(4.0),
        ),
      ),
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile(this.gridImage);

  final gridImage;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0x00000000),
      elevation: 5.0,
      child: GestureDetector(
        child: Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(gridImage),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(const Radius.circular(10.0)),
        )),
      ),
    );
  }
}
