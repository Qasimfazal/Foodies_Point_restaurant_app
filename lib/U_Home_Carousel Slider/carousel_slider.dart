import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://www.parhlo.com/wp-content/uploads/2014/12/IMG_3034.jpg.webp',
  'https://media-cdn.tripadvisor.com/media/photo-s/16/c2/95/f6/welcome-to-bnb-our-restaurant.jpg',
  'https://media-cdn.tripadvisor.com/media/photo-s/10/52/35/c4/bukhara-restaurnat.jpg',
  'https://media-cdn.tripadvisor.com/media/photo-s/11/11/1b/a1/amrit-taste-of-indian.jpg',
  'https://b.zmtcdn.com/data/reviews_photos/dc9/65761c9d2ec181efe53b09d0b44bbdc9_1554125460.JPG',
  'https://www.brandadvokates.com/wp-content/uploads/2018/05/restaurant-business-in-pakistan.jpg'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: Stack(
          children: <Widget>[
            FadeInImage(
              placeholder: AssetImage('images/image_large.png'),
              image: NetworkImage(item, ),
              height: 180.0,
              width: 1000.0,
              fit: BoxFit.cover,
            ),
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 0.0, horizontal: 20.0),
                child: Container(

                ),
              ),
            ),
          ],
        )),
  ),
))
    .toList();


class Carousel_Slider extends StatefulWidget {
  const Carousel_Slider({Key? key}) : super(key: key);

  @override
  _Carousel_SliderState createState() => _Carousel_SliderState();
}

class _Carousel_SliderState extends State<Carousel_Slider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }
}
