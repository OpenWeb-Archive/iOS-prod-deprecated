![Spotim: Spot.IM iOS SDK](https://github.com/SpotIM/iOS-prod/blob/master/SpotQAApp/Resources/iOS_SDK_BIG.jpg)

## Welcome to the Spot.IM SDK      ![CocoaPods Compatible](https://img.shields.io/cocoapods/v/SpotIM.svg) [![Platform](https://img.shields.io/cocoapods/p/SpotIM.svg)](https://github.com/SpotIM/iOS-prod)

Spot.IM SDK provides an easy integration with [Spot.IM](http://www.spot.im) into a native iOS app. 

Here's a sample app that shows how to use the Spot.IM SDK for iOS.

## Conversation Preview
<img src="https://user-images.githubusercontent.com/607917/35287552-4259dc5a-006b-11e8-9a27-c14b37a5a32b.png" width="280"/> .   <img src="https://user-images.githubusercontent.com/607917/35287547-4076605c-006b-11e8-9674-a1c9e4f8f681.png" width="280"/> .   <img src="https://user-images.githubusercontent.com/607917/35287551-423452be-006b-11e8-96e9-7bf7a3ae27b6.png" width="280"/> 

## Getting started

To use the SDK you will need an active Spot.IM account. If you don't have it, get one [here](http://www.spot.im).  
You will need to know your Spot ID (which looks like 'sp_xxxxxxx'). 
If you don't know your Spot ID, login to the [admin dashboard](https://admin.spot.im) and have a look at the URL.

## POD Installation

SpotIM is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SpotIM'
```
and then Running:

```ruby
pod install
```
Or if you prefer the old-school way:

## Manually Adding the SDK to an existing XCode project

1. Download the [Spot_IM.framework Universal](https://github.com/SpotIM/iOS-prod/files/1677802/Spot_IM.framework.zip) (for  development and compiling on any device + simulator).
2. Unzip, Drag the Framework into your Project's directory, and then into the xCode Project.
3. Choose the project and the target, and in the `Embedded Binaries` click on the `+` sign.
4. Click on the `add Other..`.
5. Choose the `Spot_IM.framework` file and select `Copy items if needed`.

![alt text](https://cloud.githubusercontent.com/assets/2345998/22945428/ddfad650-f2fc-11e6-8f28-e6c10af65ea3.png)


## Using the SDK
If you are using swift you will need to add
[Bridging header](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html).

Here is a simple explanation on how to add a Bridging header:

[Manually add a Bridging header] (https://mycodetips.com/ios/manually-adding-swift-bridging-header-1290.html).

the .h file should now include the following lines:

```
#import <Spot_IM/Spot_IM.h>
```

### Spot.IM Conversation

In the `AppDelegate`, initialize the SDK with your Spot ID ('sp_xxxxxxxx'):

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SpotConversation.shared().spotId = "sp_xxxxxxxx"
        return true
    }
```

In the view controller which should present the convesation view, add:

```swift
override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        SpotConversation.shared().frame = CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 64)
        self.view.addSubview(SpotConversation.shared())
        SpotConversation.shared().postId = "12345" // The item's ID
        SpotConversation.shared().presentingController = self
    }
```

### Set Messages Count

If you want to present specific amount of messages you can set it:
``` swift
    SpotConversation.shared().messages = 8
```

### IFrame Handler

If you want to present Spot IM conversation when user will click on Spot IM's iframe in your webview, you should use `SpotConversationIFrameHandler` :

``` swift
    func registerSpotIframeHandler() {
        self.handler = SpotConversationIFrameHandler()
        self.handler.spotIFrameWebview = webview
        self.handler.delegate = self
    }

    // ConversationIFrameDelegate
    func shouldLoadSpotConversation(_ controller: SpotConversationViewController!) {
        self.present(controller, animated: true, completion: nil)
    }
``` 

When the user will click on the SpotIM's iframe the delegate will be triggered and you can present the `SpotConversationViewController`


### SSO (Single Sign On)

In order to use the SSO, your account must be SSO-enabled. If you'd like to enable SSO on your account, please contact support@spot.im.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    SpotConversation.shared().ssoDelegate = self
}

// Delegate 
func spotConversation(_ spotConversation: SpotConversation!, didUpdateState isLoggedIn: Bool) {
        // Update the UI according to the isLoggedIn state
}

func logoin() -> Void {
    SpotConversation.shared().startSSO(handler: { (codeA: String?, error: Error?) in
                if codeA != nil {
                    // Fetch the code B params from your server
                    let codeB: String = ...
                    if codeB != nil {
                        SpotConversation.shared().completeSSO(test, completion: { (error: Error?) in
                            if error == nil {
                                // update your UI 
                            } else {
                                // Handle the error with codeB
                            }
                        })
                    }
                } else if codeA == nil && error == nil {
                    // Already logged in
                } else {
                    // Handle error 
                }
            })
}

func logout() -> Void {
    SpotConversation.shared().logoutSSO(completion: { 
                // Update the UI
            })
}
```

### Spot.IM "Popular In the Community" Carousel
In desired view controller, add:

```swift
var spotController: SpotIMController!


override func viewDidLoad() {
        super.viewDidLoad()
        spotController = SpotIMController.init()
        spotController.view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 452)
        spotController.spotId = "sp_xxxxxxxx" // your Spot ID
        spotController.configuration.title = "Title"
        let cell: UITableViewCell = self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0))!
        cell.contentView.addSubview(spotController.view)
    }
    
    
    
    // Handle Rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (context) in
            self.spotController.view.frame = CGRect.init(origin: CGPoint.init(), size: CGSize.init(width: size.width, height: 452.0))
        }) { (context) in
            
        }
    }
```

## Appstore Submission
- If you Installed the SDK via Cocoapods, then you are free to skip this section.

- If you Installed the SDK Manually, you will have to add this Script to remove the Simulator Slice of the SDK (You probably already have this Script if you are using other Universal frameworks)

Add this to the build phase:

(Credit for the script to Daniel Kennett: http://ikennd.ac/blog/2015/02/stripping-unwanted-architectures-from-dynamic-libraries-in-xcode/)

```bash

APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"

# This script loops through the frameworks embedded in the application and
# removes unused architectures.
find "$APP_PATH" -name '*.framework' -type d | while read -r FRAMEWORK
do
    FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
    FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"
    echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"

    EXTRACTED_ARCHS=()

    for ARCH in $ARCHS
    do
        echo "Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME"
        lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
        EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
    done

    echo "Merging extracted architectures: ${ARCHS}"
    lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
    rm "${EXTRACTED_ARCHS[@]}"

    echo "Replacing original executable with thinned version"
    rm "$FRAMEWORK_EXECUTABLE_PATH"
    mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

done

```

## License

the Spot.IM SDK is released under a custom license based on MIT. [See LICENSE](https://github.com/SpotIM/iOS-prod/blob/master/LICENSE) for details.

## Support

Feedback and inquires can be sent to love@spot.im
