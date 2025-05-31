//Create Account


import SwiftUI

struct CreateAccountView: View {
    @State private var email: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isAnimating = false
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.1), Color.teal.opacity(0.1)]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header with animation
                    VStack(spacing: 8) {
                        Image(systemName: "person.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.indigo, .teal]),
                                                  startPoint: .leading, endPoint: .trailing))
                            .scaleEffect(isAnimating ? 1.05 : 0.95)
                            .animation(Animation.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
                        
                        Text("Create Account")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.indigo, .teal]),
                                                  startPoint: .leading, endPoint: .trailing))
                    }
                    .padding(.top, 20)
                    
                    Text("Please complete all information to create your account")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                    
                    // Form fields
                    VStack(spacing: 20) {
                        FloatingLabelInput(placeholder: "Full Name", text: $fullName, systemImage: "person")
                            .textContentType(.name)
                            .autocapitalization(.words)
                        
                        FloatingLabelInput(placeholder: "Email", text: $email, systemImage: "envelope")
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                        
                        FloatingLabelInput(placeholder: "Password", text: $password, isSecure: true, systemImage: "lock")
                            .textContentType(.newPassword)
                        
                        FloatingLabelInput(placeholder: "Confirm Password", text: $confirmPassword, isSecure: true, systemImage: "lock.fill")
                            .textContentType(.newPassword)
                            .overlay(
                                Group {
                                    if !confirmPassword.isEmpty && !isPasswordValid {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                            .padding(.trailing, 16)
                                    } else if isPasswordValid && !password.isEmpty {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                            .padding(.trailing, 16)
                                    }
                                }
                                .animation(.easeInOut, value: isPasswordValid),
                                alignment: .trailing
                            )
                    }
                    .padding(.vertical, 16)
                    
                    // Password requirements
                    if !password.isEmpty {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Password Requirements:")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            RequirementRow(isMet: password.count >= 8, text: "At least 8 characters")
                            RequirementRow(isMet: containsNumber(), text: "Contains a number")
                            RequirementRow(isMet: containsSpecialChar(), text: "Contains special character")
                            RequirementRow(isMet: isPasswordValid, text: "Passwords match")
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                    
                    Spacer()
                    
                    // Create Account button
                    Button(action: {
                        Task{
                            await authViewModel.createUserAc(email: email, fullName: fullName, password: password)
                        }
                    }) {
                        HStack {
                            Text("Create Account")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GradientButtonStyle())
                    .disabled(!isFormValid)
                    .opacity(isFormValid ? 1 : 0.6)
                    .animation(.easeInOut, value: isFormValid)
                    
                    // Already have account
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.gray)
                        NavigationLink(destination: LoginView()) {
                            Text("Sign in")
                                .fontWeight(.semibold)
                                .foregroundColor(.teal)
                        }
                    }
                    .font(.footnote)
                    .padding(.top, 8)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            isAnimating = true
        }
    }
    
    // Form validation
    var isPasswordValid: Bool {
        !password.isEmpty && password == confirmPassword
    }
    
    var isFormValid: Bool {
        !email.isEmpty &&
        !fullName.isEmpty &&
        !password.isEmpty &&
        isPasswordValid &&
        password.count >= 8 &&
        containsNumber() &&
        containsSpecialChar()
    }
    
    private func containsNumber() -> Bool {
        password.rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    private func containsSpecialChar() -> Bool {
        let specialChars = "!@#$%^&*()-_=+[]{}|;:,.<>?"
        return password.rangeOfCharacter(from: CharacterSet(charactersIn: specialChars)) != nil
    }
}

// MARK: - Custom Components

struct RequirementRow: View {
    let isMet: Bool
    let text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: isMet ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isMet ? .green : .gray)
            Text(text)
                .font(.caption)
                .foregroundColor(isMet ? .primary : .secondary)
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        CreateAccountView()
    }
}
