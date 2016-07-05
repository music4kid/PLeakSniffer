## PLeakSniffer

We are building controllers most of the time, memory leaks happen within controllers.
Retain cycle stops controller from being released, UIView objects within controllers somehow
get held by other objects, PLeakSniffer shows its value in such circumstances, it provides
suggestions, but guarantees nothing.

**It is your duty to set a breakpoint in the suspicous object's
dealloc, and reveal the only truth.**

## Capability

PLeakSniffer can help detect memory leaks, including UIViewController, UIView, and all custom Properties. 
It provides suggestions with suspicious objects, prints a log message in the console like:

Detect Possible Controller Leak: %@

Detect Possible Leak: %@

## Installation

**Plan A:**

clone this repo, copy classes under PLeakSniffer folder into your project.

**Plan B:**

PLeakSniffer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PLeakSniffer"
```

## How to use

```
#if MY_DEBUG_ENV
[[PLeakSniffer sharedInstance] installLeakSniffer];
#endif

```

make sure you embed PLeakSniffer with debug macro, do not bring it to online users.

## License

PLeakSniffer is available under the MIT license. See the LICENSE file for more info.
