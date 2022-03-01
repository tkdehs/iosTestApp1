//
//  AppDelegate.swift
//  iosTestApp1
//
//  Created by PNX on 2022/02/25.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate{

    var window: UIWindow?
    
    var navigationController:UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /*
         UIApplication
         위 함수는 또한 앱의 런 루프를 포함하는 메인 이벤트 루프를 구성합니다.
         */
        DLog("application in test")
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = SplashViewController()
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
    


}

