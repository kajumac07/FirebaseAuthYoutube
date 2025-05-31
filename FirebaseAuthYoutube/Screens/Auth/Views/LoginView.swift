//Login View


import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isAnimating = false
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.teal.opacity(0.2), Color.purple.opacity(0.1)]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            NavigationStack{
                ScrollView {
                    VStack(spacing: 24) {
                        // Animated logo
                        logo
                        
                        // Title with gradient
                        Text("Welcome Back!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.teal, .indigo]),
                                                            startPoint: .leading, endPoint: .trailing))
                        
                        Text("Let's connect with your community")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        // TextFields with floating labels
                        FloatingLabelInput(placeholder: "Email", text: $email, systemImage: "envelope")
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                        
                        FloatingLabelInput(placeholder: "Password", text: $password, isSecure: true, systemImage: "lock")
                            .textContentType(.password)
                        
                        // Forgot password
                        HStack {
                            Spacer()
                            Button(action: {}) {
                                Text("Forgot Password?")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.teal)
                            }
                        }
                        
                        // Login button
                        Button(action: {
                            Task{
                                await authViewModel.loginUser(email: email, password: password)
                            }
                        }) {
                            HStack {
                                Text("Login")
                                    .fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(GradientButtonStyle())
                        .padding(.top, 8)
                        
                        // Divider section
                        HStack {
                            line
                            Text("or continue with").font(.caption).foregroundColor(.gray)
                            line
                        }
                        
                        // Social login buttons
                        HStack(spacing: 16) {
                            SocialLoginButton(icon: "apple.logo", text: "Apple", color: .black)
                            SocialLoginButton(icon: "g.circle.fill", text: "Google", color: .red)
                        }
                        .padding(.top, 8)
                        
                        // Sign up prompt
                        NavigationLink{
                            //move to signup screen
                            CreateAccountView().environmentObject(authViewModel);
                            
                        } label: {
                            HStack {
                                Text("Don't have an account?")
                                    .foregroundColor(.gray)
                                Text("Sign up")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.teal)
                            }
                            .font(.footnote)
                            .padding(.top, 24)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
    
    private var line: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.gray.opacity(0.3))
            .frame(maxWidth: .infinity)
    }
    
    private var logo:some View{
        Image(systemName: "person.2.wave.2.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 60)
            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.teal, .purple]),
                                            startPoint: .leading, endPoint: .trailing))
            .scaleEffect(isAnimating ? 1.1 : 1.0)
            .rotationEffect(.degrees(isAnimating ? -5 : 5))
            .animation(Animation.easeInOut(duration: 2).repeatForever(), value: isAnimating)
            .padding(.top, 40)
    }
}

// MARK: - Custom Components

struct FloatingLabelInput: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var systemImage: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                if let systemImage = systemImage {
                    Image(systemName: systemImage)
                        .foregroundColor(.gray.opacity(0.8))
                }
                
                if isSecure {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(text.isEmpty ? Color.gray.opacity(0.3) : Color.teal.opacity(0.5), lineWidth: 1)
            )
            .animation(.easeInOut(duration: 0.2), value: text.isEmpty)
            
            if !text.isEmpty {
                Text(placeholder)
                    .font(.caption)
                    .foregroundColor(.teal)
                    .padding(.horizontal, 8)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .animation(.easeInOut, value: text.isEmpty)
    }
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [.teal, .indigo]),
                             startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct SocialLoginButton: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                Text(text)
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(color)
            .cornerRadius(10)
        }
    }
}

// MARK: - Preview

#Preview {
    LoginView()
}
