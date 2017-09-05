# Manual integration example for iOS

Integrating Bugsnag manually requires adding the Xcode projects for Bugsnag and
KSCrash to your project/workspace to build and link the required dynamic
libraries.

[Here is the integration guide for manual installation](https://docs.bugsnag.com/platforms/ios/#manual-installation)

Steps followed to integrate Bugsnag for this project:

1. Open Xcode and select `File > "Add files to bugsnag-example"` from the menu
2. Select `bugsnag-cocoa/iOS/Bugsnag.xcodeproj` from the file picker
3. Repeat for `Carthage/Checkouts/KSCrash/iOS/KSCrash-iOS.xcodeproj`
4. Select the bugsnag-example project in the Project Navigator, then select the
   target named `bugsnag-example`
5. Add `Bugsnag.framework` and `KSCrash.framework` to the "Embedded Binaries"
   section (which should also add it to the "Linked Frameworks and Libraries"
   section)

To test this project, add a Bugsnag API key to `AppDelegate.swift`. Run the
project and press "Crash App" to send a sample crash report.
