//
//  Util_Date.swift
//  CodeAble
//
//  Created by Ahngunism on 2022/01/17.
//  Copyright © 2022 OKPOS. All rights reserved.
//

import UIKit

extension Date {
    /// 밀리세컨드 반환
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    /// 데이터 포멧에 맞는 문자열 반환
    func convertString ( strDateFormmat : String ) -> String {
        let fmHMDate = DateFormatter.init()
        fmHMDate.dateFormat = strDateFormmat
        return fmHMDate.string(from: self)
    }
    
    /// Date -> String 변환 ( yyyy-MM-dd HH:mm:ss )
    func convertString () -> String                    { return self.convertString(strDateFormmat: "yyyy.MM.dd HH:mm") }
    /// Date -> String 변환 ( yyyy.MM.dd )
    func convertYearMonthDayString (strDivide: String = ".") -> String     {
        return self.convertString(strDateFormmat: "yyyy\(strDivide)MM\(strDivide)dd")
    }
    /// Date -> String 변환 ( yyyy년 MM월 dd일 )
    func convertYearMonthDay() -> String     {
        return self.convertString(strDateFormmat: "yyyy년 MM월 dd일")
    }
    
    /// Date -> String 변환 ( yyyy )
    func convertYearString () -> String                { return self.convertString(strDateFormmat: "yyyy") }
    /// Date -> String 변환 ( yy )
    func convertDoubleFigureYearString () -> String { return self.convertString(strDateFormmat: "yy") }
    /// Date -> String 변환 ( MM )
    func convertMonthString () -> String            { return self.convertString(strDateFormmat: "MM") }
    /// Date -> String 변환 ( dd )
    func convertDayString () -> String                { return self.convertString(strDateFormmat: "dd") }
    /// Date -> String 변환 ( MM.dd )
    func convertMonthDayString () -> String            { return self.convertString(strDateFormmat: "MM.dd") }
    
    /// Date -> String 변환 ( HH:mm:ss )
    func convertHourMinuteSecondString() -> String  { return self.convertString(strDateFormmat: "HH:mm:ss") }
    /// Date -> String 변환 ( HH:mm )
    func convertHourMinuteString() -> String        { return self.convertString(strDateFormmat: "HH:mm") }
    /// Date -> String 변환 ( HH )
    func convertHourString () -> String                { return self.convertString(strDateFormmat: "HH") }
    /// Date -> Int 변환 ( HH )
    func convertHourInt () -> Int                   { let nConvert = Int(self.convertString(strDateFormmat: "HH"));        if let nConvert = nConvert { return nConvert } else { return 0 } }
    /// Date -> String 변환 ( mm )
    func convertMinuteString () -> String            { return self.convertString(strDateFormmat: "mm") }
    /// Date -> String 변환 ( ss )
    func convertSecondString () -> String            { return self.convertString(strDateFormmat: "ss") }
    
    /// Date -> String 변환 ( e )
    func convertWeekDayNumberString () -> String    { return self.convertString(strDateFormmat: "e") } /// "1": 일요일 ~ "7": 토요일
    /// Date -> String 변환 ( EEEE )
    func convertWeekDayString () -> String            { return self.convertString(strDateFormmat: "EEEE") }
    
    /// Date -> AM/PM/오전/오후 변환
    /// - Returns: 한글 여부
    func convertAMPM ( isHangul : Bool = true ) -> String {
        if let nVisitTspHour = Int(self.convertHourString()), nVisitTspHour < 12 {
            if isHangul == true        { return "오전" }
            else                    { return "AM" }
        } else {
            if isHangul == true        { return "오후" }
            else                    { return "PM" }
        }
    }
    
    /// Date -> 요일 반환
    /// - Returns: 영문 요일 값
    func convertEngWeekday(isKOR: Bool = false, isSimple: Bool = false) -> String {
        if isKOR == true {
            var strResult : String = " "
            switch self.convertWeekDayNumberString() {
                case "1": strResult = "일"
                case "2": strResult = "월"
                case "3": strResult = "화"
                case "4": strResult = "수"
                case "5": strResult = "목"
                case "6": strResult = "금"
                case "7": strResult = "토"
                default: strResult = ""
            }
            
            if isSimple == true {
                return strResult
            } else {
                strResult.append("요일")
                return strResult
            }
            
        } else {
            switch self.convertWeekDayNumberString() {
                case "1": return "Sun"
                case "2": return "Mon"
                case "3": return "Tue"
                case "4": return "Wed"
                case "5": return "Thu"
                case "6": return "Fri"
                case "7": return "Sat"
                default: return ""
            }
        }
        
    }
    
    /// Date -> AM/PM HH:MM
    /// - Returns: AM/PM/오전/오후 HH:MM
    func convertAMPMHHMM ( isKOR : Bool = true ) -> String {
        var strResult : String = ""
        strResult.append(self.convertAMPM( isHangul: isKOR ))
        if self.convertHourInt() > 12 {
            strResult.append(" \(self.convertHourInt()-12)")
        } else {
            strResult.append(" \(self.convertHourInt())")
        }
        
        strResult.append(":\(self.convertMinuteString())")
        
        return strResult
    }
}
