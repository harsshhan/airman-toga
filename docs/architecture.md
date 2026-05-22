# AIRMAN TOGA — System Architecture & Design Document

This document provides a highly detailed description of the **AIRMAN TOGA** system architecture, data flows, core technologies, and structural guidelines. This serves as the single source of truth for engineering guidelines, feature integration, and system design boundaries.

---

## 1. Architectural Overview & Design Goals

AIRMAN TOGA is designed as an offline-friendly pilot training application for cadets. The architecture focuses on the following goals:

1. **Offline Support:** The application should continue working even with poor or no internet connection. Important data such as notes and user states are stored locally.
2. **Feature-Based Structure:** The project is organized by features (Auth, Dashboard, Notes, Logbook, Study, Notifications) to keep the code clean and easier to maintain.
3. **Reactive Data Flow:** User actions update application state through Providers, which automatically refreshes the UI when data changes.
4. **Separation of Responsibilities:** UI, state management, business logic, and data sources are separated. This allows storage methods such as Hive or APIs to be changed later without affecting the UI layer.

---

## 2. Feature-Driven Clean Architecture

The codebase is split into two primary segments under `lib/`:
* `lib/core/`: Cross-cutting concerns, design systems, shell structures, and global clients.
* `lib/features/`: Fully self-contained business modules.

### Layered Boundaries Within Features
Each feature in `lib/features/<feature_name>/` is segmented into four distinct layers:

```
                  ┌──────────────────────────────────────────┐
                  │          Presentation Layer (UI)         │
                  │   - Screens (e.g., StudyScreen)          │
                  │   - Widgets (e.g., SubjectCard)          │
                  └────────────────────┬─────────────────────┘
                                       │ (Listens & Triggers Actions)
                                       ▼
                  ┌──────────────────────────────────────────┐
                  │         Presentation State Layer         │
                  │   - Providers (ChangeNotifier)           │
                  │     Manages view reactive state.         │
                  └────────────────────┬─────────────────────┘
                                       │ (Coordinates Domain Transaction)
                                       ▼
                  ┌──────────────────────────────────────────┐
                  │        Domain / Repository Layer         │
                  │   - Repositories (Orchestrators)         │
                  │     Coordinates local and remote data.   │
                  └────────────────────┬─────────────────────┘
                                       │ (Executes Data Extraction)
                                       ▼
                  ┌──────────────────────────────────────────┐
                  │          Infrastructure / Data           │
                  │   - Services (API / Local Storage)       │
                  │   - Models (Domain entities & JSONs)     │
                  └──────────────────────────────────────────┘
```

#### A. Presentation Layer (`presentation/`)
* **Screens:** Top-level widget entry points mapped directly to route configurations. They are generally declarative and consume state via context watchers.
* **Widgets:** Modular, highly reusable building blocks. They depend on local styling and primitive variables, remaining fully decoupled from global state where possible.

#### B. Presentation State Layer (`provider/`)
* Built using the Flutter `provider` framework utilizing `ChangeNotifier`.
* Responsible for holding reactive screen states (e.g., `isLoading`, `error`, `activeList`).
* Exposes public methods that invoke repository transactions and calls `notifyListeners()` to propagate updates back to watched UI elements.

#### C. Domain / Repository Layer (`data/repository/`)
* Acts as the orchestration layer and single source of truth for domain logic.
* Combines different services to execute business rules (for instance, saving a draft to the local service before attempting remote delivery via the remote API service).
* Translates raw exceptions from services into typed domain-level exceptions.

#### D. Infrastructure / Data Layer (`data/service/` & `data/model/`)
* **Services:** Dumb, single-purpose client wrappers. `NotesHiveService` only performs Hive operations; `NotesApiService` only handles HTTP requests. They do not depend on other services.
* **Models:** Strongly-typed Dart classes holding the serialization (`fromJson`/`toJson`) or database adapter annotations (Hive `@HiveType`).

---

## 3. Data Flow & Reactivity Patterns

The system enforces a strict unidirectional flow for state updates, preventing race conditions and stale UI configurations.

### Sequence Flow: Creating & Syncing a Study Note
The sequence below illustrates the transaction coordination between local storage, remote storage, and UI updates:

```
[UI Screen]                      [NotesProvider]                   [NotesRepository]                 [NotesHiveService]              [NotesApiService]
     │                                  │                                  │                                  │                                  │
     │── 1. Save & Sync Note ──────────>│                                  │                                  │                                  │
     │                                  │── 2. Call saveAndSyncNote() ────>│                                  │                                  │
     │                                  │                                  │── 3. Write "Pending" note ──────>│                                  │
     │                                  │                                  │                                  │                                  │
     │                                  │                                  │── 4. Write "Syncing" note ──────>│                                  │
     │<── 5. Redraw UI (Spinner) ───────│                                  │                                  │                                  │
     │                                  │                                  │                                  │                                  │
     │                                  │                                  │── 6. Request remote sync ────────┼─────────────────────────────────>│
     │                                  │                                  │                                  │                                  │
     │                                  │                                  │<── 7. Returns Sync Result ───────┼──────────────────────────────────│
     │                                  │                                  │                                  │                                  │
     │                                  │                                  │── 8. Write status (Synced/Failed)│                                  │
     │                                  │                                  │      & update retry count ──────>│                                  │
     │                                  │<── 9. Complete Transaction ──────│                                  │                                  │
     │<── 10. Redraw UI (Success/Fail) ─│                                  │                                  │                                  │
```

