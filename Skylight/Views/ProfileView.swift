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
                AsyncImage(url: profile?.avatarImageURL) { result in
                    result.image?
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: 200, height: 200)
                .clipShape(.circle)
            }
        }
        .task {
            do {
                profile = try await appModel.atProto.getProfile(handle)
            } catch {}
        }
        
    }
}
