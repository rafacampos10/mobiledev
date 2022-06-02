import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobiledev/pages/PageView/chat.dart';
import 'package:mobiledev/pages/PageView/cursos_page.dart';
import 'package:mobiledev/pages/PageView/notification.dart';
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
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 130, top: 5),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                      "images/aplicativo.png",
                      color: Colors.blue.shade900,
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
            icon: Icon(Icons.logout,color: Colors.blue.shade900),
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
          Notificacao(),
          perfilPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue.shade900,
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
</svg>""", color: Colors.blue.shade900,height: 24, width: 24),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string("""<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
  <path fill-rule="evenodd" d="M18 10c0 3.866-3.582 7-8 7a8.841 8.841 0 01-4.083-.98L2 17l1.338-3.123C2.493 12.767 2 11.434 2 10c0-3.866 3.582-7 8-7s8 3.134 8 7zM7 9H5v2h2V9zm8 0h-2v2h2V9zM9 9h2v2H9V9z" clip-rule="evenodd" />
</svg>""", color: Colors.blue.shade900,height: 24, width: 24),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string("""<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
  <path d="M10.394 2.08a1 1 0 00-.788 0l-7 3a1 1 0 000 1.84L5.25 8.051a.999.999 0 01.356-.257l4-1.714a1 1 0 11.788 1.838L7.667 9.088l1.94.831a1 1 0 00.787 0l7-3a1 1 0 000-1.838l-7-3zM3.31 9.397L5 10.12v4.102a8.969 8.969 0 00-1.05-.174 1 1 0 01-.89-.89 11.115 11.115 0 01.25-3.762zM9.3 16.573A9.026 9.026 0 007 14.935v-3.957l1.818.78a3 3 0 002.364 0l5.508-2.361a11.026 11.026 0 01.25 3.762 1 1 0 01-.89.89 8.968 8.968 0 00-5.35 2.524 1 1 0 01-1.4 0zM6 18a1 1 0 001-1v-2.065a8.935 8.935 0 00-2-.712V17a1 1 0 001 1z" />
</svg>""", color: Colors.blue.shade900,height: 24, width: 24),
            label: "Cursos",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string("""<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
  <path d="M10 2a6 6 0 00-6 6v3.586l-.707.707A1 1 0 004 14h12a1 1 0 00.707-1.707L16 11.586V8a6 6 0 00-6-6zM10 18a3 3 0 01-3-3h6a3 3 0 01-3 3z" />
</svg>""", color: Colors.blue.shade900,height: 24, width: 24),
            label: "Alertas",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string("""<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
  <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
</svg>""", color: Colors.blue.shade900,height: 24, width: 24),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
