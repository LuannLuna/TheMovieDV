//
//  WatchListCarousel.swift
//  TheMovieDB
//
//  Created by Luann Luna on 17/10/22.
//

import SwiftUI

struct WatchListCarousel: View {
    
    var watchList: [TVModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(watchList, id: \.id) { tvShow in
                    HomeCarouselCard(tvShow: tvShow)
                        .frame(width: 175, height: 350)
                        .cornerRadius(12)
                }
            }
        }
    }
}