---

## 4. Core Technology & Library Integrations

The system is configured around a curated selection of reliable, lightweight packages:

* **`provider`:** Handles lightweight, reactive state management across features, mapped globally inside [main.dart](file:///Users/harshan/Projects/AIRMAN/airman_toga/lib/main.dart).
* **`hive_flutter` / `hive`:** A lightweight, binary key-value database written in pure Dart. It enables sub-millisecond local reads and writes, making it ideal for mobile devices running in flight lines.
* **`shared_preferences`:** Persists key-value settings. Wrapped securely inside `LocalStorage` to manage cadet logins and persist user credentials on disk.
* **`dio`:** Declared for high-performance HTTP networking, supporting base options, timeout policies, and robust auth headers injection via custom interceptors.

---

## 5. Detailed Feature Breakdown

### A. Authentication Feature (`lib/features/auth/`)
* **Purpose:** Cadet authentication and local session control.
* **Architecture:**
  * Uses `LocalStorage` (wrapping SharedPreferences) to serialize and deserialize the `CadetProfile` to disk.
  * `LoginScreen` (StatefulWidget) performs an asynchronous check during `initState` via `AuthProvider.checkLoginStatus()`.
  * If a session is valid, the UI automatically triggers a replacement transition to `/shell`, bypassing the credentials screen.
  * Tapping the profile avatar in the Dashboard header triggers a secure logout confirmation alert dialog, calling `AuthProvider.logout()` which deletes the local session before returning to the Login route.

### B. Dashboard Feature (`lib/features/dashboard/`)
* **Purpose:** Displays training metrics, progress bars, mock notifications, flight schedules, and unified navigation shortcuts.
* **Architecture:**
  * Uses `DashboardProvider` to fetch aggregated progress items via `DashboardService`.
  * Integrated unified tab routing: Tapping on dashboard indicators automatically communicates with the parent `AppShellState` to programmatically update the bottom navigation bar and active index.

### C. Syllabus & Study Feature (`lib/features/study/`)
* **Purpose:** Structured course materials, training stages, subjects, and chapter syllabi.
* **Architecture:**
  * Uses `StudyProvider` to load subject lists.
  * Navigates into `SubjectDetailScreen` to read specific lesson chapters.

### D. Logbook Feature (`lib/features/logbook/`)
* **Purpose:** Pilot flight entry logs and simulator reports.
* **Architecture:**
  * Connects `LogbookProvider` to retrieve raw data, displaying entries inside flight logging grid cards.

### E. Study Notes Feature (`lib/features/notes/`)
* **Purpose:** Offline-first text notes editor supporting real-time data synchronization.
* **Architecture:**
  * Uses `NotesHiveService` as the local write-ahead database.
  * `NotesApiService` provides simulated synchronization loops, using latency delays and a deterministic retry strategy (failing on the first try where `retryCount == 0`, and succeeding on subsequent clicks).
  * Exposes individual spinners and buttons showing the exact status transitions (`Pending`, `Syncing`, `Failed`, `Synced`).

---

## 6. Persistence & Storage Strategy

The system uses two persistent datastores, each tailored for specific data requirements:

### A. Hive Binary Database (Structured Objects)
* **Encryption & Speed:** Binary formatting enables ultra-fast disk caching.
* **Type Adapters:** Models are marked with `@HiveType` annotations, and adapters are automatically generated via `build_runner`.
* **Registration:** Registrations are executed in `main.dart` before the widget tree starts rendering:
  ```dart
  Hive.registerAdapter(SyncStatusAdapter());
  Hive.registerAdapter(StudyNoteAdapter());
  await Hive.openBox<StudyNote>('study_notes_box');
  ```

### B. SharedPreferences (Key-Value Metadata)
* Used solely for primitive values and configuration metadata.
* **Cadet Profile Serialization:**
  ```dart
  // Write to SharedPreferences
  await prefs.setString("cadet_profile", jsonEncode(user.toJson()));

  // Read from SharedPreferences
  final jsonMap = jsonDecode(profileStr) as Map<String, dynamic>;
  return CadetProfile.fromJson(jsonMap);
  ```

---

## 7. Guidelines for Adding Future Features

To preserve the scalability and modularity of the system, any new feature added to the AIRMAN TOGA codebase must strictly follow these structural steps:

1. **Create the Feature Folder Structure:**
   Create a new directory inside `lib/features/` with the standard structural directories:
   ```
   lib/features/<new_feature>/
   ├── data/
   │   ├── model/         # Define feature domain entity models
   │   ├── repository/    # Define the repository orchestrator
   │   └── service/       # Define remote API and local storage services
   ├── presentation/
   │   ├── screen/        # Main route screens
   │   └── widgets/       # Isolated custom widgets
   └── provider/          # ChangeNotifier state manager
   ```
2. **Define Strongly-Typed Domain Models:**
   Create data classes in `data/model/`. If persistent caching is required, add `@HiveType` annotations, declare a unique `HiveTypeId`, and run:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
3. **Encapsulate Data Operations inside Services:**
   Keep service classes specialized and simple. Ensure services do not import providers, repositories, or other services.
4. **Introduce the Repository Orchestrator:**
   Implement sync rules, cache policies, and error handling inside the repository, injecting local and remote service dependencies via the constructor.
5. **Implement the State Provider:**
   Extend `ChangeNotifier` to hold loading states, error structures, and domain entities. Declare the provider in the root provider array inside `lib/main.dart` to make it accessible to the UI.

