//
//  SkylightApp.swift
//  Skylight
//
//  Created by Roscoe Rubin-Rottenberg on 12/1/24.
//

import SwiftUI
import ATProtoKit

@main
struct SkylightApp: App {
    @State var appModel = AppModel()
    var body: some Scene {
        WindowGroup {
            if appModel.initialized == false {
                ProgressView()
            } else {
                if appModel.atProto.session == nil {
                    LoginView()
                } else {
                    TabView {
                        ContentView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        if let handle = appModel.atProto.session?.handle {
                            ProfileView(handle: handle)
                                .tabItem {
                                    Label("Profile", systemImage: "person.crop.circle")
                                }
                        }
                    }
                }
            }

        }
        .environment(appModel)
    }
}
