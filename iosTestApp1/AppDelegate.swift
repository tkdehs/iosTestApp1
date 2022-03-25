//
//  AppDelegate.swift
//  iosTestApp1
//
//  Created by PNX on 2022/02/25.
//

import UIKit
import Firebase
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate{

    var window: UIWindow?
    
    var navigationController:UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        /*
         UIApplication
         위 함수는 또한 앱의 런 루프를 포함하는 메인 이벤트 루프를 구성합니다.
         */
        DLog("application in test")
        let ncLogin = UINavigationController.init(rootViewController: LoginViewController())
        ncLogin.isNavigationBarHidden = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ncLogin
        self.window?.makeKeyAndVisible()
        self.setApplication(application)
        
        
        return true
    }
    
    
    /// 푸쉬 알림 딜리게이트 설정
    /// - Parameter application: 어플리케이션
    func setApplication(_ application: UIApplication) {
        /// APNS 등록
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization( options: authOptions, completionHandler: { granted, error in
            if granted == true, error == nil {
                DLog("APNS Regist Complete")
            } else {
                DLog("APNS Regist Fail")
            }
        } )
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken strAPNSToken: Data) {
        /// APNS 토큰 세팅
        let strToken = strAPNSToken.map { String(format: "%02.2hhx", $0) }.joined()
        ILog("APNS DEVICE TOKEN RECEIVE : \(strToken)")
        APNS_TOKEN = strToken
    }
    
    //============================================================
    // MARK: - UNUserNotificationCenterDelegate
    //============================================================
    /// Foreground 상태 APNS 수신
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        DLog(userInfo)
        completionHandler([.alert, .badge, .sound])
    }
    
    /// BackGround 상태 APNS 수신
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        DLog(userInfo)
        completionHandler()
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = { // persistent container
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "NetflixCloneModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () { // context manager
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

