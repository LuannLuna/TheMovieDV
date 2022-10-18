//
//  SeasonsView.swift
//  TheMovieDB
//
//  Created by Luann Luna on 16/10/22.
//

import SwiftUI

struct SeasonsView: View {
    
    @EnvironmentObject var viewModel: SeasonsViewModel
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.seasonsDetail.sorted(by: { $0.key < $1.key }), id: \.key) { season in
                    SeasonCarousel(season: season.value)
                }
            }
            
            if viewModel.seasonsDetail.isEmpty && !viewModel.isLoading {
                Text("There are no data found")
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .padding()
        .onAppear {
            Task {
                try? await viewModel.fetchSeasonsData()
            }
        }
    }
}
