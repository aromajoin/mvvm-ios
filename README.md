### A sample app to demonstrate MVVM implementation in iOS

### MVVM architecture
MVVM (Model-View-ViewModel) is derived from MVC(Model-View-Controller).
It is introduced to solve existing problems of Cocoa's MVC architecture in iOS world.
One of its feature is to make a better seperation of concerns so that it is easier to maintain and extend.
* Model: It is simillar to `model` layer in MVC (contains data business logic)
* View: UIViews + UIViewControllers (We treat both layout view and controllers as View)
* ViewModel: A mediator to glue two above layer together.

An important point in MVVM is that it uses a binder as communication tool between View and ViewModel layers.
A technique named `Data Binding` is used. 

### Sample
A simple app which shows the most stared Github repositories written by Swift.

#### Libraries
* [Alamofire]() to perform HTTP requests under `Model` layer.
* [RxSwift + RxCocoa] to do "data binding" job which binds `ViewModel` and `View`
* [SwiftyJSON] to parse API response data
