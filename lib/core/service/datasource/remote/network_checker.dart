import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../interfaces/i_network_checker.dart';

class NetworkChecker extends INetworkChecker{

  @override
  Future<bool> hasConnection() async{
    try{
      return await InternetConnection().hasInternetAccess;
    }catch(_){
      return false;
    }
  }
}
