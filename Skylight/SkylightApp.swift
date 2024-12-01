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
    @State var atProto = ATProtoKit()
    var body: some Scene {
        WindowGroup {
            if atProto.session == nil {
                LoginView(atProto: $atProto)
            } else {
                TabView {
                    ContentView(atProto: $atProto)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                }
            }
        }
    }
}
