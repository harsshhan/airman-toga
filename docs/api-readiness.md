# AIRMAN TOGA — Concrete API Readiness & Production Integration Roadmap

This document provides a comprehensive, production-ready roadmap to transition the **AIRMAN TOGA** application from mock services to a live production backend API. It maps directly onto the existing concrete files, models, and dependencies without introducing unnecessary abstract interfaces or heavy architectural refactoring.

---

## 1. Integration with the Existing Codebase

Currently, the services and repositories are instantiated as concrete classes inside `main.dart`:

```dart
// The current instantiation flow in main.dart
ChangeNotifierProvider(
  create: (_) => NotesProvider(
    repository: NotesRepository(
      localService: NotesHiveService(),
      remoteService: NotesApiService(), // Concrete service
    ),
  ),
),
```

To integrate a production API, the codebase does **not** require complex abstract interfaces. Instead, a configured **`Dio`** instance is injected directly into the constructors of the existing concrete services.

---

## 2. Setting Up the Global `Dio` Network Client

The `Dio` network library (already declared in `pubspec.yaml`) is wrapped in a clean client with a global `Interceptor` to handle headers and JWT authentication automatically.

### A. The Custom Auth Interceptor
A new network interceptor is introduced to manage token attachment and authentication expiration:

```dart
// lib/core/network/auth_interceptor.dart
import 'package:dio/dio.dart';
import '../storage/local_storage.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorage _localStorage;

  AuthInterceptor(this._localStorage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 1. Fetch persistent token from SharedPreferences (via LocalStorage)
    final token = await _localStorage.isLoggedIn() ? "mock_jwt_token_here" : null; 
    // In production, the access_token is saved inside LocalStorage and read here:
    // final token = await _localStorage.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 2. Handle token expiry (401 Unauthorized)
    if (err.response?.statusCode == 401) {
      await _localStorage.clearSession();
      // In production, this can broadcast a logout event or trigger LoginScreen redirection
    }
    super.onError(err, handler);
  }
}
```

### B. The Network Initializer
The shared `Dio` client is instantiated inside `main.dart` and passed down to the services:

```dart
// In lib/main.dart (or a dedicated network configuration file)
import 'package:dio/dio.dart';
import 'core/network/auth_interceptor.dart';

Dio createDioClient(LocalStorage localStorage) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.airmantoga.com/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(AuthInterceptor(localStorage));
  
  // Add a logger for debugging network traffic during development
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  return dio;
}
```

---

## 3. Refactoring the Concrete Services

Below is the implementation detail showing how the existing concrete services are refactored to consume the live API using `Dio`.

### A. Auth Service (`lib/features/auth/data/services/auth_service.dart`)

```diff
-import 'package:airman_toga/core/mock_data/auth_mock_data.dart';
 import 'package:airman_toga/features/auth/data/model/cadet_profile.dart';
+import 'package:dio/dio.dart';
 
 class AuthService {
-  Future<CadetProfile> login() async {
-    // simulate API delay
-    await Future.delayed(
-      const Duration(seconds: 2),
-    );
-
-    return CadetProfile.fromJson(
-      MockCadetProfile.profile.toJson(),
-    );
-  }
+  final Dio _dio;
+
+  AuthService(this._dio);
+
+  Future<CadetProfile> login() async {
+    final response = await _dio.post('/auth/login');
+    return CadetProfile.fromJson(response.data);
+  }
 }
```

### B. Dashboard Service (`lib/features/dashboard/data/service/dashboard_service.dart`)

```diff
-import 'package:airman_toga/core/mock_data/dashboard_mock_data.dart';
 import 'package:airman_toga/features/dashboard/data/model/dashboard_data.dart';
+import 'package:dio/dio.dart';
 
 class DashboardService {
-  Future<DashboardData> fetchDashboard() async {
-    await Future.delayed(
-      const Duration(seconds: 1),
-    );
-
-    return DashboardData.fromJson(
-      DashboardMockData.dashboard,
-    );
-  }
+  final Dio _dio;
+
+  DashboardService(this._dio);
+
+  Future<DashboardData> fetchDashboard() async {
+    final response = await _dio.get('/dashboard/summary');
+    return DashboardData.fromJson(response.data);
+  }
 }
```

