import 'network_bloc/network_cubit.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final ConnectionCubit connectionCubit;

  NetworkInfoImpl(this.connectionCubit);

  @override
  Future<bool> get isConnected async {
    final state = connectionCubit.state;
    return state is NetworkConnected; // utilise le nom exact défini dans network_state.dart
  }
}
