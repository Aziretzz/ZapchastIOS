//
//  RegisterView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 8/9/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
       @State private var email: String = ""
       @State private var mobileNumber: String = ""
       @State private var password: String = ""
       @State private var confirmPassword: String = ""
       
       var body: some View {
           VStack {
               // Title
               Text("РЕГИСТРАЦИЯ")
                   .font(.system(size: 24, weight: .bold))
                   .foregroundColor(Color(hex: "#21263E"))
                   .padding(.top, 40)

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

               Spacer()

               // Already have an account
               HStack {
                   Text("Уже есть аккаунт?")
                       .font(.system(size: 16))
                   Button(action: {
                       // Handle login action
                   }) {
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

   // Reusable Custom TextField with an Icon
   struct CustomTextFieldWithIcon: View {
       var placeholder: String
       @Binding var text: String

       var body: some View {
           HStack {
               // Icon
               Image(systemName: "person.circle")
                   .foregroundColor(.gray)
               
               // TextField
               TextField(placeholder, text: $text)
                   .foregroundColor(.gray)
           }
           .padding()
           .background(
               RoundedRectangle(cornerRadius: 12)
                   .fill(Color.white)
                   .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
           )
           .overlay(
               RoundedRectangle(cornerRadius: 12)
                   .stroke(Color.gray.opacity(0.1), lineWidth: 1)
           )
           .padding(.bottom, 16)
       }
   }

   // Reusable Custom SecureField with an Icon and Eye Toggle
   struct CustomSecureFieldWithIcon: View {
       var placeholder: String
       @Binding var text: String
       @State private var isVisible: Bool = false

       var body: some View {
           HStack {
               // Icon
               Image(systemName: "lock.circle")
                   .foregroundColor(.gray)

               // SecureField or TextField depending on visibility toggle
               if isVisible {
                   TextField(placeholder, text: $text)
                       .foregroundColor(.gray)
               } else {
                   SecureField(placeholder, text: $text)
                       .foregroundColor(.gray)
               }

               // Show/hide password button
               Button(action: {
                   isVisible.toggle()
               }) {
                   Image(systemName: isVisible ? "eye.slash" : "eye")
                       .foregroundColor(.gray)
               }
           }
           .padding()
           .background(
               RoundedRectangle(cornerRadius: 12)
                   .fill(Color.white)
                   .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
           )
           .overlay(
               RoundedRectangle(cornerRadius: 12)
                   .stroke(Color.gray.opacity(0.1), lineWidth: 1)
           )
           .padding(.bottom, 16)
       }
   }

   extension Color {
       init(hex: String) {
           let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
           var int: UInt64 = 0
           Scanner(string: hex).scanHexInt64(&int)
           let a, r, g, b: UInt64
           switch hex.count {
           case 3: // RGB (12-bit)
               (a, r, g, b) = (255, (int >> 8 * 4) * 17, (int >> 4 * 4 & 0xF) * 17, (int & 0xF) * 17)
           case 6: // RGB (24-bit)
               (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
           case 8: // ARGB (32-bit)
               (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
           default:
               (a, r, g, b) = (255, 0, 0, 0)
           }
           self.init(
               .sRGB,
               red: Double(r) / 255,
               green: Double(g) / 255,
               blue: Double(b) / 255,
               opacity: Double(a) / 255
           )
       }
   }
#Preview {
    RegisterView()
}
