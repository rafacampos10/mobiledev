import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobiledev/pages/PageView/chat.dart';
import 'package:mobiledev/pages/PageView/cursos_page.dart';
import 'package:mobiledev/pages/PageView/one_page.dart';
import 'package:mobiledev/pages/perfil.dart';
import 'package:mobiledev/pages/splash_page.dart';
import 'package:mobiledev/services/auth_service.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();

  int indexBottomNavigationBar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0,76,63,1),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 130, top: 5),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                      "images/aplicativo.png",
                      height: 40,
                      width: 35),
                ],
              ),
            ),
          ),
          IconButton(
            tooltip: "Sair",
            onPressed: () {
              context.read<AuthService>().logout();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplashPage()));
            },
            icon: Icon(Icons.logout,color: Colors.white),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: PageView(
        controller: _pageController,
        children: [
          OnePage(),
          Chat(),
          CursosPage(),
          perfilPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Color.fromRGBO(0,76,63,1),
        type: BottomNavigationBarType.fixed, //quantidade que quiser no bottom
        currentIndex: indexBottomNavigationBar,
        backgroundColor: Colors.white,
        onTap: (int page) {
          //clica no botão
          setState(() {
            //alterar o botão no Stateful que sofre mudança
            indexBottomNavigationBar = page;
          });
          _pageController.animateToPage(
            page,
            duration: Duration(microseconds: 1), //duraçao da animação
            curve: Curves.ease,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.string("""<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
  <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z" />
</svg>""", color: Color.fromRGBO(0,76,63,1),height: 24, width: 24),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string("""<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
  <path fill-rule="evenodd" d="M18 10c0 3.866-3.582 7-8 7a8.841 8.841 0 01-4.083-.98L2 17l1.338-3.123C2.493 12.767 2 11.434 2 10c0-3.866 3.582-7 8-7s8 3.134 8 7zM7 9H5v2h2V9zm8 0h-2v2h2V9zM9 9h2v2H9V9z" clip-rule="evenodd" />
</svg>""", color: Color.fromRGBO(0,76,63,1),height: 24, width: 24),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string("""<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
  <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z" />
</svg>""", color: Color.fromRGBO(0,76,63,1),height: 24, width: 24),
            label: "Projetos",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string("""<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
  <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
</svg>""", color: Color.fromRGBO(0,76,63,1),height: 24, width: 24),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
