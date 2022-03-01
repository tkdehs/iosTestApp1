//
//  Define.swift
//  CodeAble
//
//  Created by Ahngunism on 2022/01/17.
//  Copyright © 2022 OKPOS. All rights reserved.
//

import UIKit
import Spring

//============================================================
// MARK: - Data Define
//============================================================

/// 카카오
public var NATIVE_APP_KEY : String = "8f63a8dff6d21f3e49c23c9a70bf066c"

/// 유저 디폴트
public var USER_DEFAULT : UserDefaults { get { return UserDefaults.standard } }

/// 시스템 버전
public var OS_VERSION : String { get { return UIDevice.current.systemVersion } }

/// 앱 버전
public var APP_VERSION: String? {
    guard let dictionary = Bundle.main.infoDictionary, let version = dictionary["CFBundleShortVersionString"] as? String else { return nil }
    return version
}

/// 빌드 버전
public var BUILD_VERSION: String? {
    guard let dictionary = Bundle.main.infoDictionary, let build = dictionary["CFBundleVersion"] as? String else { return nil }
    return build
}

/// 빌드 버전
public var BUILD_SETTING: String? {
    guard let dictionary = Bundle.main.infoDictionary, let build = dictionary["BUILD_SETTING"] as? String else { return nil }
    return build
}

/// 빌드 버전
public var SERVER_URL: String {
    if BUILD_SETTING == "DEV" { return "https://tmaapp.okpos.co.kr:8080" }
    if BUILD_SETTING == "STG" { return "https://tmaapp.okpos.co.kr:8080" }
    else { return "https://maapp.okpos.co.kr:8080" }
}

/// 디바이스 Identifier
public var DEVICE_Identifier: String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    return identifier
}

public var DEVICE_UUID: String {
    get {
        if let strUUID = USER_DEFAULT.string(forKey: "UUID") {
            return strUUID
        } else if let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil)) {
            USER_DEFAULT.setValue(String(uuid), forKey: "UUID")
            return String(uuid)
        } else {
            return ""
        }
    }
}

/// 공통 앱델리게이트 호출
/// - Returns: 공통 앱델리게이트
func GET_APPDELEGATE() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

/// Info 번들 정보
/// - Parameter strKey: Key
/// - Returns: Value
func BundleInfo(strKey: String) -> String? {
    if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
        let dicInfo = NSDictionary.init(contentsOfFile: path)
        return dicInfo?[strKey] as? String
    }
    return nil
}

//============================================================
// MARK: - User Default Define
//============================================================

/// APNS TOKEN
public var APNS_TOKEN: String {
    get { return USER_DEFAULT.string(forKey: "APNS_TOKEN") ?? "" }
    set { USER_DEFAULT.setValue(newValue, forKey: "APNS_TOKEN") }
}

//============================================================
// MARK: - Setting Define
//============================================================



//============================================================
// MARK: - Text Defint
//============================================================

public var ERROR_TEXT_RETRY_AGAIN : String        { get { return "잠시 후 다시 시도해주세요." }}
public var ERROR_TEXT_NETWORK_FAIL : String        { get { return "네트워크 상태를 확인해주세요." }}
public var ERROR_TEXT_URL_FAIL : String           { get { return "링크 URL을 확인해주세요." }}

//============================================================
// MARK: - UI Define
//============================================================

/// DEFINE : 스크린 BOUNDS
let ScreenBounds : CGRect = UIScreen.main.bounds
/// DEFINE : 스크린 WIDTH
let ScreenWidth :CGFloat = UIScreen.main.bounds.width
/// DEFINE : 스크린 HEIGHT
let ScreenHeight :CGFloat = UIScreen.main.bounds.height
/// DEFINE : 노치 디스플레이 여부
var IS_NOTCH : Bool { get { if 812...926 ~= ScreenHeight { return true } else { return false } } }

//============================================================
// MARK: - FONT Define
//============================================================

public func FONT_APPLE_SD_GOTHIC_REGULAR ( _ size : CGFloat ) -> UIFont    { return UIFont.init(name: "AppleSDGothicNeo-Regular", size: size)! }
public func FONT_APPLE_SD_GOTHIC_SEMIBOLD ( _ size : CGFloat ) -> UIFont    { return UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: size)! }
public func FONT_APPLE_SD_GOTHIC_BOLD ( _ size : CGFloat ) -> UIFont        { return UIFont.init(name: "AppleSDGothicNeo-Bold", size: size)! }

public func FONT_NOTOSANS_KR_REGULAR ( _ size : CGFloat ) -> UIFont    { return UIFont.init(name: "NotoSansKR-Regular", size: size)! }
public func FONT_NOTOSANS_KR_MEDIUM ( _ size : CGFloat ) -> UIFont    { return UIFont.init(name: "NotoSansKR-Medium", size: size)! }
public func FONT_NOTOSANS_KR_BOLD ( _ size : CGFloat ) -> UIFont        { return UIFont.init(name: "NotoSansKR-Bold", size: size)! }

