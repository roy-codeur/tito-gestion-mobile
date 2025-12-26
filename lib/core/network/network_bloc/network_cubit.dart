import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'network_state.dart';

class ConnectionCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;

  ConnectionCubit(this._connectivity) : super(NetworkInitial()) {
    _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        emit(NetworkDisconnected());
      } else {
        emit(NetworkConnected());
      }
    });
  }
}
