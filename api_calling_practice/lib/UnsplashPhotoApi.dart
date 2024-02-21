import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class UnsplashApiCall extends StatefulWidget {
  const UnsplashApiCall({super.key});

  @override
  State<UnsplashApiCall> createState() => _UnsplashApiCallState();
}

class _UnsplashApiCallState extends State<UnsplashApiCall> {
  var urldata;
  var page_number = 1;

  Future getApidata() async {
    var url = await Uri.parse("https://api.unsplash.com/photos/?per_page=30");
    var data = await http.get(url, headers: {
      'Autorization': "Up2lW2mW8x9Ixivl4PQiQiwjWjsAr2210EnDGOZ1Yvg"
    });
    setState(() {
      urldata = jsonDecode(data.body);
      print(urldata);
    });
  }

  loadmore() async {
    setState(() {
      page_number = page_number++;
    });
    String url1 = "https://api.unsplash.com/photos/?per_page=30&page=" +
        page_number.toString();
    var url = await Uri.parse(url1);
    var data = await http.get(url, headers: {
      'Autorization': "Up2lW2mW8x9Ixivl4PQiQiwjWjsAr2210EnDGOZ1Yvg"
    });
    setState(() {
      urldata = jsonDecode(data.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApidata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text(
          'Unsplash Api Calling',
          Colors.white,
          25.0,
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          loadmore();
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.black,
          height: 50,
          width: 20,
          child: text(
            'Load more',
            Colors.white,
            25.0,
          ),
        ),
      ),
      body: urldata == null
          ? CircularProgressIndicator()
          : ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FullPage(
                                data: urldata[index],
                              ))),
                  child: ListTile(
                    trailing:
                        text(index + 1, Colors.black, 6.0),
                    leading: CircleAvatar(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                '${urldata[index]['urls']['regular']}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text('Id :- ${urldata[index]['id']}', Colors.deepOrange,
                            20.0),
                        text(
                            'Description :- ${urldata[index]['alt_description']}',
                            Colors.black,
                            15.0),
                        text('Likes :- ${urldata[index]['likes']}',
                            Colors.green, 20.0),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(thickness: 3),
              itemCount: page_number*30,
            ),
    );
  }
}

class FullPage extends StatefulWidget {
  final data;

  FullPage({required this.data});

  @override
  State<FullPage> createState() => _FullPageState();
}

class _FullPageState extends State<FullPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text(
          'Full Page',
          Colors.black,
          30.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              '${widget.data['urls']['regular']}',
              height: 600,
              width: 600,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            text('Id :- ${widget.data['id']}', Colors.deepOrange, 20.0,),
            SizedBox(height: 10),
            text('Description :- ${widget.data['alt_description']}',
                Colors.black, 20.0),
            SizedBox(height: 10),
            text('Likes :- ${widget.data['likes']}', Colors.green, 20.0,),
            SizedBox(height: 10),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setWallpaper(WallpaperManager.HOME_SCREEN);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: text(
                      'Set as Wallpaper',
                      Colors.red,
                      25.0,
                      FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )*/
          ],
        ),
      ),
    );
  }

  /*setWallpaper(location) {
    try {
      WallpaperManager.setWallpaperFromFile(
          DefaultCacheManager()
              .getSingleFile('${widget.data['urls']['regular']}') as String,
          location);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: text(
            'Wallpaper Updated',
            Colors.green,
            15.0,
            FontWeight.normal,
          ),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: text(
            'Error Occured',
            Colors.red,
            15.0,
            FontWeight.normal,
          ),
        ),
      );
    }
  }*/
}

