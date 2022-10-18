//
//  SeaonCarousel.swift
//  TheMovieDB
//
//  Created by Luann Luna on 16/10/22.
//

import SwiftUI

struct SeasonCarousel: View {
    
    var season: SeasonDetailModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(season.name)
                .fontWeight(.bold)
                .foregroundColor(.tertiaryColor)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(season.episodes, id: \.id) { e in
                        SeasonCarouselCard(episode: e)
                    }
                }
            }
        }
        .padding(.leading)
        .padding(.vertical)
    }
}
