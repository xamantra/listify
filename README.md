# listify
<a href="https://flutter.dev/docs/development/tools/sdk/releases" target="_blank"><img src="https://img.shields.io/badge/flutter-1.17.0-blue"></a>
<a href="https://pub.dev/packages/momentum" target="_blank"><img src="https://img.shields.io/badge/momentum-1.1.7-blue"></a>
<a href="https://pub.dev/packages/relative_scale" target="_blank"><img src="https://img.shields.io/badge/relative_scale-1.0.7-blue"></a>
<a href="https://pub.dev/packages/shared_preferences" target="_blank"><img src="https://img.shields.io/badge/shared_preferences-^0.5.7+3-blue"></a>
<a href="https://pub.dev/packages/auto_size_text" target="_blank"><img src="https://img.shields.io/badge/auto_size_text-^2.1.0-blue"></a>
<a href="https://pub.dev/packages/flushbar" target="_blank"><img src="https://img.shields.io/badge/flushbar-^1.10.4-blue"></a>

A flutter todo/task listing example app with advanced state management using `Momentum` library. Simple on the outside but powerful in the inside. This app has a very simple look and feel. Just todo app but the state management with momentum makes it very powerful. This turned out as a convenient app because of persistent state + persistent navigation (continue where you left off).

- `Persistent State` - all state is persisted on the device. If you terminate the app and open it again, the states are retained including user inputs.
- `Persistent Navigation` - navigation between pages is persisted using momentum's powerful built-in router service. If you terminate the app and open it again, the page where you left off will be shown, and pressing the system back button navigates you to the correct previous page means navigation history is also persisted.
- `Equatable` - skip rebuilds if nothing actually changes. Theming is optimized with the help of equatable.
- `Undo/Redo` - undo/redo all inputs.
- `Create Copy` - create a copy of a list.
- `Edit/Delete` - in view mode, you can edit or delete a list.
- `Reorderable lists` - both lists and input items can be reordered. 
- `Search` - simple search feature on the home page.
- `App settings` - app options that are easily saved using momentum's persistent feature.
- `Draft inputs` - when the back button is pressed the inputs will be saved as a draft.

## Docs

I decided to not write comments inside the code because I always find it very distracting. Instead, in this readme, I listed most of the things you need to remember to get an idea of how this project works.
<!--TODO: link to official momentum docs-->

## Components
- `CurrentListController` & `CurrentListModel` - this is where the current list state is being stored. This is used in the `View List` page.
- `ListController` & `ListModel` - this is where the list data is validated for duplicates during adding of list, search list, `Home` page will display all list created, etc.
- `InputController` & `InputModel` - used in `Add New List` page and `Edit Existing List`. The inputs are handled and validated in this component. Undo/Redo feature is also handled here.
- `SettingsController` & `SettingsModel` - used in `Settings` page and also in some other pages to auto-apply settings.
- `ThemeController` & `ThemeModel` - this is where custom manual theming is handled. Because I'm not too familiar with flutter's theme object structure and props name I decided to do it manually. This is used on every page. This is only used in the root `MyApp()` to automatically apply the theme instead of restarting the app.

## Notes
- Some codes are not optimized like widgets that look almost similar can be merge as one widget and use parameters to make them dynamic like the `ListTile`s for example. I didn't have time for it :) Feel free to submit a pull request though.
- The theming will rebuild the entire widget tree but it is optimized because of equatable.
- The `ListifyTheme` theme class is not normalized. It has a lot of duplicate properties (same colors) because I thought I'll be able to implement a much more complex theming for this app. I'm leaving it as it is for now.

## Gallery
In this image the process was like this: Open the app (home page) -> go to *add list* page -> close and terminate on task view -> reopen the app again ... And magic happens! All the inputs were retained and not just that but also including the page where you left off.

![persistent preview](./gallery/001.png)

#### Dark Mode
Imagine an app without a dark mode. I can't so I added it into the app. Though, because I'm not familiar with the structure of `ThemeData` and its properties and not a designer type. I kinda did things manually with the help of momentum.

![dark mode](./gallery/002.png)