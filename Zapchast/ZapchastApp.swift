//
//  ZapchastApp.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 8/9/24.
//

import SwiftUI
import KeychainAccess

@main
struct ZapchastApp: App {
    @StateObject var appViewModel = OnBoardViewModel()
    
    var body: some Scene {
        WindowGroup {
            OnBoardView()
                .environmentObject(appViewModel)
        }
    }
}
