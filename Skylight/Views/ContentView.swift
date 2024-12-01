//
//  ContentView.swift
//  Skylight
//
//  Created by Roscoe Rubin-Rottenberg on 12/1/24.
//

import SwiftUI
import ATProtoKit

struct ContentView: View {
    @Binding var atProto: ATProtoKit
    
    var body: some View {
        VStack {
            if let handle = atProto.session?.handle {
                Text("Hello, \(handle)!")
            } else {
                Text("Hello!")
            }
            Button("Logout") {
                atProto = ATProtoKit(session: nil)
            }
        }
        .padding()
    }
}

#if os(visionOS)
#Preview(windowStyle: .automatic) {
    ContentView(atProto: .constant(ATProtoKit()))
}
#else
#Preview {
    ContentView(atProto: .constant(ATProtoKit()))
}
#endif
