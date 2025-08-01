<a href="https://exyte.com/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/exyte/media/master/common/header-dark.png"><img src="https://raw.githubusercontent.com/exyte/media/master/common/header-light.png"></picture></a>

<a href="https://exyte.com/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/exyte/media/master/common/our-site-dark.png" width="80" height="16"><img src="https://raw.githubusercontent.com/exyte/media/master/common/our-site-light.png" width="80" height="16"></picture></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://twitter.com/exyteHQ"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/exyte/media/master/common/twitter-dark.png" width="74" height="16"><img src="https://raw.githubusercontent.com/exyte/media/master/common/twitter-light.png" width="74" height="16">
</picture></a> <a href="https://exyte.com/contacts"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/exyte/media/master/common/get-in-touch-dark.png" width="128" height="24" align="right"><img src="https://raw.githubusercontent.com/exyte/media/master/common/get-in-touch-light.png" width="128" height="24" align="right"></picture></a>

<p float="left">
  <img src="https://raw.githubusercontent.com/exyte/media/master/ScalingHeaderScrollView/1.gif" width="200" />
  <img src="https://raw.githubusercontent.com/exyte/media/master/ScalingHeaderScrollView/2.gif" width="200" /> 
  <img src="https://raw.githubusercontent.com/exyte/media/master/ScalingHeaderScrollView/3.gif" width="200" />
</p>
<p><h1 align="left">Scaling Header Scroll View</h1></p>

<p><h4>A scroll view with a sticky header which shrinks as you scroll. Written with SwiftUI.</h4></p>

<a href="https://exyte.com/blog/swiftui-tutorial-scaling-header">Read Article »</a>

