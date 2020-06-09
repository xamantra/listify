# listify
`flutter-1.17.0`

A flutter todo/task listing example app with advance state management using `Momentum` library. Simple on the outside but powerful in the inside. This app has very simple look and feel really just todo app but the state management with momentum makes it very powerful. This actually turned out as a convenient app because of persistent state + persistent navigation (continue where your left off).

- `Persistent State` - all state is persisted on the device. If you terminate the app and open it again, the states are retained.
- `Persistent Navigation` - navigation between pages is persisted using momentum's powerful built-in router service. If you terminate the app and open it again, the page where you left off will be shown and pressing system back button actually navigates you to the correct previous page means navigation history is also persisted.
- `Equatable` - skip updates if nothing actually changes.
- `Undo/Redo` - undo/redo all inputs.
- `Create Copy` - create a copy of a list.
- `Edit/Delete` - in view mode, you can edit or delete a list.
- `Reorderable lists` - both lists and input items can be reordered. 
- `Search` - simple search feature in home page.
- `App settings` - app options which are easily saved using momentum's persistent feature.
- `Draft inputs` - when back button is pressed the inputs will be saved as draft.

## Docs

I decided to not write comments inside the code because I always find it very distracting. Instead, in this readme I listed most of the things you need to remember to get an idea of how momentum works.
- To begin with, the state or the data is called `MomentumModel` and the logic class where you put the functions is `MomentumController`
- `model.update(...)` - always remember that this is a `setState(...)` in momentum. And it's not only for rebuilding widgets but also for syncing values (eg. user inputs) into the model for later uses like form submission.
- `MomentumBuilder` - this is momentum's widget for displaying the model values. Rebuilds are triggered using `model.update(...)`.
- `sendEvent(...)` - this feature was added recently. It is used for sending event data to the widgets. In this example app, it is mostly used for showing dialog, snackbar messages and navigation to other pages.
- `.listen<T>(...)` - a partner of `sendEvent`. Used inside widgets to receive the event data and do something with it (show dialogs/snackbars/page navigation/etc).
- `Router` - momentum's custom router for persistent navigation state. `Router.pop(context)` is for going back from previous page and `Router.goto(context, WidgetTypeHere)` is for going to specific page. And again, with the `goto` method here we are passing a *type* not an instance or a string route name.
- `main.dart` - I would like you to take a look on the `main.dart` file of this project. There are a lot of things going on in this file alone.
    - `Momentum` - If you are looking at the code right now, you'll see that this class is set as the root widget of the app. That is how you do it with momentum.
    - `controllers` - this is the parameter for injecting the controllers to be used down the tree. You inject instances here then access them using *types* down the tree.
    - `maxTimeTravelSteps` - a config parameter for controllers for enabling undo/redo feature. In this app it's currently used in `InputController`. It is enabled if the value is greater than `1`, otherwise it is disabled. And it is disabled by default.
    - `services` - inject any types of dependencies to be used down the tree. Example is `SharedPreference` instance. Instead of instantiating an instance of it multiple times down the tree you can instead inject it in this parameter and reuse only one, the same instance across the app. PS: `Router` class is a built service with momentum.
    - `persistSave` - The function parameter for saving state with any storage library you want. This app currently uses shared preference. Good thing is that key and value is already provided by momentum as parameter which you can directly access and easily call `sharedPref.setString(key, value)`. The same thing with:
    - `persistGet` - The function parameter for getting cached state with any storage library you want.
    - `Router.getActivePage(context)` - You'll also see this code inside `MyApp` class as the `home:` parameter value. `getActivePage` returns a widget which is the page where you left off (terminate the app). This is part of persistent navigation feature with momentum.
    - **NOTE:** `persistSave` and `persistGet` is used for saving and getting data so if both is not specified momentum will not persist any navigation or any state. And both of these functions require valid `toJson` and `fromJson` implementation on the model classes.

### Components
- `CurrentListController` & `CurrentListModel` - this is where the current list state is being stored. This is used in View List page.
- `ListController` & `ListModel` - this is where the list data is validated for duplicates during adding of list, search list, display all list created in home page, etc.
- `InputController` & `InputModel` - used in `Add New List` page and `Edit Existing List`. The inputs are handled and validated in this component. Undo/Redo feature is also handled here.
- `SettingsController` & `SettingsModel` - used in settings page and also in some other pages to auto apply settings.
- `ThemeController` & `ThemeModel` - this is where custom manual theming is handled. Because I'm not too familiar with flutter's theme object structure and props name I decided to do it manually. This is used in every page.

There are still plenty of things that wasn't mentioned here especially one liner codes. But inside this app's code, you can just hover over the method or class names for momentum documentation.

Some codes are not optimize like widgets that looks almost similar can be merge as one widget and use parameters to make them dynamic like the `ListTile`s for example. I really didn't have time for it :) Feel free to submit a pull request though.

## Gallery
In this image the process were like this: Open app (home page) -> go to *add list* page -> close and terminate on multitask view -> reopen the app again ... And magic happens! All the inputs were retained and not just that but also including the page where you left off.

![persistent preview](./gallery/001.png)

#### Dark Mode
Imagine an app without a dark mode. I can't so I added it into the app. Though, because I'm not familiar with the structure of `ThemeData` and its properties and not really a designer type. I kinda did things manually with the help of momentum.

![dark mode](./gallery/002.png)