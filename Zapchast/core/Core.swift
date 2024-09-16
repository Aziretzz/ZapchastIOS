//
//  Core.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 8/9/24.
//

import SwiftUI

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


struct CodeInputView: View {
    @Binding var code: String  // Храним весь код как строку
    @FocusState private var focusedField: Int?

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<6, id: \.self) { index in
                TextField("", text: Binding(
                    get: {
                        if index < code.count {
                            let indexStart = code.index(code.startIndex, offsetBy: index)
                            return String(code[indexStart])
                        } else {
                            return ""
                        }
                    },
                    set: { newValue in
                        if newValue.count <= 1 {
                            if index < code.count {
                                let indexStart = code.index(code.startIndex, offsetBy: index)
                                code.replaceSubrange(indexStart...indexStart, with: newValue)
                            } else if newValue.count == 1 {
                                code.append(newValue)
                            }
                        }

                        // Автоматический переход на следующую ячейку
                        if newValue.count == 1 && index < 5 {
                            focusedField = index + 1
                        } else if newValue.isEmpty && index > 0 {
                            focusedField = index - 1
                        }
                    }
                ))
                .frame(width: 50, height: 50)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
                .focused($focusedField, equals: index)
            }
        }
        .onAppear {
            focusedField = 0  // Автоматически фокусируем на первом поле
        }
    }
}

struct ItemRow: View {
    var color: String = "#222222"
    var isSeller: Bool = false
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            if isSeller {
                HStack {
                    
                    Button(action: {
                        // Delete action
                    }) {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.red)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    Spacer()
                    Button(action: {
                        // Share action
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.orange)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    Spacer()
                    Button(action: {
                        // Edit action
                    }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.orange)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                }
            }

            
            HStack {
                
                Spacer()
                
                // Item image
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
                
                Spacer()
            }
            // Title and description
            Text(item.title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .lineLimit(2)
            
            Text("КАТЕГОРИЯ: \(item.category)")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Text(item.description)
                .font(.system(size: 14))
                .foregroundColor(.black)
                .lineLimit(2)
            
            // Footer with stats
            HStack {
                Text(item.price)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(hex: color))
                
                Spacer()
                
                HStack(spacing: 10) {
                    Label("\(item.views)", systemImage: "eye.fill")
                    Label("\(item.comments)", systemImage: "message.fill")
                    Label("\(item.likes)", systemImage: "heart.fill")
                    Label(item.timeLeft, systemImage: "clock.fill")
                }
                .font(.system(size: 14))
                .foregroundColor(.gray)
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

struct ChatRowView: View {
    var chat: Chat
    
    var body: some View {
        HStack {
            Image(chat.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(chat.name)
                    .font(.headline)
                
                Text(chat.lastMessage)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(chat.time)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}


import SwiftUI

struct RoundedCorners: Shape {
    var topLeft: CGFloat = 0
    var topRight: CGFloat = 0
    var bottomLeft: CGFloat = 0
    var bottomRight: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        
        // Top left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + topLeft))
        path.addArc(withCenter: CGPoint(x: rect.minX + topLeft, y: rect.minY + topLeft),
                    radius: topLeft,
                    startAngle: .pi,
                    endAngle: 3 * .pi / 2,
                    clockwise: true)
        
        // Top right corner
        path.addLine(to: CGPoint(x: rect.maxX - topRight, y: rect.minY))
        path.addArc(withCenter: CGPoint(x: rect.maxX - topRight, y: rect.minY + topRight),
                    radius: topRight,
                    startAngle: 3 * .pi / 2,
                    endAngle: 0,
                    clockwise: true)
        
        // Bottom right corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRight))
        path.addArc(withCenter: CGPoint(x: rect.maxX - bottomRight, y: rect.maxY - bottomRight),
                    radius: bottomRight,
                    startAngle: 0,
                    endAngle: .pi / 2,
                    clockwise: true)
        
        // Bottom left corner
        path.addLine(to: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY))
        path.addArc(withCenter: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY - bottomLeft),
                    radius: bottomLeft,
                    startAngle: .pi / 2,
                    endAngle: .pi,
                    clockwise: true)
        
        path.close()
        
        return Path(path.cgPath)
    }
}
