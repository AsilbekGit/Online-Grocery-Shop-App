class MyApp extends StatelessWidget {
  // ... (previous code)

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Grocery Shop',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: checkFirstSeen('intro'),  // Pass 'intro' for IntroScreen
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error
            return Center(
              child: Text('Error occurred!'),
            );
          } else {
            // If the user is signed in, show the main page
            // Otherwise, show the appropriate screen based on whether the user has seen the app before
            if (snapshot.data ?? false) {
              return HomePage();  // User is signed in
            } else {
              return IntroScreen();  // User is not signed in and IntroScreen is shown
            }
          }
        },
      ),
    );
  }

  Future<bool> checkFirstSeen(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen_$page') ?? false);

    if (_seen) {
      return false;
    } else {
      await prefs.setBool('seen_$page', true);
      return true;
    }
  }
}
