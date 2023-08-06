import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Layout/news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings_screen/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dieo_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    /*BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),*/
  ];

  List<Widget> Screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
    //  SettingsScreen(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNavState());
  }

// business :
  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getdata(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '01510ea5a8d24ed7ab11312362e5acbe',
      },
    ).then((value) {
      // print(value.data.toString());
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

// sports :
  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getdata(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '01510ea5a8d24ed7ab11312362e5acbe',
        },
      ).then((value) {
        // print(value.data.toString());
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  //science :
  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getdata(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '01510ea5a8d24ed7ab11312362e5acbe',
        },
      ).then((value) {
        // print(value.data.toString());
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getdata(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '01510ea5a8d24ed7ab11312362e5acbe',
      },
      //4e64ec863d414856b9d766e89e7d0c54
    ).then((value) {
      // print(value.data.toString());
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  bool isDark = false;
  void changeAppMode({
    bool? fromShared,
  }) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CachHelper.putBoolean(key: ' isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
