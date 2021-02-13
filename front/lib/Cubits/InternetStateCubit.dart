import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription connectivityStreamSub;

  InternetCubit({@required this.connectivity}) : super(InternetState()) {
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSub =
        connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        print("no Internet State!!!!!!!");
        emitInternetDisconnected();
      } else {
        print('internet access state@@@@@');
        emitInternetConnected();
      }
    });
  }

  void emitInternetConnected() {
    print("Emitting internet Connected.");
    emit(InternetConnected());
  }

  void emitInternetDisconnected() {
    print("emitting internet disconnected.");
    emit(InternetDisconnected());
  }

  @override
  Future<void> close() {
    connectivityStreamSub.cancel();
    return super.close();
  }

  @override
  void onChange(Change<InternetState> change) {
    print("ON CHANGE CALLED :::::::::::::::: $change");
    super.onChange(change);
  }
}

class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {}

class InternetDisconnected extends InternetState {}
