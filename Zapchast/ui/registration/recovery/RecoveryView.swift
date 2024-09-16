//
//  RecoveryView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 8/9/24.
//

import SwiftUI

struct RecoveryView: View {
    @ObservedObject var viewModel = RecoveryViewModel()
    var isSeller: Bool = false
    var color: String = "#222222"
    @State var code: String = ""

    @State private var isInit = false

    var body: some View {
        VStack(spacing: 0) {
            // Top part with background color, including status bar area
            Color(hex: color)
                .ignoresSafeArea(edges: .top)
                .frame(height: 120) // Adjust height as needed

            Spacer()
        }
        .overlay {
            VStack {
                Text("ВОССТАНОВЛЕНИЕ")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 40)

                Spacer()

                VStack {
                    Text("ВНИМАНИЕ")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)

                    Text("МЫ ОТПРАВИЛИ ШЕСТИЗНАЧНЫЙ \nКОД НА ВАШ СОТОВЫЙ НОМЕР")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                }

                Spacer().frame(height: 40)

                HStack {
                    Text("ВАШ КОД")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                }.padding(.horizontal, 50)

//                CodeInputView(code: $code)
                CustomTextFieldWithIcon(placeholder: "Code", text: $code)
                    .padding(.horizontal)

                Spacer().frame(height: 40)

                Button(action: {
                    // Handle confirmation
                    viewModel.fetchRecovery(code: code, email: viewModel.prefs.getEmail() ?? "")
                }) {
                    Text("ПОДТВЕРДИТЬ")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: color))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 16)

                // NavigationLink для программного перехода
                NavigationLink(destination: LoginView(isSeller: isSeller), isActive: $viewModel.isVerify) {
                    EmptyView()
                }

                Spacer()
            }
        }

    }
}

#Preview {
    RecoveryView()
}
