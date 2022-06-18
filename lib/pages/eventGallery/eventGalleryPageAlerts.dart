import 'package:flutter/material.dart';

class ViewImageOrVideoAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: contentBox(context, size),
    );
  }

  contentBox(context, size) {
    return Container(
        height: 270,
        width: size.width,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ProgressBar();
                          });
                    },
                    child: Container(
                      height: 215,
                      width: size.width,
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset("assets/imgs/show.png")),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 55,
              width: size.width,
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 19,
                      backgroundColor: Colors.transparent,
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset("assets/imgs/userProfile.png")),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Manuel",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "username",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white70,
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "1.5K",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

//  SECOND ALERT

class PlayVideoAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: contentBox(context, size),
    );
  }

  contentBox(context, size) {
    return Container(
        height: 270,
        width: size.width,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 215,
                width: size.width,
                child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset("assets/imgs/show.png")),
              ),
            ),
            Container(
                height: 2,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 1),
                    valueIndicatorColor: Colors.blue,
                    inactiveTrackColor: Color(0xFF8D8E98),
                    activeTrackColor: Colors.white,
                  ),
                  child: Slider(
                    value: 56,
                    min: 0,
                    max: 100,
                    onChanged: (val) {},
                  ),
                )),
            Container(
              height: 55,
              width: size.width,
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Row(
                  children: [
                    Text(
                      "17:34 / 59:32",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    Spacer(),
                    Icon(
                      Icons.volume_up_rounded,
                      size: 25,
                      color: Colors.white70,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.grid_view,
                      size: 25,
                      color: Colors.white70,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class ProgressBar extends StatelessWidget {
  double progress;
  ProgressBar({this.progress=0.0});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: contentBox(context, size),
    );
  }

  contentBox(context, size) {
    return Container(
        height: 50,
        width: size.width,
        color: Colors.white,
        child: LinearProgressIndicator(minHeight: 10,value:progress));
  }
}

