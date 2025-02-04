import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Parse
        Parse.setApplicationId("jeoeVa2Nz3VLmrnWpAknbWKZADXHbmQltPSlU8mX", clientKey: "nMdA9eBEQU5l2KNWvvWJ3gIDN70M4yi5hBkdyxs2")
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        
        var userNotificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
        var settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
        
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        // White status bar
        application.setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
//        application.setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Parse
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        var currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.channels = ["updates"]
        currentInstallation.saveInBackgroundWithTarget(self, selector: nil)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
                
        var aps = userInfo["aps"] as NSDictionary
        
        var title: String =  aps.valueForKey("alert") as String
        var subtitle: String = userInfo["info"] as String
    
        var easyNotification = MPGNotification(title: title, subtitle: subtitle, backgroundColor: UIColor.HFColor.LightBlue, iconImage: nil)
        easyNotification.fullWidthMessages = true
        
        easyNotification.show()
        
        var dashViewController = (window?.rootViewController as UINavigationController).topViewController as HFDashViewController
        dashViewController.reloadViewControllers()
    }
}