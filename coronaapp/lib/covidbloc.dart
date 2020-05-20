import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'corvidrepo.dart';


import 'covidmodel.dart';
class CovidEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class FetchCovid extends CovidEvent{
  final _country;

  FetchCovid(this._country);

  @override
  // TODO: implement props
  List<Object> get props => [_country];
}

class ResetCovid extends CovidEvent{

}

class CovidState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}


class CovidIsNotSearched extends CovidState{

}

class CovidIsLoading extends CovidState{

}

class CovidIsLoaded extends CovidState{
  final _Covid;

  CovidIsLoaded(this._Covid);

  CovidModel get getCovid => _Covid;

  @override

  List<Object> get props => [_Covid];
}

class CovidIsNotLoaded extends CovidState{

}

class CovidBloc extends Bloc<CovidEvent, CovidState>{

  CovidRepo covidRepo;

  CovidBloc(this.covidRepo);

  @override
  // TODO: implement initialState
  CovidState get initialState => CovidIsNotSearched();

  @override
  Stream<CovidState> mapEventToState(CovidEvent event) async*{
    // TODO: implement mapEventToState
    if(event is FetchCovid){
      yield CovidIsLoading();

      try{
        CovidModel covid = await covidRepo.getdata(event._country);
        yield CovidIsLoaded(covid);
      }catch(_){
        print(_);
        yield CovidIsNotLoaded();
      }
    }else if(event is ResetCovid){
      yield CovidIsNotSearched();
    }
  }

}
