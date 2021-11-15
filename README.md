# MultipleDragAndDrop
Demonstrates having multiple .onDrop modifiers in SwiftUI does not work.

**Feedback ID:** FB9759588

**System Info:**
* Xcode 13.1 (13A1030d)
* iPad Pro 11 (2018, iOS 15.1)


**Reproduction steps:**
1. Run app on iPad in landscape
2. In "color" mode you are able to drag and drop a color to change the squares background color
3. In "text" mode you are able to drag and drop text to change the squares title
4. In "multi" mode you are able to drag a color OR text to change the squares background color OR title
5. In "broken" mode you are able to drag a color OR text to change the squares background color OR title.


**Actual Results:**
In steps 2-4 everything works as expected. Step 5 does not work. Only color dropping is working- text is ignored. This is because this mode has multiple .onDrop modifiers on the view.


**Expected Results:**
Step 5 should work the same as step 4. SwiftUI views should be able to accept multiple drop modifiers.


**Notes:**
- Messages is a good app to drag text from.
- [Pastel](https://apps.apple.com/us/app/pastel/id413897608) is a good free app to drag colors from.


<img src="https://github.com/Rspoon3/MultipleDragAndDrop/blob/main/screenshot.jpg" width="600">
