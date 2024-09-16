//
//  RoleSelectionView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 8/9/24.
//

import SwiftUI

struct RoleSelectionView: View {
    @ObservedObject var viewModel = RoleViewModel()
    @State var go = false
    @State var isSeller = ""
    var body: some View {
        VStack(spacing: 0) {
            
            // Top bar with background color matching text color
            ZStack {
                Color.orange // Цвет, такой же как у текста заголовка
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 120)

                Text("ВЫБЕРИТЕ РОЛЬ")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity) // Растягиваем по горизонтали

            Spacer()

            // Role 1: Коммерсант
            VStack {
                Text("Коммерсант")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)

                Spacer().frame(height: 16)

                Text("Продавайте свои товары с полным удобством. Регистрируйте свой магазин или осуществляйте продажи онлайн, не выходя из дома.")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)

                ZStack(alignment: .bottom) {
                    HStack {
                        Spacer()
                        // Image on the left
                        Image("seller") // Убедитесь, что изображение добавлено в Assets.xcassets
                            .resizable()
                            .frame(width: 130, height: 130)
                            .scaledToFit()
                    }
                    
                    
                    Button(action: {
                        isSeller = "seller"
                        go = true
                        viewModel.setSeller(isSeller: true)
                    }) {
                        Text("ПРОДОЛЖИТЬ")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                            .padding(.horizontal, 16)
                    }
                }
                .padding(.horizontal, 16) // Отступ по горизонтали
            }

            Spacer()

            Divider()
                .frame(height: 1)
                .background(Color.gray)
                .padding(.horizontal, 16)

            Spacer()

            // Role 2: Покупатель
            VStack {
                Text("Покупатель")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.purple)

                Spacer().frame(height: 16)

                Text("Ищите товары с комфортом, где бы вы ни находились. В приложении вас ждет удобная система поиска и легкая покупка.")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)

                ZStack(alignment: .bottom) {
                    HStack {
                        // Image Placeholder (replace with actual image)
                        Image("buyer") // Add the actual image to Assets.xcassets
                            .resizable()
                            .frame(width: 130, height: 130)
                            .scaledToFit()
                            .padding()
                        Spacer()
                    }

                    Button(action: {
                        isSeller = "buyer"
                        go = true
                        viewModel.setSeller(isSeller: false)
                    }) {
                        Text("ПРОДОЛЖИТЬ")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                            .padding(.horizontal, 16)
                    }
                    .padding(.bottom, 16)
                }
                .frame(height: 130)
            }
            
            if isSeller == "seller" {
                // NavigationLink to trigger navigation programmatically
                NavigationLink(destination: RegisterSellerView(), isActive: $go) {
                    EmptyView()
                }
            } else {
                // NavigationLink to trigger navigation programmatically
                NavigationLink(destination: RegisterBuyerView(), isActive: $go) {
                    EmptyView()
                }
            }

            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    RoleSelectionView()
}
