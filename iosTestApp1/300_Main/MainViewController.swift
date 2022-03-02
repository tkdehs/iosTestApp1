//
//  MainViewController.swift
//  iosTestApp1
//
//  Created by sangdon kim on 2022/03/02.
//

import UIKit
import AVKit
import YoutubePlayer_in_WKWebView

class MainViewController: BaseViewController {
    
    /////////////////////////
    /// 트래킹용 스크린 네임 세팅
    override var strScreenName : String? { get { return "메인"} set(strNew) { super.strScreenName = strNew } }
    static var strScreenName : String? = "메인"
    /////////////////////////
    
    @IBOutlet weak var youtubePlayer: WKYTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.initData()
    }
    
    //============================================================
    // MARK: - View Setting
    //============================================================
    
    /// 뷰 초기 세팅
    func initView() {
        
    }
    
    //============================================================
    // MARK: - Data Setting
    //============================================================
    
    /// 데이터 초기 세팅
    func initData() {
        
    }
    

    //============================================================
    // MARK: - Button Action
    //============================================================
    
    /// url 재생
    /// - Parameter sender: 버튼 컨트롤
    @IBAction func urlVideoButtonPressed(_ sender: UIButton) {
        DLog("[USER_ACTION] urlVideoButtonPressed")
        
        let playVarsDic = ["playsinline": 1]
    https://youtu.be/jK7b8pgUElQ
        youtubePlayer.load(withPlaylistId: "jK7b8pgUElQ", playerVars: playVarsDic)
    }
}
