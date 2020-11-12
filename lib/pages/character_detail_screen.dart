import 'package:after_layout/after_layout.dart';
import 'package:despicableme/models/character.dart';
import 'package:despicableme/styleguide.dart';
import 'package:flutter/material.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;
  final double _expandedBottomSheetBottomPosition = 0;
  final double _collapseBottomSheetBottomPosition = -250;
  final double _completeCollapsedBottomSheetBottomPosition = -330;

  const CharacterDetailScreen({Key key, this.character}) : super(key: key);

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen>  with AfterLayoutMixin<CharacterDetailScreen>{

  double _bottomSheetBottomPosition = -330;
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: 'background-${widget.character.name}',
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.character.colors,
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                  child: IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 40.0,
                      color: Colors.white.withOpacity(0.9),
                      onPressed: () {
                        setState(() {
                          _bottomSheetBottomPosition = widget._completeCollapsedBottomSheetBottomPosition;
                        });
                        Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Hero(
                      tag: "image-${widget.character.name}",
                      child: Image.asset(widget.character.imagePath, height: screenHeight * 0.45)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                  child: Hero(
                      tag: "name-${widget.character.name}",
                      child: Material(
                          color: Colors.transparent,
                          child: Container(child: Text(widget.character.name, style: AppTheme.heading)))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 8, 32),
                  child: Text(widget.character.description, style: AppTheme.subHeading),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            bottom: _bottomSheetBottomPosition,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: _onTap,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      height: 80,
                      child: Text(
                        'Clips',
                        style: AppTheme.subHeading.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _clipsWidget(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _clipsWidget(){
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Image(image: AssetImage('assets/images/minion_1.jpg'), width: 83,),
              SizedBox(height: 20),
              Image(image: AssetImage('assets/images/minion_2.jpg'), width: 83,),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              Image(image: AssetImage('assets/images/minion_3.jpg'), width: 60,),
              SizedBox(height: 20),
              Image(image: AssetImage('assets/images/minion_4.jpg'), width: 70,),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              Image(image: AssetImage('assets/images/minion_5.jpg'), width: 65,),
              SizedBox(height: 20),
              Image(image: AssetImage('assets/images/minion_6.jpg'), width: 83,),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              Image(image: AssetImage('assets/images/minion_7.jpg'), width: 85,),
              SizedBox(height: 20),
              Image(image: AssetImage('assets/images/minion_8.jpg'), width: 83,),
            ],
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget roundedContainer(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }

  _onTap () {
    setState(() {
      _bottomSheetBottomPosition = isCollapsed
          ? widget._expandedBottomSheetBottomPosition
          : widget._collapseBottomSheetBottomPosition;
      isCollapsed = !isCollapsed;
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isCollapsed = true;
        _bottomSheetBottomPosition = widget._collapseBottomSheetBottomPosition;
      });
    });
  }
}