public func FONT_ROBOTO_KR_REGULAR ( _ size : CGFloat ) -> UIFont    { return UIFont.init(name: "Roboto-Regular", size: size)! }
public func FONT_ROBOTO_KR_MEDIUM ( _ size : CGFloat ) -> UIFont    { return UIFont.init(name: "Roboto-Medium", size: size)! }
public func FONT_ROBOTO_KR_BOLD ( _ size : CGFloat ) -> UIFont        { return UIFont.init(name: "Roboto-Bold", size: size)! }

//============================================================
// MARK: - Color DEFINE
//============================================================

/// BLACK COLOR
public var COLOR_REAL_BLACK : UIColor {
    get { return UIColor.init(hex: "#000000") }
}

/// WHITE COLOR
public var COLOR_WHITE : UIColor {
    get { return UIColor.init(hex: "#FFFFFF") }
}

/// CLEAR COLOR
public var COLOR_CLEAR : UIColor {
    get { return UIColor.init(hex: "#FFFFFF").withAlphaComponent(0.0) }
}

/// DIM COLOR
public var COLOR_DIM : UIColor {
    get { return UIColor.init(hex: "#000000").withAlphaComponent(0.3) }
}

/// WHITE DIM COLOR
public var COLOR_WHITE_DIM : UIColor {
    get { return UIColor.init(hex: "#FFFFFF").withAlphaComponent(0.8) }
}

/// DoderBlue COLOR ( #0080FF )
public var COLOR_DoderBlue : UIColor {
    get { return UIColor.init(hex: "#0080FF") }
}

/// Navy COLOR
public var COLOR_Navy : UIColor {
    get { return UIColor.init(hex: "#3D3DC3") }
}

/// Mediumtur Quoise COLOR
public var COLOR_Mediumtur_Quoise : UIColor {
    get { return UIColor.init(hex: "#48D1CC") }
}

/// Yellow COLOR
public var COLOR_Yellow : UIColor {
    get { return UIColor.init(hex: "#F1B000") }
}

/// Crimson COLOR
public var COLOR_Crimson : UIColor {
    get { return UIColor.init(hex: "#F4485D") }
}

/// Black COLOR
public var COLOR_Black : UIColor {
    get { return UIColor.init(hex: "#1A1A1A") }
}

/// Gray1 COLOR
public var COLOR_Gray1_68 : UIColor {
    get { return UIColor.init(hex: "#68696B") }
}

/// Gray2 COLOR
public var COLOR_Gray2_97 : UIColor {
    get { return UIColor.init(hex: "#979DA6") }
}

/// Gray3 COLOR
public var COLOR_Gray3_C0 : UIColor {
    get { return UIColor.init(hex: "#C0C4D1") }
}

/// Gray4 COLOR
public var COLOR_Gray4_D9 : UIColor {
    get { return UIColor.init(hex: "#D9DBE1") }
}

/// Gray5 COLOR
public var COLOR_Gray5_EC : UIColor {
    get { return UIColor.init(hex: "#ECEEF2") }
}

/// BG01 COLOR
public var COLOR_BG01 : UIColor {
    get { return UIColor.init(hex: "#EBF0F7") }
}

/// BG02 COLOR
public var COLOR_BG02 : UIColor {
    get { return UIColor.init(hex: "#F7F8FC") }
}

/// COLOR_RANDOM
public var COLOR_RANDOM                        : UIColor { get { return UIColor.init(red: CGFloat( arc4random()%100 ) / 100, green: CGFloat( arc4random()%100 ) / 100, blue: CGFloat( arc4random()%100 ) / 100, alpha: 1.0) } }

//============================================================
// MARK: - Data
//============================================================

/// 간편연동 가이드 노출 여부
public var isShowGuideSimpleConnect: Bool {
    get { return USER_DEFAULT.bool(forKey: "IS_SHOW_GUIDE_SIMPLECONNECT") }
    set { USER_DEFAULT.set(newValue, forKey: "IS_SHOW_GUIDE_SIMPLECONNECT")}
}

/// POS 연동 가이드 노출 여부
public var isShowGuidePosConnect: Bool {
    get { return USER_DEFAULT.bool(forKey: "IS_SHOW_GUIDE_POSCONNECT") }
    set { USER_DEFAULT.set(newValue, forKey: "IS_SHOW_GUIDE_POSCONNECT")}
}

/// ASP 연동 가이드 노출 여부
public var isShowGuideAspConnect: Bool {
    get { return USER_DEFAULT.bool(forKey: "IS_SHOW_GUIDE_ASPCONNECT") }
    set { USER_DEFAULT.set(newValue, forKey: "IS_SHOW_GUIDE_ASPCONNECT")}
}

