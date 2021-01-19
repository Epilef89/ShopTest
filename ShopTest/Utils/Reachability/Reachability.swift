//
//  Reachability.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.
//

import Foundation
import SystemConfiguration

enum ReachabilityStatus {
    case wifi
    case mobile
    case unreachable
    case unknow
}

struct ReachabilityManager {
    func checkReachable() -> ReachabilityStatus {
        let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")
        var flags = SCNetworkReachabilityFlags()
        guard let reachabilityG = reachability else {
            return .unreachable
        }

        SCNetworkReachabilityGetFlags(reachabilityG, &flags)
        if isNetworkReachable(with: flags) {
            if flags.contains(.isWWAN) {
                return .mobile
            }

            return .wifi
        } else if !isNetworkReachable(with: flags) {
           return .unreachable
        } else {
            return .unknow
        }
    }

    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)

        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    
}

