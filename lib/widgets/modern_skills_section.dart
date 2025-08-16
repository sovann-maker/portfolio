import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/skill_items.dart';
import 'animated_section.dart';

class ModernSkillsSection extends StatefulWidget {
  const ModernSkillsSection({super.key});

  @override
  State<ModernSkillsSection> createState() => _ModernSkillsSectionState();
}

class _ModernSkillsSectionState extends State<ModernSkillsSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<AnimationController> _skillControllers;
  String selectedCategory = 'All';

  final Map<String, List<Map<String, dynamic>>> skillCategories = {
    'Languages': [
      {'name': 'Dart', 'level': 60, 'icon': 'assets/dart.png'},
      {'name': 'JavaScript', 'level': 80, 'icon': 'assets/javascript.png'},
      {'name': 'Python', 'level': 80, 'icon': 'assets/python.png'},
      {'name': 'HTML5', 'level': 80, 'icon': 'assets/html5.png'},
    ],
    'Frameworks': [
      {'name': 'Flutter', 'level': 60, 'icon': 'assets/flutter.png'},
      {'name': 'Angular', 'level': 80, 'icon': 'assets/angular.png'},
      {'name': 'Next.js', 'level': 80, 'icon': 'assets/nextjs.png'},
      {'name': 'Tailwind CSS', 'level': 80, 'icon': 'assets/tailwind.png'},
    ],
    'Tools': [
      {'name': 'Firebase', 'level': 80, 'icon': 'assets/firebase.png'},
      {'name': 'Stripe', 'level': 80, 'icon': 'assets/stripe.png'},
    ],
    'Platforms': platformItems.map((item) => {
      'name': item['title'] as String,
      'level': _getLevelForPlatform(item['title'] as String),
      'icon': item['img'] as String,
    }).toList(),
  };

  static int _getLevelForPlatform(String platform) {
    switch (platform) {
      case 'Mobile Dev':
        return 80;
      case 'Web Dev':
        return 80;
      case 'Desktop Dev':
        return 80;
      default:
        return 80;
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    final allSkills = _getAllSkills();
    _skillControllers = List.generate(
      allSkills.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 1000 + (index * 100)),
        vsync: this,
      ),
    );
    
    _startAnimations();
  }

  void _startAnimations() {
    _animationController.forward();
    for (int i = 0; i < _skillControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) {
          _skillControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (final controller in _skillControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Map<String, dynamic>> _getAllSkills() {
    List<Map<String, dynamic>> allSkills = [];
    skillCategories.forEach((category, skills) {
      allSkills.addAll(skills);
    });
    return allSkills;
  }

  List<Map<String, dynamic>> _getFilteredSkills() {
    if (selectedCategory == 'All') {
      return _getAllSkills();
    }
    return skillCategories[selectedCategory] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1200;
    final filteredSkills = _getFilteredSkills();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          // Category filter
          AnimatedSection(
            delay: const Duration(milliseconds: 200),
            child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ['All', ...skillCategories.keys].map((category) {
                    final isSelected = selectedCategory == category;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? CustomColor.primaryGradient
                              : null,
                          color: isSelected
                              ? null
                              : CustomColor.surfaceColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
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

          // Skills grid
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = isDesktop ? 4 : 
                    (constraints.maxWidth > 600 ? 3 : 2);
                
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: filteredSkills.length,
                  itemBuilder: (context, index) {
                    final skill = filteredSkills[index];
                    final controllerIndex = _getAllSkills().indexOf(skill);
                    final controller = controllerIndex >= 0 && 
                        controllerIndex < _skillControllers.length
                        ? _skillControllers[controllerIndex]
                        : _animationController;
                    
                    return AnimatedSection(
                      delay: Duration(milliseconds: 100 * index),
                      child: _buildSkillCard(skill, controller),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> skill, AnimationController controller) {
    final level = skill['level'] as int;
    final levelPercent = level / 100.0;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                CustomColor.surfaceColor.withOpacity(0.8),
                CustomColor.charcoal.withOpacity(0.6),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: CustomColor.borderColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Skill icon with progress circle
              Stack(
                alignment: Alignment.center,
                children: [
                  // Progress circle
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      value: controller.value * levelPercent,
                      strokeWidth: 4,
                      backgroundColor: CustomColor.borderColor.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        CustomColor.cyanAccent,
                      ),
                    ),
                  ),
                  // Skill icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: CustomColor.scaffoldBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      skill['icon'],
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Skill name
              Text(
                skill['name'],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: CustomColor.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 8),
              
              // Proficiency level
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  final animatedLevel = (controller.value * level).round();
                  return Text(
                    '${animatedLevel}%',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: CustomColor.cyanAccent,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'monospace',
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 12),
              
              // Linear progress bar
              Container(
                width: double.infinity,
                height: 4,
                decoration: BoxDecoration(
                  color: CustomColor.borderColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: controller.value * levelPercent,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          CustomColor.cyanAccent,
                          CustomColor.cyanAccent.withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}