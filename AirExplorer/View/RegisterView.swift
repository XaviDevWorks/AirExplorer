//
//  ContentView.swift
//  AirExplorer
//
//  Created by alumne on 12/01/2026.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var user: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Crear Cuenta")
                .font(.title)
                .fontWeight(.bold)
                .padding([.top, .bottom], 20)
            
            TextField("Nombre", text: $user.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Email", text: $user.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("Contraseña", text: $user.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("Repetir contraseña", text: $user.passwordConfirm)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            if !user.errorMessage.isEmpty {
                Text(user.errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button("Registrarse") {
                user.register()
            }
            .padding()
            .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            
            Button("Cancelar") {
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.gray)
            
            Spacer()
        }
        .navigationBarTitle("Registro", displayMode: .inline)
    }
}
