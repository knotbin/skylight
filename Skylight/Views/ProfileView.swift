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
            if let profile = profile {
                VStack(alignment: .leading) {
                    ZStack(alignment: .top) {
                        AsyncImage(url: profile.bannerImageURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color(.gray)
                        }
                        .frame(height: 200)
                        .frame(maxWidth: 1000)
                        .clipShape(.rect(cornerRadius: 10, style: .continuous))
                        VStack(alignment: .leading) {
                            AsyncImage(url: profile.avatarImageURL) { result in
                                result.image?
                                    .resizable()
                                    .scaledToFill()
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(.circle)
                            .overlay( /// apply a rounded border
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(.windowBackground, lineWidth: 5)
                            )
                            Text(profile.displayName ?? profile.actorHandle)
                                .font(.title).bold()
                            Text("@" + (profile.actorHandle))
                            HStack {
                                Text(String(profile.followerCount ?? 0) + " followers")
                                Text(String(profile.followCount ?? 0) + " following")
                            }.fontWeight(.medium)
                        }
                        .padding(.top, 150)
                        .padding(10)
                        .frame(maxWidth: 1000, alignment: .leading)
                    }
                }
                    .padding()
            }
        }
        .task {
            do {
                profile = try await appModel.atProto.getProfile(handle)
            } catch {}
        }
        
    }
}
