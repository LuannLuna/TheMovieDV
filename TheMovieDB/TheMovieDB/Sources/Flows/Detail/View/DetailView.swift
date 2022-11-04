//
//  DetailView.swift
//  TheMovieDB
//
//  Created by Luann Luna on 15/10/22.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var viewModel: DetailViewModel
    
    var body: some View {
        ZStack {
            Color.black
            ScrollView(.vertical, showsIndicators: false) {
                URLImage(url: imgBaseUrl + (viewModel.tvShow.posterPath ?? ""))
                    .scaledToFill()
                    .frame(height: 230)
                    .offset(y: -10)
                    ZStack {
                        Color.darkColor
                            .cornerRadius(12)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Summary")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.tertiaryColor)
                            HStack {
                                Text(viewModel.tvShow.name ?? "")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Image(systemName: "heart")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.tertiaryColor)
                                }
                                .padding(.trailing)
                            }
                            
                            Text(viewModel.tvShow.overview ?? "")
                                .font(.footnote)
                                .foregroundColor(.white)
                            if let authors = viewModel.tvShowDetail?.createdBy.map { $0.name }.joined(separator: ", ") {
                                Text("Created by " + authors)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            if let detail = viewModel.tvShowDetail {
                                LastSessonView(title: detail.title, subtitle: detail.subtitle, image: imgBaseUrl + detail.image, delegate: viewModel)
                                    .frame(height: 185)
                                CastCarouselView(productions: detail.networks)
                            }
                        }
                        .padding()
                        .padding(.horizontal)
                    }
                    .overlay(alignment: .topTrailing) {
                        if let votes = viewModel.tvShow.voteAverage {
                            ZStack {
                                Color.tertiaryColor
                                    .frame(width: 40, height: 40)
                                Text(votes.toString())
                                    .fontWeight(.semibold)
                            }
                            .clipShape(Circle())
                            .offset(x: -40, y: -20)
                        }
                    }
                    .offset(y: -75)
                    
            }
            .ignoresSafeArea(.all, edges: .top)
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .onAppear {
            Task {
                await viewModel.requestTvShow()
            }
        }
    }
}
