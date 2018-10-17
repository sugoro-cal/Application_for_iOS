//
//  AppDelegate.swift
//  Sample_Procon_2018
//
//  Created by 関谷恒甫 on 2018/10/10.
//  Copyright © 2018年 関谷恒甫. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //復帰したかどうか
        if let notification = launchOptions?[UIApplication.LaunchOptionsKey.localNotification] as? UILocalNotification,let _ = notification.userInfo{
            application.applicationIconBadgeNumber = 0
            application.cancelLocalNotification(notification)
        }
        //復帰に関係なくバッジが0じゃなければ0にする
        if application.applicationIconBadgeNumber != 0{
            application.applicationIconBadgeNumber = 0
        }
        
        UIApplication.shared.isIdleTimerDisabled = true//自動ロック無効化
        
        let notiSettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
        application.registerUserNotificationSettings(notiSettings)
        application.registerForRemoteNotifications()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        //アプリがactive時に通知を発生させた時にも呼ばれる
        if application.applicationState != .active{
            //バッジを０にする
            application.applicationIconBadgeNumber = 0
            //通知領域から削除する
            application.cancelLocalNotification(notification)
        }else{
            //active時に通知が来たときはそのままバッジを0に戻す
            if application.applicationIconBadgeNumber != 0{
                application.applicationIconBadgeNumber = 0
                application.cancelLocalNotification(notification)
            }
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //通知を全て消してから登録する
        application.cancelAllLocalNotifications()
        
        //通知確認
        let alertManager = AlertManager()
        let notification = alertManager.after(day:0, hour: 0, minute: 0, seconds: 10)
        
        application.scheduleLocalNotification(notification)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        //アプリが起動されたらバッジを0にする
        if application.applicationIconBadgeNumber != 0{
            application.applicationIconBadgeNumber = 0
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

