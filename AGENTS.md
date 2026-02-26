# AGENTS.md

## Cursor Cloud specific instructions

### Project Overview

This is **ChinaMap**, a small iOS demo app written in **Objective-C** that renders an interactive map of China's 34 provincial-level administrative regions using `UIBezierPath`. Users tap provinces to highlight them with a random color. The map data is loaded from bundled `.plist` files.

- **Platform:** iOS (iPhone), deployment target iOS 10.1
- **Build system:** Xcode project (`Testing/Testing.xcodeproj`), no CocoaPods/SPM/Carthage
- **Language:** Objective-C (with Swift bridging header configured but unused)
- **External dependencies:** None

### Critical: macOS + Xcode Required

This project **cannot be fully built or run on Linux**. It requires:
- **macOS** with **Xcode 8.1+** (the project uses Xcode 8.1 project format)
- **iOS Simulator** or physical iOS device for running/testing

On Linux, limited static analysis is possible using `clang` + `GNUstep` + UIKit stub headers. However, `ChinaMapWithName.m` will produce expected errors due to GNUstep not supporting Apple-specific Objective-C extensions (auto-synthesized ivars, lightweight generics, keyed subscripting, `__weak` references).

### Partial Syntax Checking on Linux

If you need to verify Objective-C syntax on this Linux VM (with GNUstep installed):

```sh
OBJC_FLAGS=$(gnustep-config --objc-flags)
clang -fsyntax-only -x objective-c $OBJC_FLAGS \
  -I/usr/lib/gcc/x86_64-linux-gnu/13/include \
  -I/tmp/uikit-stubs \
  -I/workspace/Testing/Testing \
  -I/workspace/Testing/ChinaProvincialMap \
  -fblocks -Wno-macro-redefined -Wno-objc-property-implementation \
  <source_file.m>
```

UIKit stub headers must exist at `/tmp/uikit-stubs/UIKit/UIKit.h` and `/tmp/uikit-stubs/CoreGraphics/CoreGraphics.h`. These are recreated during setup and are NOT committed to the repo.

### Project Structure

```
Testing/
├── Testing.xcodeproj/     # Xcode project config
├── Testing/               # Main app source
│   ├── AppDelegate.h/.m   # App lifecycle
│   ├── ViewController.h/.m # Main view controller (adds ChinaMapWithName to view)
│   ├── FpsLabel.h/.m      # FPS counter utility (unused in current demo)
│   ├── main.m             # Entry point
│   ├── Info.plist          # App configuration
│   └── Base.lproj/        # Storyboards
└── ChinaProvincialMap/    # Map rendering component
    ├── ChinaMapWithName.h/.m  # Core map view (UIBezierPath drawing)
    └── resouse/               # Bundled plist data files
        ├── ChinaMapPaths.plist     # Serialized UIBezierPath data for provinces
        └── ProvincialName.plist    # Province names and label positions
```

### No Automated Tests or Linter

The project has no test targets, no linter configuration, and no CI/CD setup. Testing is entirely manual via the iOS Simulator.
