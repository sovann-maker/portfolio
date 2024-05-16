class ProjectUtils {
  final String image;
  final String title;
  final String subtitle;
  final String? androidLink;
  final String? iosLink;
  final String? webLink;

  ProjectUtils({
    required this.image,
    required this.title,
    required this.subtitle,
    this.androidLink,
    this.iosLink,
    this.webLink,
  });
}

// ###############
// WORK PROJECTS
List<ProjectUtils> workProjectUtils = [
  //my projects
  ProjectUtils(
    image: '/assets/projects/eCommerce.jpg',
    title: 'E-Commerce App with BLoC Pattern',
    subtitle:
        'User friendly eCommerce app using Flutter framework, Firebase for authentication, Stripe for in-app payment. ',
    webLink: 'https://github.com/sovann-maker/flutter-ecommerce.git',
  ),
  ProjectUtils(
    image: 'assets/projects/w02.jpeg',
    title: 'Todo App using Rest API',
    subtitle:
        'A simple Todo List app using Flutter framework and perform CRUD operation using Rest API.',
    webLink: 'https://github.com/sovann-maker/todoList_restApi.git',
  ),
  ProjectUtils(
    image: 'assets/projects/expense_tracker.jpg',
    title: 'Expense Tracker App',
    subtitle:
        'A basic expense tracker app using Flutter framework and local storage as database.',
    webLink: 'https://github.com/sovann-maker/expense-tracker.git',
  ),
  ProjectUtils(
    image: 'assets/projects/sneakershop.jpg',
    title: 'Sneaker Shop',
    subtitle:
        'A user friendly sneaker shop app using Flutter framework and Hive as database.',
    webLink: 'https://github.com/sovann-maker/sneaker_shop.git',
  ),
  ProjectUtils(
    image: 'assets/projects/eCommerceweb.png',
    title: 'E-Commerce Site',
    subtitle:
        'A simple e-commerce site build using Angular framework and Stripe for payment.',
    webLink: 'https://github.com/ChimSovann/WAD_FinalProject.git',
  ),
  ProjectUtils(
    image: 'assets/projects/newsapp.png',
    title: 'News Site',
    subtitle:
        'A News Site that display news from many news sources using News API.',
    webLink: 'https://github.com/ChimSovann/NewsApp.git',
  ),
];
