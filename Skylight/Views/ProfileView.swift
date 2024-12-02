//
//  ProfileView.swift
//  Skylight
//
//  Created by Roscoe Rubin-Rottenberg on 12/1/24.
//

import SwiftUI
import ATProtoKit

struct ProfileView: View {
    @Environment(AppModel.self) private var appModel
    let handle: String
    @State var profile: AppBskyLexicon.Actor.ProfileViewDetailedDefinition?
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(profile?.actorHandle ?? "None")
                AsyncImage(url: profile?.avatarImageURL)
            }
        }
        .task {
            do {
                profile = try await appModel.atProto.getProfile(handle)
            } catch {}
        }
        
    }
}

#Preview {
    ProfileView(handle: "knotbin.xyz")
}
