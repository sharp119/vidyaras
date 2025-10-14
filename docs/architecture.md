# VidyaRas: Flutter Application Architecture

This document defines the official software architecture and development guidelines for the VidyaRas Flutter application. Adherence to these principles is mandatory to ensure a scalable, maintainable, and high-quality codebase.

---

## 🏛️ Core Philosophy

Our architecture is built on two key principles:

1.  **Separation of Concerns:** Each part of the application has a single, well-defined responsibility. This makes the code easier to understand, test, and debug.
2.  **Feature-First Organization:** Code is grouped by feature (e.g., `auth`, `course_player`, `community_chat`), not by type (e.g., `screens`, `models`). This keeps related logic together and makes the project easier to navigate.

---

## 🏗️ Application Architecture

We employ a **Layered Architecture** within each feature module. This model strictly defines how different parts of the application can interact.

The fundamental rule is the **Dependency Rule**: Dependencies must only flow inwards. The outer layers know about the inner layers, but the inner layers know nothing about the outer ones.

> **Presentation** ➡️ **Application** ➡️ **Domain** ⬅️ **Data**

### Directory Structure

This structure must be followed for every new feature:

```
lib/
└── src/
    └── features/
        └── feature_name/
            ├── 1_presentation/  # UI (Widgets & State)
            ├── 2_application/   # Business Logic (Use Cases/Services)
            ├── 3_domain/        # Core Models & Repository Interfaces
            └── 4_data/          # Data Sources & Repository Implementations
```

### Layer Responsibilities

* **1. Presentation Layer:**
    * **What it is:** The UI. This layer contains all your widgets, screens, and UI-specific state managed by Riverpod providers.
    * **Job:** To display data from the Application Layer and pass user events (like button taps) to it. It contains **no business logic**.

* **2. Application Layer:**
    * **What it is:** The brain of the feature. This layer orchestrates the flow of data and executes business rules.
    * **Job:** To respond to UI events, fetch data from the Data Layer (via repository interfaces), perform logic, and provide state to the Presentation Layer.

* **3. Domain Layer:**
    * **What it is:** The core of your application. It contains the essential data structures (models/entities) and the contracts (abstract repository classes) for how data should be fetched.
    * **Job:** To define the "what" of your data, not the "how." This layer is completely independent of any framework or external service.

* **4. Data Layer:**
    * **What it is:** The connection to the outside world (APIs, local databases).
    * **Job:** To implement the repository contracts defined in the Domain Layer. It handles all the messy details of making HTTP requests, talking to a local database, and transforming raw data into the domain models.

---

## 📚 Core Libraries & Guidelines

This section outlines the role of each core library in our stack and the rules for using it.

### UI & Theming

* **`shadcn_ui`**
    * **Role:** The primary UI component library for building a consistent and beautiful user interface.
    * **Guidelines:**
        * Always prefer using a `shadcn_ui` component over building one from scratch.
        * Customize the theme centrally in your `main.dart` or a dedicated theme file. Do not apply one-off styles directly to widgets.

* **`flutter_svg`**
    * **Role:** Renders SVG images, which are used for icons and illustrations.
    * **Guidelines:**
        * Store all SVG assets in a dedicated `assets/svgs` directory.
        * Use the `SvgPicture.asset()` constructor for local assets.

* **`rive`**
    * **Role:** Renders advanced, stateful animations. Used for engaging onboarding flows, loading indicators, or interactive elements.
    * **Guidelines:**
        * Animations should be used purposefully to enhance the user experience, not just for decoration.
        * Encapsulate Rive animation logic within its own dedicated widget.

* **`cached_network_image`**
    * **Role:** Displays and caches images from the network.
    * **Guidelines:**
        * Use this for all user-generated or remote images (e.g., course thumbnails, profile pictures).
        * Always configure appropriate `placeholder` and `errorWidget` builders for a smooth user experience.

* **`fl_chart`**
    * **Role:** Creates beautiful and interactive charts.
    * **Guidelines:**
        * Used exclusively for data visualization, such as in the student's progress dashboard or test series analysis.
        * Chart data logic should be prepared by a Riverpod provider; the widget should only be responsible for rendering.

### State Management

* **`riverpod`** & **`riverpod_generator`**
    * **Role:** The state management and dependency injection solution for the entire application.
    * **Guidelines:**
        * **Always** use the `riverpod_generator` (`@riverpod` annotations). Do not write providers manually.
        * Providers belong in the **Presentation Layer**. They fetch data from the Application Layer and provide it to the UI.
        * Use `.autoDispose` by default (`@riverpod`) to prevent memory leaks. Only use `keepAlive: true` for state that must be preserved globally.

### Data Modeling & Serialization

* **`freezed`** & **`json_serializable`**
    * **Role:** Generates immutable data models and handles JSON conversion.
    * **Guidelines:**
        * **All** models (in the Domain Layer) and state objects (in the Presentation Layer) **must** be created with `freezed`. This enforces immutability, which is critical for predictable state management.
        * Use the `@JsonSerializable()` annotation for any model that needs to be converted to/from JSON.

* **`equatable`**
    * **Role:** Simplifies object comparison.
    * **Guidelines:**
        * While `freezed` handles this automatically for data classes, `equatable` can be used for custom objects (like `Failure` types or Use Case params) where value-based equality is needed without full code generation.

### Navigation

* **`go_router`**
    * **Role:** Handles all routing and navigation within the app.
    * **Guidelines:**
        * Define all routes in a single, centralized router configuration file.
        * Use named routes for navigation (e.g., `context.go('/course/123')`) instead of pushing widget instances directly.
        * Pass arguments as path parameters, query parameters, or via the `extra` parameter.

### Networking & Data Storage

* **`dio`**
    * **Role:** The HTTP client for all API communication.
    * **Guidelines:**
        * **Must** only be used within the **Data Layer** (specifically in `ApiDataSource` classes).
        * Create a single, app-wide `dio` instance provided via Riverpod. Centralize configuration (base URL, interceptors for logging or auth) in one place.

* **`hive`**
    * **Role:** A fast, lightweight key-value database for local storage.
    * **Guidelines:**
        * Use for caching API responses, storing user preferences, or session data.
        * Interaction with Hive **must** be confined to the **Data Layer** (specifically in `LocalDataSource` classes). The rest of the app should not know Hive exists.

### Utilities

* **`fpdart`**
    * **Role:** Enables functional programming patterns, primarily for robust error handling.
    * **Guidelines:**
        * Repository methods in the Data Layer **must not** throw exceptions. They **must** return a `Future<Either<Failure, SuccessType>>`.
        * This forces the Application Layer to explicitly handle both failure and success states, preventing crashes and making the app more resilient.

* **`intl`**
    * **Role:** Handles internationalization (i18n) and localization (l10n), including date and number formatting.
    * **Guidelines:**
        * Do not hardcode any user-facing strings in the UI. All text must be accessed via localization delegates (e.g., `AppLocalizations.of(context)!.helloWorld`).

* **`url_launcher`** & **`permission_handler`**
    * **Role:** Interacts with external apps and device permissions.
    * **Guidelines:**
        * Wrap their usage within a dedicated service in the **Application Layer**. The UI should not call these plugins directly.
        * For `permission_handler`, always check for a permission status before requesting it, and be prepared to handle the case where the user permanently denies it.

### Testing

* **`mocktail`**
    * **Role:** The primary mocking library for writing unit and widget tests.
    * **Guidelines:**
        * Use `mocktail` to create mock implementations of repository interfaces when testing the Application Layer.
        * Use it to mock Application Layer services when writing widget tests for the Presentation Layer. This ensures tests are fast and isolated.
