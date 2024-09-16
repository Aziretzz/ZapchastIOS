//
//  ProfileView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 10/9/24.
//

import SwiftUI

struct ProfileView: View {
    var color: String = "#222222"
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Profile picture and details
            VStack(spacing: 10) {
                // Profile Picture
                Image("onboard3") // Replace with your profile image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .padding(.top, -50) // Pull image above the section border
                
                // Profile Name and Address
                Text("Мямятали Бишимбаев")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    
                
                Text("Ош - КУДАЙБЕРГЕН - 3 РЯД 2 КОНТЕЙНЕР")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer().frame(height: 20)
                
                // Edit Button
                Button(action: {
                    // Action for Edit button
                }) {
                    Text("Редактировать")
                        .font(.system(size: 16, weight: .bold))
                        .frame(width: 160, height: 44)
                        .background(Color(hex: color))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.top, 20)
            
            Divider().padding(.horizontal)
            
            Spacer().frame(height: 40)
            
            // Menu Items
            VStack(spacing: 10) {
                ProfileMenuItem(color: color, title: "Настройки", iconName: "gearshape.fill")
                ProfileMenuItem(color: color, title: "Язык", iconName: "globe")
                ProfileMenuItem(color: color, title: "Темная тема", iconName: "moon.fill")
                
                Divider().padding(.horizontal)
                
                
                HStack {
                    
                    HStack {
                        Image(systemName: "arrow.backward.square.fill")
                            .foregroundColor(.red)
                            .background(Color(hex: color))
                            .cornerRadius(8)
                            .padding(.trailing, 10)
                        
                        Text("Выйти")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.red)
                        
                        Spacer().frame(width: 20)
                    }
                    .padding()
                    .background(Color(hex: color))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.leading)
                    
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                            .background(Color(hex: color))
                            .cornerRadius(8)
                            .padding(.trailing)
                        
                        Text("Политика конфиденциальности")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.blue)
                        
                        
                    }
                    .padding()
                    .background(Color(hex: color))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
            }
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct ProfileMenuItem: View {
    let color: String
    let title: String
    let iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.white)
                .background(Color(hex: color))
                .cornerRadius(8)
                .padding(.trailing, 10)
            
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.white)
        }
        .padding()
        .background(Color(hex: color))
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}



#Preview {
    ProfileView(color: "")
}
