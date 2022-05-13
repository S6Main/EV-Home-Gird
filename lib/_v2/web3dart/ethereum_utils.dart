
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class EthereumUtils {
  late Web3Client web3client;
  late http.Client httpClient;
  final contractAddress = dotenv.env['CONTRACT_ADDRESS'];

  void initial() {
    httpClient = http.Client();
    String infuraApi = "https://ropsten.infura.io/v3/64e91f8989da4b26a7851df51c1afb3b";
    web3client = Web3Client(infuraApi, httpClient);
  }

  Future getBalance() async {
    final contract = await getDeployedContract();
    final etherFunction = contract.function("getBalance");
    final result = await web3client.call(contract: contract, function: etherFunction, params: []);
    List<dynamic> res = result;
    return res[0];
  }

  Future<String> sendBalance(int amount) async {
    var bigAmount = BigInt.from(amount);
    EthPrivateKey privateKeyCred = EthPrivateKey.fromHex(dotenv.env['METAMASK_PRIVATE_KEY']!);
    DeployedContract contract = await getDeployedContract();
    final etherFunction = contract.function("sentBalance");
    final result = await web3client.sendTransaction(
        privateKeyCred,
        Transaction.callContract(
          contract: contract,
          function: etherFunction,
          parameters: [bigAmount],
          maxGas: 100000,
        ),chainId: 3,
        fetchChainIdFromNetworkId: false);
    return result;
  }

  Future<String> withDrawBalance(int amount) async {
    var bigAmount = BigInt.from(amount);
    EthPrivateKey privateKeyCred = EthPrivateKey.fromHex(dotenv.env['METAMASK_PRIVATE_KEY']!);
    DeployedContract contract = await getDeployedContract();
    final etherFunction = contract.function("withdrawBalance");
    final result = await web3client.sendTransaction(
        privateKeyCred,
        Transaction.callContract(
          contract: contract,
          function: etherFunction,
          parameters: [bigAmount],
          maxGas: 100000,
        ),chainId: 3,
        fetchChainIdFromNetworkId: false);
    return result;

  }



  Future<DeployedContract> getDeployedContract() async {
    String abi = await rootBundle.loadString("assets/web3dart/abi.json");
    final contract = DeployedContract(ContractAbi.fromJson(abi, "BasicDapp"), EthereumAddress.fromHex(contractAddress!));
    return contract;
  }
}