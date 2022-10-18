//
//  LoginView.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            Image("login-bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            GeometryReader { geo in
                VStack(spacing: 12) {
                    Spacer()
                    TextField("Username", text: $viewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        Task {
                            await viewModel.login()
                        }
                    } label: {
                        Text("Login")
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.tertiaryColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, geo.size.height / 4)
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .onAppear {
            Task {
                await viewModel.viewDidLoad()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel(dataStore: LoginDataStoreImpl(loginService: AuthenticationService())))
    }
}
