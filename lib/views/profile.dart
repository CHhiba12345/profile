import 'package:flutter/material.dart';
import '../controller.dart';

class ProfilePage extends StatefulWidget {
  final UserController userController;

  ProfilePage({Key? key, required this.userController}) : super(key: key) {

  }

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showInfo = true; // contrôler la visibilité des informations du profil.
  ScrollController scrollController = ScrollController();
  //contrôler le défilement de la liste d'informations du profil.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white10,
        elevation: 0,
        title: const Text(
          'Profil',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/second_page_background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/profile.jpeg'),
                ),
              ),
            ),
            Expanded(
              // occuper l'espace disponible.
              child: SingleChildScrollView(
                //permettre le défilement si nécessaire.
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if (showInfo) buildInfoListView(),
                      // construire une ListView pour afficher les informations personnelles.
                    ],
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,//détermine la vitesse à laquelle l'animation s'effectue.
              alignment: showInfo ? Alignment.bottomCenter : Alignment.topCenter,
              height: showInfo ? 50 : 450,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showInfo = !showInfo;
                    if (showInfo) {
                      // Scroll to the bottom when information is displayed
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        //l'animation commencera rapidement et ralentira progressivement à la fin.
                      );
                    } else {
                      // Scroll to the top when information is hidden
                      scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  });
                },
                child: Text(showInfo ? 'Masquer' : 'Afficher'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoListView() {
    return ListView.builder(
      shrinkWrap: true,
      //optimiser l'espace et améliorer l'apparence de certains ScrollViews
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.userController.list.length,
      itemBuilder: (context, index) {
        //fonction qui sera appelée pour construire chaque élément de la liste
        return buildInfoTile(
            title: widget.userController.list[index].title,
            content: widget.userController.list[index].content,
        );
      },
    );
  }

  Widget buildInfoTile({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(content),
        //Text(content.join('\n')),
        const SizedBox(height: 20),
      ],
    );
  }
}
