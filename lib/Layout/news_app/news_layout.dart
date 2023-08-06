import 'package:news_app/Layout/news_app/cubit/cubit.dart';
import 'package:news_app/Layout/news_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/remote/dieo_helper.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                //  https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca,
                icon: Icon(
                  Icons.search,
                ),
              ),
              // mode icon :
              IconButton(
                onPressed: () {
                  NewsCubit.get(context).changeAppMode();
                },
                //  https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca,
                icon: Icon(
                  Icons.brightness_4_outlined,
                ),
              ),
            ],
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
