import 'package:custom_painter/src/routes/routes.dart';
import 'package:custom_painter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LauncherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Designs')),
      drawer: _MainMenu(),
      body: _OptionsList(),
    );
  }
}

class _OptionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, i) => Divider(
        color: appTheme.primaryColorLight,
      ),
      itemCount: pageRoutes.length,
      itemBuilder: (context, index) => ListTile(
        leading: FaIcon(
          pageRoutes[index].icon,
          color: appTheme.accentColor,
        ),
        title: Text(pageRoutes[index].title),
        trailing: Icon(Icons.chevron_right, color: appTheme.accentColor),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pageRoutes[index].page,
              ));
        },
      ),
    );
  }
}

class _MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final accentColor = appTheme.currentTheme.accentColor;

    return SafeArea(
      child: Drawer(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 200,
                child: CircleAvatar(
                  backgroundColor: accentColor,
                  child: Text(
                    'UA',
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
              Expanded(child: _OptionsList()),
              ListTile(
                leading: Icon(Icons.lightbulb_outline, color: accentColor),
                title: Text('Dark Mode'),
                trailing: Switch.adaptive(
                    value: appTheme.darkTheme,
                    activeColor: accentColor,
                    onChanged: (value) => appTheme.darkTheme = value),
              ),
              ListTile(
                leading: Icon(Icons.add_to_home_screen, color: accentColor),
                title: Text('Custom Mode'),
                trailing: Switch.adaptive(
                    value: appTheme.customTheme,
                    activeColor: accentColor,
                    onChanged: (value) => appTheme.customTheme = value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
