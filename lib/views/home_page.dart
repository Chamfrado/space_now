import 'package:space_now/components/card_astronaut.dart';
import 'package:space_now/controller/access_controller.dart';
import 'package:space_now/controller/astronault_controller.dart';
import 'package:space_now/models/astronault.dart';
import 'package:space_now/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Astronault>> _astronauts;

  @override
  void initState() {
    super.initState();
    _astronauts = AstronaultController.instance.getAstronaultList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        leading: GFIconButton(
          icon: const Icon(
            Icons.rocket,
            color: Colors.white,
          ),
          onPressed: () {},
          type: GFButtonType.transparent,
        ),
        title: Text("Space Now"),
        backgroundColor: GFColors.DARK,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Sair',
                child: const Text('Sair'),
                onTap: () async {
                  final navigator = Navigator.of(context);
                  bool logout = await AccessController.instance.logout();
                  if (logout) {
                    navigator.pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const WelcomePage(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<Astronault>>(
        future: _astronauts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                GFListTile(
                    titleText: 'Lista de Humanos no espaço!',
                    subTitleText:
                        'Numero de pessoas no espaço: ${snapshot.data?.length} '),
                Expanded(
                  child: GridView.builder(
                    padding:
                        EdgeInsets.zero, // Remove padding around the GridView
                    shrinkWrap: true, // Take only the space it needs
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return card_astronaut(
                          name: snapshot.data![index].name,
                          aircraft: snapshot.data![index].craft);
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                Text('Carregando produtos'),
              ],
            ),
          );
        },
      ),
    );
  }
}
