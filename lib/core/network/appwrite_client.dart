import 'package:appwrite/appwrite.dart';
import '../constants/app_constants.dart';

/// Appwrite Client Singleton
/// Manages all Appwrite services and connections
class AppwriteClient {
  // Private constructor
  AppwriteClient._internal() {
    _client = Client();
    _initClient();
    _initServices();
  }

  static final AppwriteClient _instance = AppwriteClient._internal();

  factory AppwriteClient() => _instance;

  late final Client _client;
  late final Account _account;
  late final Databases _databases;
  late final Storage _storage;
  late final Realtime _realtime;
  late final Functions _functions;

  void _initClient() {
    _client
        .setEndpoint(AppConstants.appwriteEndpoint)
        .setProject(AppConstants.appwriteProjectId)
        .setSelfSigned(); // For development only
  }

  void _initServices() {
    _account = Account(_client);
    _databases = Databases(_client);
    _storage = Storage(_client);
    _realtime = Realtime(_client);
    _functions = Functions(_client);
  }

  // Getters for services
  Client get client => _client;
  Account get account => _account;
  Databases get databases => _databases;
  Storage get storage => _storage;
  Realtime get realtime => _realtime;
  Functions get functions => _functions;

  // Database ID shortcut
  String get databaseId => AppConstants.appwriteDatabaseId;
}