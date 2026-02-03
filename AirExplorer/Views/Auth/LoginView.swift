import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authStore: AuthStore
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: 25) {
            // Logo
            VStack {
                Image(systemName: "airplane")
                    .font(.system(size: 70))
                    .foregroundColor(.blue)
                
                Text("AirExplorer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            .padding(.top, 50)
            
            // Formulario
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    TextField("tu@email.com", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Contraseña")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    SecureField("••••••", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 30)
            
            // Botón login
            Button(action: {
                if authStore.login(email: email, password: password) {
                    // Login exitoso
                } else {
                    showingAlert = true
                }
            }) {
                Text("Iniciar sesión")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 30)
            .disabled(email.isEmpty || password.isEmpty)
            
            // Mensaje de error
            if let error = authStore.error {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.horizontal, 30)
            }
            
            Spacer()
            
            // Enlace a registro
            NavigationLink(destination: RegisterView()) {
                HStack {
                    Text("¿No tienes cuenta?")
                        .foregroundColor(.secondary)
                    Text("Regístrate")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom, 30)
        }
        .padding()
        .navigationBarHidden(true)
        .alert("Error de login", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(authStore.error ?? "Credenciales incorrectas")
        }
    }
}
