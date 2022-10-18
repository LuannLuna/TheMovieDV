//
//  HomeView.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import SwiftUI

struct HomeView: View {
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @EnvironmentObject var viewModel: HomeViewModel
    @State var isShowingOptions: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                Picker("", selection: $viewModel.currentTab) {
                    ForEach(HomeViewModel.TabOptions.allCases, id: \.self) { tab in
                        Text(tab.rawValue)
                            .padding(.vertical, 5)
                    }
                }
                .pickerStyle(.segmented)
                .compositingGroup()
                
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.tvs, id: \.id) { tvShow in
                        Button {
                            viewModel.showSelected(tvShow: tvShow)
                        } label: {
                            HomeCarouselCard(tvShow: tvShow)
                                .frame(height: 350)
                                .cornerRadius(12)
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .navigationTitle("TV Shows")
        .toolbar {
            Button {
                isShowingOptions = true
            } label: {
                Image(systemName: "list.bullet")
                    .foregroundColor(Color.primary)
                
            }
        }
        
        .actionSheet(isPresented: $isShowingOptions) {
            ActionSheet(
                title: Text("What do you want to do?"),
                buttons: [
                    .default(Text("View Profile")) {
                        viewModel.viewProfile()
                    },
                    .destructive(Text("Logout")) {
                        viewModel.logout()
                    },
                    .cancel()
                ]
            )
        }
        .onAppear {
            Task {
                await viewModel.requestTvShows()
            }
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel(dataStore: HomeDataStoreImpl(tvService: TVService())))
    }
}
#endif
