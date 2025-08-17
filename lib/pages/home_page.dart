import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/sns_links.dart';
import 'package:my_portfolio/widgets/main_desktop.dart';
import 'package:my_portfolio/widgets/main_mobile.dart';
import 'package:my_portfolio/widgets/modern_projects_section.dart';
import 'package:my_portfolio/widgets/modern_skills_section.dart';
import '../utils/js_interop.dart';
import '../constants/size.dart';
import '../widgets/code_section_header.dart';
import '../widgets/background_pattern.dart';
import '../widgets/modern_contact_section.dart';

import '../widgets/drawer_mobile.dart';
import '../widgets/footer.dart';
import '../widgets/header_desktop.dart';
import '../widgets/header_mobile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: CustomColor.scaffoldBg,
        endDrawer: constraints.maxWidth >= kMinDesktopWidth
            ? null
            : DrawerMobile(onNavItemTap: (int navIndex) {
                scaffoldKey.currentState?.closeEndDrawer();
                scrollToSection(navIndex);
              }),
        body: AnimatedBackgroundPattern(
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
              SizedBox(key: navbarKeys.first),

              // MAIN
              if (constraints.maxWidth >= kMinDesktopWidth)
                HeaderDesktop(onNavMenuTap: (int navIndex) {
                  scrollToSection(navIndex);
                })
              else
                HeaderMobile(
                  onLogoTap: () {},
                  onMenuTap: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                ),

              // Enhanced main section with better spacing
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 100,
                ),
                child: constraints.maxWidth >= kMinDesktopWidth
                    ? MainDesktop(
                        onScrollToProjects: () => scrollToSection(2),
                      )
                    : const MainMobile(),
              ),

              // SKILLS
              Container(
                key: navbarKeys[1],
                width: screenWidth,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      CustomColor.surfaceColor.withOpacity(0.3),
                      CustomColor.bgLight1.withOpacity(0.5),
                      CustomColor.surfaceColor.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: CustomColor.borderColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Section header with code style
                    const AnimatedCodeHeader(
                      title: 'skills',
                      subtitle: 'Technologies and tools I work with',
                      delay: Duration(milliseconds: 100),
                    ),
                    const SizedBox(height: 60),

                    // Modern skills section
                    const ModernSkillsSection(),
                  ],
                ),
              ),
              const SizedBox(height: 60),

              const SizedBox(height: 100),
              
              // PROJECTS
              Container(
                key: navbarKeys[2],
                width: screenWidth,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: const Column(
                    children: [
                      AnimatedCodeHeader(
                        title: 'projects',
                        subtitle: 'Some of my recent work',
                        delay: Duration(milliseconds: 200),
                      ),
                      SizedBox(height: 60),
                      ModernProjectsSection(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 100),

              // CONTACT
              Container(
                key: navbarKeys[3],
                width: screenWidth,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      CustomColor.cyanAccent.withOpacity(0.05),
                      CustomColor.surfaceColor.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: CustomColor.cyanAccent.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: const Column(
                    children: [
                      AnimatedCodeHeader(
                        title: 'contact',
                        subtitle: 'Let\'s build something amazing together',
                        delay: Duration(milliseconds: 300),
                      ),
                      SizedBox(height: 60),
                      ModernContactSection(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // FOOTER
              const Footer(),
              ],
            ),
          ),
        ),
      );
    });
  }

  void scrollToSection(int navIndex) {
    if (navIndex == 4) {
      // open a blog page
      openUrlInNewTab(SnsLinks.github);
      return;
    }

    final key = navbarKeys[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
