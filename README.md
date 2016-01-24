# SomniAlert (WIP)
A beautiful UIAlertView-like modal made with swift

![](http://i.imgur.com/CZ9RS0A.png)

# Installation 
I have not created a CocoaPod yet, so this project will have to manually be downloaded from this repository. 

# Usage

Initialize the SomniAlert:

```swift
var alert = SomniAlert(frame: CGRect(), viewToSitOnTopOf: self.view)
```
Add the newly initialized alert to your view via the `addSubview` function:

```swift
// Add the alert to your view
self.view.addSubview(alert)
```

In order for the alert to fit any users device nicly, you need to call the `setContraint` function. Otherwise if you want a custom width and height, simply edit the frame during initalization and do not call this function.

```swift
alert.setConstraints()
```

When you want to diplay the alert call the `showAlert` function. You need to provide a type (Notification, Success, Failure, Trash) and a message. 

```swift
// Display the alert
alert.showAlert(typeOfAlert: .Notification, messageToDisplay: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc in dolor eget dolor cursus cursus a eu nisi. Proin vulputate, augue a hendrerit dignissim, lectus dolor ullamcorper mi, a commodo nisl neque eget ex. Curabitur porta id dolor ut tempus. Sed semper ")
```

#License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
