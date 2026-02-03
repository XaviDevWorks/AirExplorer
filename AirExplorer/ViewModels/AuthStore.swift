import SwiftUI
import Security

class AuthStore: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoggedIn = false
    @Published var error: String?
    
    private let userKey = "airExplorerUsers"
    private let currentUserKey = "currentAirExplorerUser"
    
    init() {
        // Verificar si hay usuario guardado
        if let userData = UserDefaults.standard.data(forKey: currentUserKey),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            currentUser = user
            isLoggedIn = true
        }
    }
    
    func login(email: String, password: String) -> Bool {
        guard let usersData = UserDefaults.standard.data(forKey: userKey),
              var users = try? JSONDecoder().decode([User].self, from: usersData) else {
            error = "No hay usuarios registrados"
            return false
        }
        
        if let user = users.first(where: { $0.email == email && $0.password == password }) {
            currentUser = user
            isLoggedIn = true
            
            // Guardar usuario actual
            if let userData = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(userData, forKey: currentUserKey)
            }
            
            error = nil
            return true
        } else {
            error = "Email o contraseña incorrectos"
            return false
        }
    }
    
    func register(name: String, email: String, password: String) -> Bool {
        // Validaciones básicas
        guard !name.isEmpty else {
            error = "El nombre es obligatorio"
            return false
        }
        
        guard isValidEmail(email) else {
            error = "Email no válido"
            return false
        }
        
        guard password.count >= 6 else {
            error = "La contraseña debe tener al menos 6 caracteres"
            return false
        }
        
        // Cargar usuarios existentes
        var users = [User]()
        if let usersData = UserDefaults.standard.data(forKey: userKey),
           let existingUsers = try? JSONDecoder().decode([User].self, from: usersData) {
            users = existingUsers
        }
        
        // Verificar si el email ya existe
        if users.contains(where: { $0.email == email }) {
            error = "Este email ya está registrado"
            return false
        }
        
        // Crear nuevo usuario
        let newUser = User(name: name, email: email, password: password)
        users.append(newUser)
        
        // Guardar usuarios
        if let usersData = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(usersData, forKey: userKey)
            
            // Iniciar sesión automáticamente
            currentUser = newUser
            isLoggedIn = true
            
            // Guardar usuario actual
            if let userData = try? JSONEncoder().encode(newUser) {
                UserDefaults.standard.set(userData, forKey: currentUserKey)
            }
            
            error = nil
            return true
        }
        
        error = "Error al registrar usuario"
        return false
    }
    
    func logout() {
        currentUser = nil
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: currentUserKey)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
