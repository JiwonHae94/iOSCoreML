//
//  iOSCoreMLApp.swift
//  iOSCoreML
//
//  Created by Jiwon_Hae on 2021/12/13.
//

import SwiftUI

@main
struct iOSCoreMLApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(AnimalModel())
        }
    }
}
