//
//  LoginView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 8/9/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    var isSeller = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State var registered = false

    var body: some View {
        VStack(spacing: 0) {

            // Top bar with background color that covers full screen width
            ZStack {
                Color(hex: "#232A40") // Цвет, как на вашем скриншоте
                    .ignoresSafeArea(edges: .top) // Распространяем цвет на статус-бар
                    .frame(height: 120) // Устанавливаем высоту верхней панели

                Text("ВХОД")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity) // Растягиваем по горизонтали

            Spacer()

            VStack {
                // Image (replace "loginImage" with your image asset)
                Image("login") // Add the actual image to Assets.xcassets
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.top, 16)

                // Email Field
                CustomTextFieldWithIcon(placeholder: "Email", text: $email)

                // Password Field
                CustomSecureFieldWithIcon(placeholder: "Password", text: $password)

                // Forgot Password
                HStack {
                    Spacer()
                    Button(action: {
                        // Forgot password action
                    }) {
                        Text("ЗАБЫЛИ ПАРОЛЬ?")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 16)

                // Login Button
                Button(action: {
                    // Handle login action
                    viewModel.fetchRegister(email: email, password: password)
                    
                    if viewModel.isLogined {
                        if let window = UIApplication.shared.windows.first {
                            window.rootViewController = UIHostingController(rootView: MainView())
                            window.makeKeyAndVisible()
                        }
                    }
                }) {
                    Text("ВОЙТИ")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#21263E"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 16)

                Spacer().frame(height: 16)

                
                
                
                // Sign Up Option
                HStack {
                    Text("У вас нету аккаунта?")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)

                    Button(action: {
                        // Sign up action
                        registered = true
                    }) {
                        Text("Регистрируйся!")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 8)
                
                
                // NavigationLink to trigger navigation programmatically
                NavigationLink(destination: RecoveryView(isSeller: false, color: "#550486"), isActive: $registered) {
                    EmptyView()
                }


                Spacer().frame(height: 16)

                // Google Sign In Button
                Button(action: {
                    // Google sign in action
                }) {
                    HStack {
                        Spacer()
                        Image("google") // Replace with Google icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(.vertical, 8)

                        Spacer()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                    )
                    .padding(.horizontal, 16)
                }

                Spacer()
            }
            .padding(.horizontal, 30) // Отступы для содержимого ниже topBar
        }
        .onChange(of: viewModel.isLogined) { isLogined in
            if isLogined {
                if isSeller {
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UIHostingController(rootView: MainView())
                        window.makeKeyAndVisible()
                    }
                } else {
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UIHostingController(rootView: HomeView())
                        window.makeKeyAndVisible()
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