![](https://img.shields.io/github/v/tag/exyte/ScalingHeaderScrollView?label=Version)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fexyte%2FScalingHeaderScrollView%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/exyte/ScalingHeaderScrollView)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fexyte%2FScalingHeaderScrollView%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/exyte/ScalingHeaderScrollView)
[![SPM](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg)](https://swiftpackageindex.com/exyte/ScalingHeaderScrollView)
[![Cocoapods](https://img.shields.io/badge/Cocoapods-Deprecated%20after%201.1.4-yellow.svg)](https://cocoapods.org/pods/ScalingHeaderScrollView)
[![License: MIT](https://img.shields.io/badge/License-MIT-black.svg)](https://opensource.org/licenses/MIT)

# Usage
1. Put your header and content bodies code into a ScalingHeaderScrollView constructor.     
2. Set the necessary modifiers, see below.      
```swift
struct ContentView: View {

    var body: some View {
       ScalingHeaderScrollView {
            ZStack {
                Rectangle()
                    .fill(.gray.opacity(0.15))
                Image("header")
            }
        } content: {
            Text("↓ Pull to refresh ↓")
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
```

## TabView won't work

Please note that `ScalingScrollview` is just a `ScrollView` under the hood, so it works very similar to it. If content's height changes between tabs inside the scroll view, there is no way to keep scroll position nice and stable. Usually when using a `TabView`, you put separate `ScrollView`s on every tab, not the other way around. And if you were to put a `TabView` inside a `ScrollView`, it wouldn't work as you expect, and neither will putting it inside a `ScalingScrollview`.  

Moreover, `TabView` gives almost no control over itself (getting/setting its current position, getting tab's content height, etc.), so there is no way to manually mess with its `scrollOffset`, which is what this library relies heavily upon.  

### Required parameters 
`header` - `@ViewBuilder` for your header  
`content` - `@ViewBuilder` for your content  

### Available modifiers, optional  
passes current collapse progress value into progress binding: 0 for not collapsed at all, 1 - for fully collapsed       
```swift
.collapseProgress(_ progress: Binding<CGFloat>)
```

allows to set up callback for ScrollView reaching the bottom     
```swift
.scrollViewDidReachBottom(perform: @escaping () -> Void)
```

allows to set up an action for pull-to-refresh; if not set up loading indicator on pull-to-refresh will never be displayed
```swift
.pullToRefresh(isActive: Bool, perform: () async -> Void)
```
`isActive` - dynamically enable/disable pull-to-refresh, if disabled, loading indicator won't be displayed on pull-to-refresh   
`perform` - async closure to be performed on pull-to-refresh, after the closure is done loading indicator will be hidden automatically     
 
allows to set up an action for pull-to-load-more; if not set up loading indicator on pull-to-load-more will never be displayed
```swift
.pullToLoadMore(isActive: Bool, contentOffset: CGFloat, perform: () async -> Void)
```
`isActive` - dynamically enable/disable pull-to-load-more, if disabled, loading indicator won't be displayed on pull-to-load-more   
`contentOffset` - padding value of the content from the bottom edge when pull-to-load is active    
`perform` - async closure to be performed on pull-to-load-more, after the closure is done loading indicator will be hidden automatically   

 allows content scroll reset, need to change Binding to `true`  
```swift
.scrollToTop(resetScroll: Binding<Bool>)
```

 allows to change current header height, need to change state, possible values are .collapsed, .expanded or .custom(CFGloat)
```swift
.snapHeaderToState(state: Binding<SnapHeaderState?>, animated: Bool)
```

 changes min and max heights of Header, default `min = 150.0` and `max = 350.0`  
```swift
.height(min: CGFloat = 150.0, max: CGFloat = 350.0)
```

when scrolling up - switch between actual header collapse and simply moving it up (by default moving up)
```swift
.allowsHeaderCollapse()
```

when scrolling down - enable (disabled by default) header scale    
```swift
.allowsHeaderGrowth()
```

Enable/disable (disabled by default) header snap. Available modes:
- `.disabled` - Disable header snap.
- `.immediately` - Once you lift your finger header snaps either to min or max height automatically.
- `.afterFinishAccelerating` - At the end of scroll view deceleration the header snaps either to min or max height automatically.
```swift
.setHeaderSnapMode(.immediately)
```

Set custom positions for header snap (explained previous point). Specify any amount of values in 0...1 to set snapping points, 0 - fully collapsed header, 1 - fully expanded  
```swift
.headerSnappingPositions(snapPositions: [CGFloat])
```

Set custom initial position to which scroll view will be automatically snapped to. Specify a value in 0...1, 0 - fully collapsed header, 1 - fully expanded  
```swift
.initialSnapPosition(initialSnapPosition: CGFloat)
```

hide scroll indicators (false by default)  
```swift
.hideScrollIndicators()
```

## Examples

To try the ScalingHeaderScrollView examples:
- Clone the repo `https://github.com/exyte/ScalingHeaderScrollView.git`
- Open `ScalingHeaderScrollViewExample.xcodeproj` in the Xcode
- Try it!

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

```swift
dependencies: [
    .package(url: "https://github.com/exyte/ScalingHeaderScrollView.git")
]
```

## Requirements

* iOS 14+
* Xcode 12+ 

## Our other open source SwiftUI libraries
[PopupView](https://github.com/exyte/PopupView) - Toasts and popups library    
[AnchoredPopup](https://github.com/exyte/AnchoredPopup) - Anchored Popup grows "out" of a trigger view (similar to Hero animation)  
[Grid](https://github.com/exyte/Grid) - The most powerful Grid container     
[AnimatedTabBar](https://github.com/exyte/AnimatedTabBar) - A tabbar with a number of preset animations   
[MediaPicker](https://github.com/exyte/mediapicker) - Customizable media picker     
[Chat](https://github.com/exyte/chat) - Chat UI framework with fully customizable message cells, input view, and a built-in media picker  
[OpenAI](https://github.com/exyte/OpenAI) Wrapper lib for [OpenAI REST API](https://platform.openai.com/docs/api-reference/introduction)    
[AnimatedGradient](https://github.com/exyte/AnimatedGradient) - Animated linear gradient     
[ConcentricOnboarding](https://github.com/exyte/ConcentricOnboarding) - Animated onboarding flow    
[FloatingButton](https://github.com/exyte/FloatingButton) - Floating button menu    
[ActivityIndicatorView](https://github.com/exyte/ActivityIndicatorView) - A number of animated loading indicators    
[ProgressIndicatorView](https://github.com/exyte/ProgressIndicatorView) - A number of animated progress indicators    
[FlagAndCountryCode](https://github.com/exyte/FlagAndCountryCode) - Phone codes and flags for every country    
[SVGView](https://github.com/exyte/SVGView) - SVG parser    
[LiquidSwipe](https://github.com/exyte/LiquidSwipe) - Liquid navigation animation    
