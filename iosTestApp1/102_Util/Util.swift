//
//  Util.swift
//  iosTestApp1
//
//  Created by PNX on 2022/02/26.
//
import UIKit

class Util {
    static let shard = Util()
    
    func delayAction ( dDelay : Double, complete : @escaping () -> () ) {
        let dDelay = dDelay * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(dDelay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            complete()
        }
    }
}