/*

List abc = [
  {
    "id": "lsdA8QpWN_A",
    "slug": "lsdA8QpWN_A",
    "created_at": "2022-08-31T14:36:55Z",
    "updated_at": "2023-07-14T23:41:15Z",
    "promoted_at": null,
    "width": 7294,
    "height": 4863,
    "color": "#d9d9d9",
    "blur_hash": "LUK-wd.TbtH@%39atQsA-;xuo~xa",
    "description": null,
    "alt_description": "a coffee cup and a pen on a desk",
    "breadcrumbs": [],
    "urls": {
      "raw":
          "https://images.unsplash.com/photo-1661956602868-6ae368943878?ixid=M3w0NzQzNjh8MXwxfGFsbHwxfHx8fHx8Mnx8MTY4OTQwMzgxNXw&ixlib=rb-4.0.3",
      "full":
          "https://images.unsplash.com/photo-1661956602868-6ae368943878?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NzQzNjh8MXwxfGFsbHwxfHx8fHx8Mnx8MTY4OTQwMzgxNXw&ixlib=rb-4.0.3&q=85",
      "regular":
          "https://images.unsplash.com/photo-1661956602868-6ae368943878?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NzQzNjh8MXwxfGFsbHwxfHx8fHx8Mnx8MTY4OTQwMzgxNXw&ixlib=rb-4.0.3&q=80&w=1080",
      "small":
          "https://images.unsplash.com/photo-1661956602868-6ae368943878?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NzQzNjh8MXwxfGFsbHwxfHx8fHx8Mnx8MTY4OTQwMzgxNXw&ixlib=rb-4.0.3&q=80&w=400",
      "thumb":
          "https://images.unsplash.com/photo-1661956602868-6ae368943878?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NzQzNjh8MXwxfGFsbHwxfHx8fHx8Mnx8MTY4OTQwMzgxNXw&ixlib=rb-4.0.3&q=80&w=200",
      "small_s3":
          "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1661956602868-6ae368943878"
    },
    "links": {
      "self": "https://api.unsplash.com/photos/lsdA8QpWN_A",
      "html": "https://unsplash.com/photos/lsdA8QpWN_A",
      "download":
          "https://unsplash.com/photos/lsdA8QpWN_A/download?ixid=M3w0NzQzNjh8MXwxfGFsbHwxfHx8fHx8Mnx8MTY4OTQwMzgxNXw",
      "download_location":
          "https://api.unsplash.com/photos/lsdA8QpWN_A/download?ixid=M3w0NzQzNjh8MXwxfGFsbHwxfHx8fHx8Mnx8MTY4OTQwMzgxNXw"
    },
    "likes": 717,
    "liked_by_user": false,
    "current_user_collections": [],
    "sponsorship": {
      "impression_urls": [
        "https://ad.doubleclick.net/ddm/trackimp/N1224323.3286893UNSPLASH/B29258209.358659708;dc_trk_aid=549462680;dc_trk_cid=186410004;ord=[timestamp];dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;tfua=;ltd=?",
        "https://pixel.adsafeprotected.com/rfw/st/1337634/69218800/skeleton.gif?gdpr=${GDPR}&gdpr_consent=${GDPR_CONSENT_278}&gdpr_pd=${GDPR_PD}",
        "https://track.activemetering.com/pixel/v1/all/pixel.gif?cid=7f5782fa-df57-4e4a-85a4-20fd455ad1ed&creativeId=186410004&placementId=358659708",
        "https://secure.insightexpressai.com/adServer/adServerESI.aspx?script=false&bannerID=11344880&rnd=[timestamp]&redir=https://secure.insightexpressai.com/adserver/1pixel.gif"
      ],
      "tagline": "Get the advanced tools you need to grow",
      "tagline_url":
          "https://ad.doubleclick.net/ddm/trackclk/N1224323.3286893UNSPLASH/B29258209.358659708;dc_trk_aid=549462680;dc_trk_cid=186410004;dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;tfua=;ltd=",
      "sponsor": {
        "id": "D-bxv1Imc-o",
        "updated_at": "2023-07-06T02:18:20Z",
        "username": "mailchimp",
        "name": "Mailchimp",
        "first_name": "Mailchimp",
        "last_name": null,
        "twitter_username": "Mailchimp",
        "portfolio_url": "https://mailchimp.com/",
        "bio":
            "The all-in-one Marketing Platform built for growing businesses.",
        "location": null,
        "links": {
          "self": "https://api.unsplash.com/users/mailchimp",
          "html": "https://unsplash.com/@mailchimp",
          "photos": "https://api.unsplash.com/users/mailchimp/photos",
          "likes": "https://api.unsplash.com/users/mailchimp/likes",
          "portfolio": "https://api.unsplash.com/users/mailchimp/portfolio",
          "following": "https://api.unsplash.com/users/mailchimp/following",
          "followers": "https://api.unsplash.com/users/mailchimp/followers"
        },
        "profile_image": {
          "small":
              "https://images.unsplash.com/profile-1609545740442-928866556c38image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32",
          "medium":
              "https://images.unsplash.com/profile-1609545740442-928866556c38image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=64&h=64",
          "large":
              "https://images.unsplash.com/profile-1609545740442-928866556c38image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
        },
        "instagram_username": "mailchimp",
        "total_collections": 0,
        "total_likes": 19,
        "total_photos": 13,
        "accepted_tos": true,
        "for_hire": false,
        "social": {
          "instagram_username": "mailchimp",
          "portfolio_url": "https://mailchimp.com/",
          "twitter_username": "Mailchimp",
          "paypal_email": null
        }
      }
    },
    "topic_submissions": {},
    "user": {
      "id": "D-bxv1Imc-o",
      "updated_at": "2023-07-06T02:18:20Z",
      "username": "mailchimp",
      "name": "Mailchimp",
      "first_name": "Mailchimp",
      "last_name": null,
      "twitter_username": "Mailchimp",
      "portfolio_url": "https://mailchimp.com/",
      "bio": "The all-in-one Marketing Platform built for growing businesses.",
      "location": null,
      "links": {
        "self": "https://api.unsplash.com/users/mailchimp",
        "html": "https://unsplash.com/@mailchimp",
        "photos": "https://api.unsplash.com/users/mailchimp/photos",
        "likes": "https://api.unsplash.com/users/mailchimp/likes",
        "portfolio": "https://api.unsplash.com/users/mailchimp/portfolio",
        "following": "https://api.unsplash.com/users/mailchimp/following",
        "followers": "https://api.unsplash.com/users/mailchimp/followers"
      },
      "profile_image": {
        "small":
            "https://images.unsplash.com/profile-1609545740442-928866556c38image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32",
        "medium":
            "https://images.unsplash.com/profile-1609545740442-928866556c38image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=64&h=64",
        "large":
            "https://images.unsplash.com/profile-1609545740442-928866556c38image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
      },
      "instagram_username": "mailchimp",
      "total_collections": 0,
      "total_likes": 19,
      "total_photos": 13,
      "accepted_tos": true,
      "for_hire": false,
      "social": {
        "instagram_username": "mailchimp",
        "portfolio_url": "https://mailchimp.com/",
        "twitter_username": "Mailchimp",
        "paypal_email": null
      }
    }
  },
];
*/