### C. Notes API Service (`lib/features/notes/data/service/notes_api_service.dart`)

```diff
 import '../model/study_note.dart';
+import 'package:dio/dio.dart';
 
 class NotesApiService {
-  Future<bool> syncNote(StudyNote note) async {
-    await Future.delayed(const Duration(seconds: 2));
-    
-    if (note.retryCount == 0) {
-      return false;
-    }
-    return true;
-  }
+  final Dio _dio;
+
+  NotesApiService(this._dio);
+
+  Future<bool> syncNote(StudyNote note) async {
+    try {
+      final response = await _dio.post('/notes/sync', data: note.toJson());
+      return response.statusCode == 200 || response.statusCode == 201;
+    } catch (e) {
+      return false;
+    }
+  }
 }
```

---

## 4. Initialization and Dependency Flow in `main.dart`

To connect the new network client with the existing providers, `main.dart` is updated as follows:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SyncStatusAdapter());
  Hive.registerAdapter(StudyNoteAdapter());
  await Hive.openBox<StudyNote>('study_notes_box');

  final localStorage = LocalStorage();
  
  // 1. Create a single, shared Dio instance
  final dio = createDioClient(localStorage);

  runApp(MyApp(
    localStorage: localStorage,
    dio: dio,
  ));
}

class MyApp extends StatelessWidget {
  final LocalStorage localStorage;
  final Dio dio;

  const MyApp({
    super.key, 
    required this.localStorage,
    required this.dio,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            repository: AuthRepository(
              authService: AuthService(dio), // Pass Dio here
              localStorage: localStorage,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(
            repository: DashboardRepository(
              dashboardService: DashboardService(dio), // Pass Dio here
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => NotesProvider(
            repository: NotesRepository(
              localService: NotesHiveService(),
              remoteService: NotesApiService(dio), // Pass Dio here
            ),
          ),
        ),
        // ... Logbook, Study, and Alerts are configured identically
      ],
      child: MaterialApp(
        // ... MaterialApp properties
      ),
    );
  }
}
```

---

## 5. Offline Notes Sync & Caching Mechanics

The core synchronization engine inside `NotesRepository` remains **entirely unchanged**. It interacts with the live API client seamlessly:

```dart
// The repository synchronization flow maps directly to the live API
Future<void> saveAndSyncNote(StudyNote note) async {
  var currentNote = note.copyWith(syncStatus: SyncStatus.pending);
  await localService.updateNote(currentNote); // 1. Save locally as pending

  currentNote = currentNote.copyWith(syncStatus: SyncStatus.syncing);
  await localService.updateNote(currentNote); // 2. Mark as syncing for UI loaders

  try {
    // 3. Concrete NotesApiService makes the actual HTTP POST request
    final success = await remoteService.syncNote(currentNote); 
    if (success) {
      currentNote = currentNote.copyWith(syncStatus: SyncStatus.synced);
    } else {
      currentNote = currentNote.copyWith(
        syncStatus: SyncStatus.failed,
        retryCount: currentNote.retryCount + 1,
      );
    }
  } catch (e) {
    currentNote = currentNote.copyWith(
      syncStatus: SyncStatus.failed,
      retryCount: currentNote.retryCount + 1,
    );
  }

  await localService.updateNote(currentNote); // 4. Save final result in Hive
}
```

---

## 6. API Error Handling & Network Mapping

### Error Translation Utility
To convert raw Dio network issues into descriptive, user-facing notifications, a standard utility class is introduced:

```dart
// lib/core/network/network_error.dart
import 'package:dio/dio.dart';

class NetworkError {
  static String parse(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return "Connection timed out. Check the flight-line link.";
      }
      if (error.type == DioExceptionType.connectionError) {
        return "No internet connection detected.";
      }
      final statusCode = error.response?.statusCode;
      if (statusCode == 401) return "Session expired. Please log in again.";
      if (statusCode == 500) return "Server error. Please try again later.";
    }
    return "An unexpected error occurred.";
  }
}
```

Inside the `Provider` files, exceptions are caught and parsed using the mapper:
```dart
try {
  await repository.login();
} catch (e) {
  this.error = NetworkError.parse(e);
  notifyListeners();
}
```
This is fully compatible with the existing UI components, which read the `error` state from Providers to display alert banners or snackbars.
