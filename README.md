# EasterEggsAnimation

## Description
**EasterEggsAnimation** is a convenient way to decorate the entire screen of your application or a separate view by adding beautiful endless animation. This library allows you to add your own images, enable their animation, specify animation speed and conveniently set specific dates when this decorative addition will be displayed in your application. The library has the ability to conveniently integrate it both into a project written in **UIKit** and in **SwiftUI**.

https://github.com/idapgroup/EasterEggsAnimation/assets/82825922/e1fe03a7-0e67-476b-8a46-c3d1c208b437

## Usage example in UIKit
Below is an example of the most basic use of AnimatedView, where only an image is passed to the initializer as an argument

```swift
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animatedView = AnimatedView(patternImage: UIImage(named: "pattern"))
        animatedView.frame = self.view.bounds
        
        self.view.addSubview(animatedView)
        
        animatedView.animate()
    }
}
```
If necessary, you can specify one of the additional parameters - the speed of the animation or the date when the animation should be played:
```swift
let animatedView = AnimatedView(patternImage: UIImage(named: "pattern"), divider: 1500)
```
`patternImage` - image of UIImage type

**IMPORTANT**: to create the effect of an “endless” image, it is recommended to choose a so-called “pattern” as an image - an image that can be laid in tiles and it will dock with itself

`divider` - a number indicating which part of the side (height or width) of the parent view the picture will be shifted to the next time the frame is updated. Thus, the ***larger*** the number specified, the ***smaller*** the distance the image will be shifted on the next frame and, accordingly, the ***longer*** one animation cycle will be, i.e. the animation itself is ***slower***. The default number is 1000

```swift
let animatedView = AnimatedView(patternImage: UIImage(named: "pattern"), dates: ["2024/12/25"])
```

`dates` - an array of dates, presented as a string in the format `YYYY/MM/dd`. When you specify this parameter, AnimatedView content will only be displayed on the specified date. By default this array is empty and the contents are displayed on any day

**IMPORTANT**: to start animation, you must call the animemate() method as indicated in the example:
```swift
animatedView.animate()
```
Otherwise your image will appear static

## Usage example in SwiftUI
Below is an example of the most basic use of RepresentedAnimatedView, where only an image is passed to the initializer as an argument

```swift
import SwiftUI

struct ContentView: View {
    
    @State private var currentOfset = CGPoint(x: 0.0, y: 0.0)
    
    var body: some View {
        let animatedView = RepresentedAnimatedView(
            patternImage: UIImage(named: "pattern"),
            divider: 1500,
            dates: ["2024/02/13"],
            offset: self.$currentOfset
        )
        
        animatedView.animate()
        
        return ZStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()

            animatedView
                .ignoresSafeArea()
                .disabled(true)
        }
    }
}

#Preview {
    ContentView()
}
```
`RepresentedAnimatedView` has an initializer with four arguments, two of which are a divider and dates, which are optional.
```swift
let animatedView = RepresentedAnimatedView(patternImage: UIImage(named: "pattern"), divider: 1500, dates: ["2024/12/25", "2025/01/01"], offset: self.$currentOfset)
```
The purpose of the first three arguments is described above in the section on using the library in UIKit.

`offset` is a state variable of type SGPoint, which indicates the initial position of the image relative to its own frame (in most cases this is `CGPoint(x: 0.0, y: 0.0)`):
```swift
@State private var currentOfset = CGPoint(x: 0.0, y: 0.0)
```
**IMPORTANT**: to start animation on the created instance of `RepresentedAnimatedView`, call the animate() method as shown in the example above:
```swift
animatedView.animate()
```
**IMPORTANT**: to maintain the ability to interact with controls that are under the `RepresentedAnimatedView`, add the `.disabled` modifier, as indicated in the example above:
```swift
animatedView
    .ignoresSafeArea()
    .disabled(true)
```

## Requirements

iOS 15+, Swift 5.5

## Installation

**EasterEggsAnimation** is available through CocoaPods. To install it, simply add the following line to your Podfile:
```ruby
pod "EasterEggsAnimation"
```

## License

**EasterEggsAnimation** is available under the MIT license. See the LICENSE file for more info.
