//
//  LoginViewModel.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 10/4/2567 BE.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 10) {
                    Text("Travel Music")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Find music on your ways")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                .padding(.top, 70)

                VStack {
                    TextField("Name", text: $viewModel.email)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(20)
                        .padding(.horizontal, 40)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(20)
                        .padding(.horizontal, 40)

                    Button(action: {
                        viewModel.login()
                    }) {
                        Text("Log in")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.pink)
                            .cornerRadius(20)
                            .padding(.horizontal, 40)
                    }
                }
                .padding(.top, 40)

                VStack {
                    Text("Don't have an Account?")
                    NavigationLink("Create an Account", destination: RegisterView())
                        .foregroundColor(Color.blue)
                }
                .padding(.top, 20)
            }
            .background(Color(hex: "E1F16B"))
            .edgesIgnoringSafeArea(.all)
        }
        .foregroundColor(Color(hex: "272727"))
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
