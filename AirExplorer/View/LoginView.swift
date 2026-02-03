//
//  LoginView.swift
//  AirExplorer
//
//  Created by alumne on 12/01/2026.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Image("AirExplorer")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.top, 40)
                Text("AirExplorer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                    .foregroundColor(.blue)

                TextField("Email", text: $user.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                SecureField("Contraseña", text: $user.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                if !user.errorMessage.isEmpty {
                    Text(user.errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button("Iniciar Sesión") {
                    user.login()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                NavigationLink(destination: RegisterView()) {
                    Text("Crear Cuenta")
                        .foregroundColor(.blue)
                }
                .padding()
                
                VStack {
                    Text("Usuario de prueba:")
                        .font(.caption)
                    Text("Test@test.com / 123456")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}
