# To Do List Application - MVP Architecture

This project implements the Model-View-Presenter (MVP) design pattern to create a maintainable, testable to-do list application.

## Architecture Overview

### MVP Components

1. **Model**: Represents the data and business logic of the application
   - CoreData entities (Item, Category)
   - DataManager protocols and implementations

2. **View**: Responsible for displaying data to the user and handling user interactions
   - View Controllers (ListViewController, ItemViewController)
   - Implement ViewProtocols to communicate with Presenters

3. **Presenter**: Acts as a mediator between Model and View
   - Contains the presentation logic
   - Updates the View when Model changes
   - Handles user interactions forwarded by the View

### Directory Structure

```
To Do List/
├── DataManager/
│   ├── CoreDataManager.swift       # Data access layer implementation
│   ├── DependencyContainer.swift   # Dependency injection container
│   └── To_Do_List.xcdatamodeld     # CoreData model
├── Models/
│   └── (CoreData generated models)
├── Protocols/
│   └── MVPProtocols.swift          # Protocols for MVP architecture
├── Presenters/
│   ├── ListPresenter.swift         # Presenter for list screen
│   └── ItemPresenter.swift         # Presenter for item screen
└── View/
    ├── ListViewController.swift    # View controller for lists
    └── ItemViewController.swift    # View controller for items
```

## Benefits of MVP

1. **Separation of Concerns**: Clear separation between UI, business logic, and data access
2. **Testability**: Presenters are easily testable with mock views and models
3. **Maintainability**: Changes to one component have minimal impact on others
4. **Reusability**: Components can be reused across different views

## Future Improvements

1. Implement unit tests for Presenters
2. Add proper error handling throughout the application
3. Implement dependency injection with a proper DI framework
4. Add persistence layer abstraction to support multiple storage options 