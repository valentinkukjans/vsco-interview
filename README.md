# vsco-interview

**Apply architectural patterns MVVM and Clean Architecture**

**Repository Layer (Data Access)**

Repository is an abstract gateway for reading / writing data. Provides access to a single data service, be that a web server or a local database.
The Repository takes care of connecting your application to the outside world (be it the filesystem or an API), acting as the middleman.
Repository: Wrapping up all the database, networking and other data source handling logic. This only exposes the necessary public functions to ViewModels.
Repository returns data from a Remote Data (Network), Persistent DB Storage Source or In-memory Data (Remote or Cached).

The advantages of adding Repository Layer:
* Hiding the logic: The data fetching logic is hidden from the upper layer. ViewModel initializes the request and doesn’t have to care about where is the data come from.
* Easy to Test: All you have to do is create a mock data repository and mock the public functions as you need, that’s all.
* Easy to update: If you want to update the ORM model layer or update the logic, you don’t have to make changes on ViewModel logic as the data repository protocol doesn’t change

**ViewModel Layer(Business Logic)**

This is a typical dependency injection which we inject the data repository to ViewModel. By doing this, we decoupled the data layer and ViewModel layer. The logic functions are easier to test.
ViewModel: Dealing with all the logics, binding and exposing the observable values to ViewController. The updates made in ViewModel will show in ViewController automatically.

**View(Presentation)**
Presentation Layer contains UI (UIViewControllers or SwiftUI Views). Views are coordinated by ViewModels 

**MVVM**
The **Model-View-ViewModel** pattern (MVVM) provides a clean separation of concerns between the UI and Business Logic.
* View(Presentation) - Presentation Layer contains UI (UIViewControllers or SwiftUI Views). Views are coordinated by ViewModels
* Model - Responsible for the domain data
* ViewModel(Business Logic) - Owns Repository, ask for data. It is responsible for all business logic. It receives information from the ViewController.
* Repository(Data Access Layer) - Wrapping up all the database, networking and other data source handling logic. Provides access to a single data service. Repository returns data from a Remote Data (Network), Persistent DB Storage Source or In-memory Data (Remote or Cached).

The reasons I choose this architecture is:

MVVM and Clean Architecture provides a clean separation of concerns between the UI and Business Logic.
* Code reuse - we can easy reuse same Repositories or ViewModels in multiple places. Avoid duplication of code.
* Testing - We can test isolated each component, with dependency injection, mock all dependencies.
* Code decoupling - View doesn't know about Repository(Data Access Layer), ViewModel(Business Logic) doesn't know about networking layer, and so on.
* Single Responsibility - All components have a single responsibility.
* Scalability - In large team, multiple developers can work on same module/component. Easy add new feature, ability to scale up.
* Dependency Injection - Separation of concerns, provide easy mechanism of mocking through the protocols.
* Reduced complexity - All ViewController/View is now much simpler, zero logic.

Next steps to add:

Add abstraction around collection view data source, for reuse\
Restore search with UIUserActivityRestoring\
Debouncer\
UISearchSuggestion\
Scope bar to help people refine the scope of a search\
Spotlight\
Pull to refresh\
Orientations trait change support\ 
Dynamic font\
Accessibility\
Analytics\ 
Background fetch (Background Assets)\
Prefetch images (UICollectionViewDataSourcePrefetching)\
Segmentation of search, suggestions, recent search, autocomplete\
Cache search results for query (NSCache, Disk, CoreData)\
Persistence (SQLite/CoreData/Realm)\ 
Localization\
Error handling\
Offline support\
Handle/store sensitive data in Keychain\
Dark mode\
More tests (UI)


