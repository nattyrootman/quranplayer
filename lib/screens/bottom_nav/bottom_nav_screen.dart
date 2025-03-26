import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/favorite_screen/favorite_screen.dart';
import 'package:myapp/screens/home_screen/home_screen.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(MyBottomNavController());
    final items=controller.items;
    final pages=controller.pages;
    return Obx(()=>  Scaffold(
     bottomNavigationBar: BottomNavigationBar(
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      currentIndex: controller.currentIndex.value,
      items: controller.items,
      onTap: (value) => controller.currentIndex.value = value,
      ),
      body: controller.pages[controller.currentIndex.value],
    ));
  }
}

class MyBottomNavController extends GetxController {

 RxInt currentIndex = 0.obs;
  RxList<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      
      icon: Icon(Icons.home),
      label: 'Accueil',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favoris',
    ),
  ].obs;


 RxList<Widget> pages = [
    const HomeScreen(),
     const FavoriteScreen(),
  ].obs;

}
