# AIRMAN TOGA — Pilot Training & Flight Management Companion

**AIRMAN TOGA** is a feature-driven, offline-first mobile application designed to serve as a comprehensive flight training and syllabus companion for cadet pilots. Engineered using Flutter and Dart, the application provides flight school cadets with offline syllabus guides, flight logging metrics, automated notifications and interactive study notes synchronized via a reliable offline-first cache mechanism.

---

## 1. Project Overview & Core Features

The application is structured to support cadets through every phase of flight school training, offering the following capabilities:

* **Interactive Cadet Dashboard:** Provides real-time metrics on syllabus progress, simulator hours, flight logs, and upcoming training schedules. Features high-fidelity charts, progress indicators, and navigation hooks.
* **Offline-First Study Notes:** Enables cadets to create, edit, and manage training notes directly inside a local write-ahead database (Hive). Features a fully-controlled synchronization workflow showcasing:
  * **Status States:** Transitions smoothly through `Pending` ➔ `Syncing` ➔ `Failed` ➔ `Synced`.
  * **Simulated Network Fluctuations:** Demonstrates failure modes, loading states, and robust error recovery on a granular, per-note basis.
  * **Intelligent Retry:** Implements programmatic failure on first attempts with a retry prompt to showcase resilient client-side state recovery.
* **Persistent Cadet Authentication:** Secure login flow with local persistence. Features session restoration on startup and an interactive, clean logout flow.
* **Unified Alerts & Notifications:** Manages critical operational alerts, simulator scheduling notifications, and study updates, supporting mark-as-read updates and direct tab-routing.
* **Structured Chapter Syllabus:** Breaks down training material by subject and chapter, allowing detailed syllabus offline reading.

---

## 2. Technology Stack & Packages

The project uses a clean, high-performance, and lightweight dependency architecture:

* **Core Framework:** [Flutter](https://flutter.dev) (Dart SDK)
* **State Management:** [Provider](https://pub.dev/packages/provider) — Leverages reactive `ChangeNotifier` bindings to separate UI rendering from business logic.
* **Local Structured Database:** [Hive](https://pub.dev/packages/hive) & [Hive Flutter](https://pub.dev/packages/hive_flutter) — A super-fast, binary key-value database used to store note drafts locally with auto-generated type adapters.
* **Local Session Persistence:** [SharedPreferences](https://pub.dev/packages/shared_preferences) — Retains Cadet profiles and authentication metadata across application lifecycle restarts.
* **HTTP Networking Client:** [Dio](https://pub.dev/packages/dio) — Configured for robust HTTP communication, custom interceptors (JWT header attachment), error mapping, and timeout thresholds.

---

## 3. Directory & Code Architecture

The codebase adheres strictly to a modular, **Feature-Driven Clean Architecture** to isolate concerns and support future scalability:

```
lib/
├── core/
│   ├── mock_data/      # Structured local data mock sets
│   ├── storage/        # Shared LocalStorage (SharedPreferences) wrappers
│   ├── theme/          # Custom uniform UI design systems and colors
│   └── network/        # Global network clients and interceptors (Dio configurations)
└── features/
    ├── alerts/         # Notification management and tab navigation hooks
    ├── auth/           # Secure cadet authentication and local session storage
    ├── dashboard/      # Progress aggregation and unified navigation controls
    ├── logbook/        # Simulator and flight hours logs
    ├── notes/          # Offline-first editor, Hive storage, and sync services
    └── study/          # Chapter syllabus and lesson progress modules
```

Inside every individual business module under `features/`, the code is further decoupled into structural layers:
1. **`data/model/`**: Strongly-typed domain models handling JSON serialization (`fromJson` / `toJson`) and Hive binary adapters.
2. **`data/service/`**: Micro-services performing isolated actions (e.g., direct remote API POST calls or local Hive cache writes).
3. **`data/repository/`**: Single orchestrators that enforce offline-caching policies, cache synchronizations, and error mappings.
4. **`provider/`**: Presentation state management, exposing loaders, statuses, and calling repository methods.
5. **`presentation/`**: Fully decoupled UI screens and modular widgets.

---

## 4. Setup & Running the Project

### Prerequisites
* Flutter SDK (3.13.0 or higher is recommended)
* Dart SDK
* An active Android Emulator, iOS Simulator, or connected physical device

### Installation Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/harsshhan/airman-toga
   cd airman_toga
   ```

2. **Fetch dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate local database adapters (Hive):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Verify codebase linting:**
   ```bash
   flutter analyze
   ```

5. **Execute the application:**
   ```bash
   flutter run
   ```

---

## 5. Documentation

The project includes additional documentation under the `docs/` directory:

- [Architecture & Design Documentation](./docs/architecture.md)
  - Explains application architecture, folder structure, state management flow, local storage approach, and scalability considerations.

- [API Readiness Documentation](./docs/api-readiness.md)
  - Describes future backend integration strategy, endpoint mapping, authentication flow, synchronization handling, and production scalability considerations.

- [AI Usage Disclosure](./docs/ai-usage-disclosure.md)
  - Provides complete transparency regarding AI-assisted development, design generation, implementation support, and manual development decisions.

---

## 6. Screenshots

Application screenshots are available under:

[Screenshots](./screenshots)


---

## 7. App Flow Walkthrough

A complete walkthrough of the application flow and functionality is available below:

🎥 [Watch App Walkthrough](https://drive.google.com/file/d/1POw48CIyzYKaieTXiGRiuVXr4_WDHYZa/view?usp=sharing)

---

## 8. AI Usage Summary

AI tools were used as development assistants for planning, implementation guidance, UI ideation, and documentation support.

### Tools Used

- ChatGPT
- Claude
- Antigravity IDE
- Figma AI

📄 [AI Usage Disclosure](./docs/ai-usage-disclosure.md)
