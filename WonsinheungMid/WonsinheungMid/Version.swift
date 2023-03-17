//
//  GlobalFunctions.swift
//  WonsinheungMid
//
//  Created by 임준협 on 2023/03/14.
//

import Foundation
//
//var version: String? {
//    guard let dictionary = Bundle.main.infoDictionary,
//        let version = dictionary["CFBundleShortVersionString"] as? String,
//        let build = dictionary["CFBundleVersion"] as? String else {return nil}
//
//    let versionAndBuild: String = "vserion: \(version), build: \(build)"
//    return versionAndBuild
//}
let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
