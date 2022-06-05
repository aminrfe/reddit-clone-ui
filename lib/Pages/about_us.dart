import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/about-us.jpg'),
                  fit: BoxFit.cover)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Center(
              child: Card(
                elevation: 10,
                color: Colors.white.withOpacity(0.3),
                child: SizedBox(
                  width: 300,
                  height: 500,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Developed By',
                          style: GoogleFonts.libreBaskerville(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(' Erfan Abedi',
                                style: GoogleFonts.libreBaskerville(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                onPressed: () {
                                  _launchURL('https://github.com/Erfun-ABD');
                                },
                                icon: Image.asset(
                                    'assets/images/github-logo.png',
                                    height: 50))
                          ]),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(' Amin Rafiee',
                                style: GoogleFonts.libreBaskerville(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                onPressed: () {
                                  _launchURL('https://github.com/aminrfe');
                                },
                                icon: Image.asset(
                                    'assets/images/github-logo.png',
                                    height: 50))
                          ]),
                      const SizedBox(
                        height: 160,
                      ),
                      Text('AP Spring 1401',
                          style: GoogleFonts.libreBaskerville(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      const SizedBox(
                        height: 30,
                      ),
                      Text('Shahid Beheshti University',
                          style: GoogleFonts.libreBaskerville(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
