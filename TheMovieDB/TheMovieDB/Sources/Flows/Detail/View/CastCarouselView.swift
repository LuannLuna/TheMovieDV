//
//  CastCarouselView.swift
//  TheMovieDB
//
//  Created by Luann Luna on 15/10/22.
//

import SwiftUI

struct CastCarouselView: View {
    
    var productions: [Production]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Channels")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.tertiaryColor)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(productions, id: \.id) { prod in
                        VStack {
                            ZStack {
                                Color.white.opacity(0.3)
                                URLImage(url: imgBaseUrl + (prod.logoPath ?? ""))
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                            }
                            .clipShape(Circle())
                            Text(prod.name)
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}
