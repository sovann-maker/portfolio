import 'package:flutter/material.dart';
import 'package:my_portfolio/utils/project_utils.dart';

import '../constants/colors.dart';
import 'animated_section.dart';
import 'modern_project_card.dart';

class ModernProjectsSection extends StatefulWidget {
  const ModernProjectsSection({super.key});

  @override
  State<ModernProjectsSection> createState() => _ModernProjectsSectionState();
}

class _ModernProjectsSectionState extends State<ModernProjectsSection>
    with SingleTickerProviderStateMixin {
  String selectedFilter = 'All';
  late AnimationController _animationController;

  final List<String> projectCategories = [
    'All',
    'Mobile',
    'Web',
    'Full-Stack',
    'API'
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<ProjectUtils> getFilteredProjects() {
    if (selectedFilter == 'All') {
      return workProjectUtils;
    }
    
    return workProjectUtils.where((project) {
      switch (selectedFilter) {
        case 'Mobile':
          return project.title.toLowerCase().contains('app') ||
                 project.subtitle.toLowerCase().contains('flutter');
        case 'Web':
          return project.title.toLowerCase().contains('site') ||
                 project.subtitle.toLowerCase().contains('angular') ||
                 project.subtitle.toLowerCase().contains('web');
        case 'Full-Stack':
          return project.subtitle.toLowerCase().contains('ecommerce') ||
                 project.subtitle.toLowerCase().contains('full') ||
                 project.title.toLowerCase().contains('site') ||
                 project.subtitle.toLowerCase().contains('angular') ||
                 project.subtitle.toLowerCase().contains('web');
        case 'API':
          return project.subtitle.toLowerCase().contains('api') ||
                 project.subtitle.toLowerCase().contains('rest');
        default:
          return true;
      }
    }).toList();
  }

  Map<String, String> getTechStack(ProjectUtils project) {
    // Extract tech stack from project subtitle/title
    Map<String, String> techStack = {};
    
    final subtitle = project.subtitle.toLowerCase();
    
    if (subtitle.contains('flutter')) techStack['Flutter'] = 'Mobile';
    if (subtitle.contains('firebase')) techStack['Firebase'] = 'Backend';
    if (subtitle.contains('stripe')) techStack['Stripe'] = 'Payment';
    if (subtitle.contains('bloc')) techStack['BLoC'] = 'State Mgmt';
    if (subtitle.contains('angular')) techStack['Angular'] = 'Frontend';
    if (subtitle.contains('rest api')) techStack['REST API'] = 'Backend';
    if (subtitle.contains('hive')) techStack['Hive'] = 'Database';
    if (subtitle.contains('news api')) techStack['News API'] = 'API';
    
    return techStack;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1200;
    final filteredProjects = getFilteredProjects();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          // Filter tabs
          AnimatedSection(
            delay: const Duration(milliseconds: 200),
            child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: projectCategories.map((category) {
                    final isSelected = selectedFilter == category;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = category;
                        });
                        _animationController.reset();
                        _animationController.forward();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? CustomColor.primaryGradient
                              : null,
                          color: isSelected
                              ? null
                              : CustomColor.surfaceColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: isSelected
                                ? CustomColor.cyanAccent.withOpacity(0.5)
                                : CustomColor.borderColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected
                                ? CustomColor.textPrimary
                                : CustomColor.textSecondary,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          // Projects count
          AnimatedSection(
            delay: const Duration(milliseconds: 300),
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontFamily: 'monospace',
                  ),
                  children: [
                    const TextSpan(
                      text: '// Found ',
                      style: TextStyle(color: CustomColor.textMuted),
                    ),
                    TextSpan(
                      text: '${filteredProjects.length}',
                      style: const TextStyle(color: CustomColor.cyanAccent),
                    ),
                    const TextSpan(
                      text: ' projects',
                      style: TextStyle(color: CustomColor.textMuted),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Projects grid
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return AnimatedOpacity(
                opacity: _animationController.value,
                duration: const Duration(milliseconds: 300),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = isDesktop ? 3 : 
                          (constraints.maxWidth > 800 ? 2 : 1);
                      
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: isDesktop ? 0.85 : 0.9,
                        ),
                        itemCount: filteredProjects.length,
                        itemBuilder: (context, index) {
                          final project = filteredProjects[index];
                          final techStack = getTechStack(project);
                          
                          return AnimatedSection(
                            delay: Duration(milliseconds: 100 * index),
                            child: ModernProjectCard(
                              project: project,
                              techStack: techStack,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),

          // View all projects button
          const SizedBox(height: 60),
          AnimatedSection(
            delay: const Duration(milliseconds: 600),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    CustomColor.cyanAccent.withOpacity(0.1),
                    CustomColor.surfaceColor.withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: CustomColor.cyanAccent.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.code,
                    color: CustomColor.cyanAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'View all projects on GitHub',
                    style: TextStyle(
                      color: CustomColor.cyanAccent,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_outward,
                    color: CustomColor.cyanAccent,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}