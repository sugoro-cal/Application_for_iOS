//
//  ViewController.swift
//  Sample_Procon_2018
//
//  Created by 関谷恒甫 on 2018/10/10.
//  Copyright © 2018年 関谷恒甫. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet weak var jampButton1: UIButton!
    @IBOutlet weak var jumpButton2: UIButton!
    @IBOutlet weak var pushNotiButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func jumpButton1Tapped(_ sender: Any) {
        let jump1StoryBoard:UIStoryboard = UIStoryboard(name: "ShowQRCode", bundle: nil)
        let jump1ViewController:UIViewController = jump1StoryBoard.instantiateInitialViewController() as! UIViewController
        present(jump1ViewController, animated: true, completion: nil)
    }
    @IBAction func jumpButton2Tapped(_ sender: Any) {
        let jump2StoryBoard:UIStoryboard = UIStoryboard(name: "ViewWebSite", bundle: nil)
        let jump2ViewController:UIViewController = jump2StoryBoard.instantiateInitialViewController() as! UIViewController
        present(jump2ViewController, animated: true, completion: nil)
    }

}
class AlertManager {

    let id = "alert"
    var text = "通知確認"

    //(何日後、何時間後、何分後、何秒後)に通知を送る
    func after(day:Int,hour:Int,minute:Int,seconds:Int) -> UILocalNotification{
        //通知
        let notification = UILocalNotification()

        let currentDate = Date()
        let pushDate = self.pushDate(date:currentDate, day: day,hour:hour,minute:minute,seconds:seconds)

        //ロック中にスライドで〜〜のところの文字
        notification.alertAction = "アプリを開く"
        //通知の本文
        notification.alertBody = self.text

        //通知時刻
        notification.fireDate = pushDate
        //通知音
        notification.soundName = UILocalNotificationDefaultSoundName
        //アインコンバッジの数字
        notification.applicationIconBadgeNumber = 1
        //通知を識別するID
        notification.userInfo = ["notifyID":self.id]
        return notification
    }

    //通知をする時間を返す
    func pushDate(date:Date,day:Int,hour:Int,minute:Int,seconds:Int) -> Date{
        let current = Calendar.current.dateComponents([.hour,.minute,.second], from: date)
        var interval = TimeInterval()
        interval = Double(60 * 60 * 24 * day)
        let nextDate = date.addingTimeInterval(interval)
        var fireDateComponent = Calendar.current.dateComponents([.year,.month,.day], from: nextDate)
        fireDateComponent.hour = hour + ( current.hour ?? 0 )
        fireDateComponent.minute = minute + ( current.minute ?? 0 )
        fireDateComponent.second = seconds + ( current.second ?? 0 )
        
        return Calendar.current.date(from: fireDateComponent)!
        
    }
}
