//
//  ViewWebSite.swift
//  Sample_Procon_2018
//
//  Created by 関谷恒甫 on 2018/10/12.
//  Copyright © 2018 関谷恒甫. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ViewWebSite: UIViewController, WKNavigationDelegate, WKUIDelegate {
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var btnRefresh: UIBarButtonItem!
    @IBOutlet weak var btnForward: UIBarButtonItem!
    
    var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // ステータスバーの高さを取得
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        
        // ツールバーの高さを取得
        let toolBarHeight = toolBar.frame.size.height
        
        // webViewの領域を決定(高さは、「ステータスバーの下からツールバーの上まで」というロジック)
        webView = WKWebView(frame: CGRect( x: 0, y: statusBarHeight, width: self.view.frame.width, height: self.view.frame.height - toolBarHeight - statusBarHeight ), configuration: WKWebViewConfiguration())
        
        // webViewをviewに追加
        self.view.addSubview(webView)
        
        // webサイトの読み込み開始時や完了時に処理をおこなうためのデリゲート
        webView.navigationDelegate = self
        
        // target="_blank"で設定されているリンクに遷移するためのデリゲート
        webView.uiDelegate = self
        
        // webサイトのURL
        let myURL = URL(string: "XXXXXXXXXXXXXXXXXX")
        
        // webサイトの読み込み
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func actBack(_ sender: Any) {
        self.webView.goBack()
    }
    @IBAction func actRefresh(_ sender: Any) {
        self.webView.reload()
    }
    @IBAction func actForward(_ sender: Any) {
        self.webView.goForward()
    }
    // webサイトの読み込み開始時に起動
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        // インジケータ(実機の左上でグルグルするアニメーション)の表示を開始する
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // ボタンの有効性をチェック
        self.btnBack.isEnabled = self.webView.canGoBack
        self.btnForward.isEnabled = self.webView.canGoForward
        
    }
    // webサイトの読み込み完了時に起動
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // インジケータの表示を終了する
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        // ボタンの有効性をチェック
        self.btnBack.isEnabled = self.webView.canGoBack
        self.btnForward.isEnabled = self.webView.canGoForward
        
    }
    // リンクタップ時の挙動
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        // リンクの適性をチェック
        guard let url = navigationAction.request.url else {
            return nil
        }
        
        // リンクがtarget="_blank"で設定されている場合
        guard let targetFrame = navigationAction.targetFrame, targetFrame.isMainFrame else {
            
            // Safariで開く
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
            return nil
            
        }
        
        return nil
        
    }
}
