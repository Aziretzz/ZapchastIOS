//
//  RegisterView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 8/9/24.
//

import SwiftUI

struct RegisterSellerView: View {
    @ObservedObject var viewModel = RegisterViewModel()
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var mobileNumber: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var isLoginActive: Bool = false

    var body: some View {
        VStack(spacing: 0) {

            // Top bar with background color matching text color
            ZStack {
                Color(hex: "#21263E") // Цвет, как у текста заголовка
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 120)

                Text("РЕГИСТРАЦИЯ")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity) // Растягиваем по горизонтали

            VStack {
                Text("ПРОДАВЕЦ")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 16)

                Spacer().frame(height: 20)

                // Username Field
                CustomTextFieldWithIcon(placeholder: "Username", text: $username)

                // Email Field
                CustomTextFieldWithIcon(placeholder: "Email", text: $email)

                // Mobile Number Field
                CustomTextFieldWithIcon(placeholder: "Mobile Number", text: $mobileNumber)

                // Password Field
                CustomSecureFieldWithIcon(placeholder: "Password", text: $password)

                // Confirm Password Field
                CustomSecureFieldWithIcon(placeholder: "Confirm Password", text: $confirmPassword)

                // Register Button
                Button(action: {
                    // Handle registration action
                    isLoginActive = true
                    viewModel.fetchRegister(
                        model: RegisterModel(id: 0, username: username, password: password, email: email, phone_number: mobileNumber, user_type: "seller", email_veryfied: false),
                        password2: confirmPassword)
                    
                    
                }) {
                    Text("ВОЙТИ")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#21263E"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 20)

                // NavigationLink to trigger navigation programmatically
                NavigationLink(destination: RecoveryView(isSeller: true, color: "#21263E"), isActive: $isLoginActive) {
                    EmptyView()
                }

                Spacer()

                // Already have an account
                HStack {
                    Text("Уже есть аккаунт?")
                        .font(.system(size: 16))

                    NavigationLink(destination: LoginView()) {
                        Text("Вход")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    RegisterSellerView()
}
