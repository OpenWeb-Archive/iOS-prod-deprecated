![Spotim: Spot.IM iOS SDK](https://github.com/SpotIM/iOS-prod/blob/master/SpotQAApp/Resources/iOS_SDK_BIG.jpg)

## Welcome to the Spot.IM SDK 

Spot.IM SDK provides an easy integration with [Spot.IM](http://www.spot.im) into a native iOS app. 

Here's a sample app that shows how to use the Spot.IM SDK for iOS.

## Getting started

To use the SDK you will need an active Spot.IM account. If you don't have it, get one [here](http://www.spot.im).  
You will need to know your Spot ID (which looks like 'sp_xxxxxxx'). 
If you don't know your Spot ID, login to the [admin dashboard](https://admin.spot.im) and have a look at the URL.

## Adding the SDK to an existing XCode project

1. Download the [Spot_IM.framework Universal](https://github.com/SpotIM/iOS-prod/files/1639390/Spot_IM.framework.zip) (for  development and compiling on any device + simulator).
2. _For app submission_ you should use the release version [Release Version](https://github.com/SpotIM/iOS-prod/files/1639377/Spot_IM.framework.zip). (you MUST use this version to submit your app to the Appstore)
3. Unzip, Drag the Framework into your Project's directory, and then into the xCode Project.
4. Choose the project and the target, and in the `Embedded Binaries` click on the `+` sign.
5. Click on the `add Other..`.
6. Choose the `Spot_IM.framework` file and select `Copy items if needed`.

![alt text](https://cloud.githubusercontent.com/assets/2345998/22945428/ddfad650-f2fc-11e6-8f28-e6c10af65ea3.png)


## Using the SDK
If you are using swift you will need to add
[Bridging header](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html).

Here is a simple explanation on how to add a Bridging header:

[Manually add a Bridging header] (https://mycodetips.com/ios/manually-adding-swift-bridging-header-1290.html).

the .h file should now include the following lines:

'''
#import <Spot_IM/Spot_IM.h>
''''

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

## Conversation Preview

<img src="https://user-images.githubusercontent.com/607917/35106483-002cf8c8-fc77-11e7-99e1-459c7b9428c1.png" alt="Conversation 1" style="width: 100px;"/>

<img src="https://user-images.githubusercontent.com/607917/35106518-165d4300-fc77-11e7-999d-efde71208596.png" alt="Conversation 2" style="width: 100px;"/>

## License

the Spot.IM SDK is released under a custom license based on MIT. [See LICENSE](https://github.com/SpotIM/iOS-prod/blob/master/LICENSE) for details.

## Support

Feedback and inquires can be sent to love@spot.im
