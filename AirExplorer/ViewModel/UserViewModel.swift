//
//  UserViewModel.swift
//  AirExplorer
//
//  Created by alumne on 12/01/2026.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var isLoggedIn = false
    @Published var errorMessage = ""
    @Published var passwordConfirm = ""

    // Usuario de prueba
    private let testUser = User(
        email: "Test@test.com",
        password: "123456",
        name: "Usuario Test"
    )
    
    func login() {
        if email == testUser.email && password == testUser.password {
            isLoggedIn = true
            errorMessage = ""
        } else {
            errorMessage = "Email o contraseña incorrectos"
        }
    }
    
    func register() {
        if email.isEmpty || password.isEmpty || name.isEmpty {
            errorMessage = "Todos los campos son obligatorios"
            return
        }
        
        if password.count < 6 {
            errorMessage = "La contraseña debe tener al menos 6 caracteres"
            return
        }

        if password != passwordConfirm {
            errorMessage = "Las contraseñas no coinciden"
            return
        }
        
        // Registro exitoso (simulado)
        isLoggedIn = true
        errorMessage = ""
    }
    
    func logout() {
        isLoggedIn = false
        email = ""
        password = ""
        name = ""
    }
}
