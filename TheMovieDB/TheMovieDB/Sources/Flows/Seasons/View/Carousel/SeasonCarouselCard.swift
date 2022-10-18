//
//  SeasonCarouselCard.swift
//  TheMovieDB
//
//  Created by Luann Luna on 16/10/22.
//

import SwiftUI

struct SeasonCarouselCard: View {

    var episode: Episode
    
    var body: some View {
        URLImage(url: imgBaseUrl + episode.stillPath)
            .scaledToFill()
            .frame(width: 215, height: 130)
            .overlay(alignment: .bottom) {
                ZStack {
                    Color.darkColor
                    HStack {
                        Text(episode.name)
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .padding(.leading)
                        Spacer()
                    }
                }
                .frame(height: 50)
            }
            .cornerRadius(12)
    }
}
