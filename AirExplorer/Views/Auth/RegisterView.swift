import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authStore: AuthStore
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: 25) {
            // Header
            VStack {
                Image(systemName: "person.crop.circle.badge.plus")
                    .font(.system(size: 70))
                    .foregroundColor(.blue)
                
                Text("Crear cuenta")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            .padding(.top, 30)
            
            // Formulario
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nombre completo")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    TextField("Tu nombre", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                
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
                    
                    SecureField("Mínimo 6 caracteres", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Confirmar contraseña")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    SecureField("Repite la contraseña", text: $confirmPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 30)
            
            // Validaciones
            VStack(alignment: .leading, spacing: 5) {
                if !password.isEmpty && password.count < 6 {
                    Text("⚠️ La contraseña debe tener al menos 6 caracteres")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
                
                if !confirmPassword.isEmpty && password != confirmPassword {
                    Text("⚠️ Las contraseñas no coinciden")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
                
                if let error = authStore.error {
                    Text("❌ \(error)")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal, 30)
            
            // Botón registro
            Button(action: {
                if authStore.register(name: name, email: email, password: password) {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    showingAlert = true
                }
            }) {
                Text("Registrarse")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 30)
            .disabled(name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty || password != confirmPassword)
            
            Spacer()
            
            // Enlace a login
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Text("¿Ya tienes cuenta?")
                        .foregroundColor(.secondary)
                    Text("Inicia sesión")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom, 30)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancelar") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.blue)
            }
        }
        .alert("Error de registro", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(authStore.error ?? "Error al crear la cuenta")
        }
    }
}
