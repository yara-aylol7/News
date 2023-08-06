abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

// business :
class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetBusinessLoadingState extends NewsStates {}

// sports :
class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error;
  NewsGetSportsErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates {}

//Science :
class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final String error;
  NewsGetScienceErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class AppChangeModeState extends NewsStates {}

//search :
class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error;
  NewsGetSearchErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsStates {}
