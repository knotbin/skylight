//
//  ContentView.swift
//  Skylight
//
//  Created by Roscoe Rubin-Rottenberg on 12/1/24.
//

import SwiftUI
import ATProtoKit

struct ContentView: View {
    @Environment(AppModel.self) private var appModel
    var body: some View {
        VStack {
            if let handle = appModel.atProto.session?.handle {
                Text("Hello, \(handle)!")
            } else {
                Text("Hello!")
            }
            Button("Logout") {
                appModel.atProto = ATProtoKit(session: nil)
            }
        }
        .padding()
    }
}

#if os(visionOS)
#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
#else
#Preview {
    ContentView()
        .environment(AppModel())
}
#endif
