//
//  ContentView.swift
//  Skylight
//
//  Created by Roscoe Rubin-Rottenberg on 12/1/24.
//

import SwiftUI
import ATProtoKit

struct ContentView: View {
    @State private var atProto: ATProtoKit?
    @State private var isAuthenticated = false
    @State private var errorMessage: String?
    @State private var avatarImageURL: URL?

    var body: some View {
        TabView {
            VStack {
                if isAuthenticated {
                    Text("Authenticated successfully with handle: \(atProto?.session?.handle ?? "")")
                        .font(.title)
                        .padding()
                    if let avatarImage = avatarImageURL {
                        AsyncImage(url: avatarImage)
                    }
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ProgressView("Authenticating...")
                }
            }
            .task {
                do {
                    await print(try atProto?.getProfile(atProto?.session?.handle ?? ""))
                    avatarImageURL = try await atProto?.getProfile(atProto?.session?.handle ?? "").avatarImageURL
                    print(avatarImageURL ?? "")
                } catch {
                    
                }
                authenticateWithPredefinedCredentials()

            }
            .padding()
            .tabItem {
                Label("Home", systemImage: "house")
            }
        }
    }
    
    func authenticateWithPredefinedCredentials() {
        let handle = "knotbin.xyz" // Replace with your handle
        let appPassword = "gnrm-6qqk-q5k2-vtyd" // Replace with your App Password

        let config = ATProtocolConfiguration(handle: handle, appPassword: appPassword)

        Task {
            do {
                let session = try await config.authenticate()
                atProto = ATProtoKit(session: session)
                isAuthenticated = true
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
