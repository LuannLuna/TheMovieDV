//
//  HomeCarouselCard.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import SwiftUI

struct HomeCarouselCard: View {
    
    let tvShow: TVModel
    
    var body: some View {
        ZStack {
            Color.darkColor
            GeometryReader { geo in
                VStack(alignment: .leading, spacing: 10) {
                    URLImage(url: imgBaseUrl + (tvShow.posterPath ?? ""))
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height / 1.75)
                        .clipped()
                    VStack(alignment: .leading, spacing: 10) {
                        Text(tvShow.name ?? "")
                            .font(.caption)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .foregroundColor(.tertiaryColor)
                        HStack {
                            if let date = tvShow.firstAirDate {
                                Text(date.dateFormatted().capitalized)
                            }
                            Spacer()
                            Image(systemName: "star.fill")
                                .font(.caption)
                            if let votes = tvShow.voteAverage {
                                Text(votes.toString())
                            }
                        }
                        .font(.caption2)
                        .foregroundColor(.tertiaryColor)
                        Text(tvShow.overview ?? "")
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .lineLimit(4)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 5)
                }
            }
        }
    }
}
