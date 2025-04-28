# To Do List Application

A robust iOS task management application built with Swift and CoreData, implementing the Model-View-Presenter (MVP) architectural pattern. This application allows users to organize tasks within different categories, create new categories and tasks, mark tasks as completed, and delete tasks.

## Features

- **Category Management**: Create and view different categories for your tasks
- **Task Management**: Create, update status, and delete tasks within categories
- **Intuitive UI**: Clean interface with visual indicators for task completion status
- **Persistent Storage**: All data is persistently stored using CoreData

## App Usage

1. **Main Screen (Lists)**:
   - View all your task categories
   - Add new categories using the "+" button
   - Tap on any category to see tasks within it

2. **Category Details Screen (Items)**:
   - View all tasks within the selected category
   - Add new tasks using the "+" button
   - Tap on a task to toggle its completion status
   - Swipe left on a task to delete it

## Architecture Overview

The application implements the MVP (Model-View-Presenter) design pattern to create a maintainable, testable application with clear separation of concerns.

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

4. **Dependency Injection Container**: Manages dependencies and their lifecycle
   - Centralizes dependency creation and configuration
   - Provides appropriate dependencies to components
   - Ensures singletons are properly implemented

### Directory Structure

```
To Do List/
├── DataManager/
│   ├── CoreDataManager.swift       # CoreData implementation of DataManagerProtocol
│   ├── DependencyContainer.swift   # Dependency injection container
│   └── To_Do_List.xcdatamodeld     # CoreData model with Item and Category entities
├── Model/
│   └── (CoreData generated models)
├── Protocols/
│   └── MVPProtocols.swift          # All protocols defining MVP contracts
├── Presenters/
│   ├── ListPresenter.swift         # Presenter for list screen
│   └── ItemPresenter.swift         # Presenter for item screen
├── View/
│   ├── ListViewController.swift    # View controller for categories
│   └── ItemViewController.swift    # View controller for items
└── Supporting Files/
    ├── AppDelegate.swift           # Application delegate
    ├── SceneDelegate.swift         # Scene lifecycle management
    ├── Assets.xcassets/            # Image assets
    └── Base.lproj/                 # Storyboards and XIBs
```

## Technical Implementation

### Data Model

The application uses CoreData with two main entities:

1. **Category**:
   - title: String - The name of the category
   - items: Relationship - One-to-many relationship with Item entities

2. **Item**:
   - title: String - The name of the task
   - done: Boolean - Completion status of the task
   - parentCategory: Relationship - Many-to-one relationship with Category entity

### Dependency Injection

The application implements a simple dependency injection container (DependencyContainer) that:

- Provides a centralized place to create and configure dependencies
- Ensures CoreDataManager is a singleton throughout the application
- Makes the application more testable by allowing mock implementations
- Decouples components, making them more maintainable

### Protocol-Oriented Design

The application extensively uses protocols to define contracts between layers:

- **DataManagerProtocol**: Defines data operations for the Model layer
- **ListViewProtocol/ItemViewProtocol**: Define view operations for the View layer
- **ListPresenterProtocol/ItemPresenterProtocol**: Define presenter operations

This approach enhances testability and allows for easy replacement of implementations.

## Benefits of the MVP Architecture

1. **Separation of Concerns**: Clear separation between UI, business logic, and data access
2. **Testability**: Presenters are easily testable with mock views and models
3. **Maintainability**: Changes to one component have minimal impact on others
4. **Reusability**: Components can be reused across different views
5. **Scalability**: Easy to add new features without modifying existing code

## Future Improvements

1. **Unit Testing**: Implement comprehensive unit tests for Presenters and Models
2. **UI/UX Enhancements**: Improve visual design and user experience
3. **Advanced Features**: Add task due dates, priorities, and notifications
4. **Search Functionality**: Implement search across tasks and categories
5. **Error Handling**: Add proper error handling throughout the application
6. **Advanced DI**: Implement dependency injection with a proper DI framework
7. **Multiple Storage Options**: Add persistence layer abstraction to support multiple storage options
8. **Sync Capabilities**: Add cloud synchronization features

## App Demo


https://github.com/user-attachments/assets/b1c9f421-bf7b-47d9-8d45-71ed10194700


