# listify

A flutter todo/task listing app with advance state management using `Momentum` library.

- `Persistent State` - all state is persisted on the device. If you terminate the app and open it again, the states are retained.
- `Persistent Navigation` - navigation between pages is persisted using momentum's powerful built-in router service. If you terminate the app and open it again, the page where you left off will be shown and pressing system back button actually navigates you to the correct previous page means navigation history is also persisted.
- `Equatable` - skip updates if nothing actually changes.
- `Undo/Redo` - undo/redo all inputs including deletion of lists and list items.
- `Create Copy` - create a copy of a list.
- `Reorderable lists` - both lists and input items can be reordered. 
- `App settings` - easily saved using momentum's persistent feature.
- `Draft inputs` - when system back button is pressed the inputs will be saved as draft.