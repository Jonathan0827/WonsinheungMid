//
//  WonsinheungMidApp.swift
//  WonsinheungMid
//
//  Created by 임준협 on 2023/03/11.
//

import SwiftUI

@main
struct WonsinheungMidApp: App {
    @AppStorage("alwaysLight") var alwaysLight = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(alwaysLight ? .light : .none)
        }
    }
}
