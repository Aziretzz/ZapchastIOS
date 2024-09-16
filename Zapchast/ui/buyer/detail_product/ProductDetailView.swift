//
//  ProductDetailView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 14/9/24.
//
import SwiftUI

struct ProductDetailView: View {
    @State private var selectedImage = 0
    let images = ["", "onboard2", "onboard3"] // Replace with actual image names

    var body: some View {
        VStack {
            
            // Top bar
            ZStack {
                Color(hex: "#550486")
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 80)
                
                
                Text("Детали продукта")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
            }
            .frame(maxWidth: .infinity)
            
            ScrollView {
                VStack {
                    
                    CarouselView(views: getChildViews())
                    
                    Spacer().frame(height: 40)
                    
                    // Middle Section: Price, Title and Description
                    VStack {
                        HStack {
                            Text("7 000с")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button(action: {
                                // Share action
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.red)
                                    .font(.title)
                            }
                            
                            Button(action: {
                                // Favorite action
                            }) {
                                Image(systemName: "heart")
                                    .foregroundColor(.white)
                                    .font(.title)
                            }
                            
                            Button(action: {
                                // Favorite action
                            }) {
                                Image(systemName: "star")
                                    .foregroundColor(.white)
                                    .font(.title)
                            }
                        }
                        .padding()
                        .padding(.horizontal, 20)
                        
                        Text("РУЛЬ ЛЕКСУСА GX470 2009Г. НОВЫЙ")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        
                        // Description
                        Text("""
                    Левый руль. Контрактный, без пробега по КР.
                    Lexus GX470 1 поколение (01.2002 - 07.2009)
                    Гарантия и прочие плюшки руль идеалка просто покупай родной не пожалеешь новый отвечаю
                    клянусь зубом своей кошки и детьми своей собаки и свободой жены
                    """)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        
                        // Details Section (Brand, Compatibility, Stock, etc.)
                        VStack(alignment: .leading, spacing: 8) {
                            DetailRow(label: "МАРКА:", value: "LEXUS")
                            DetailRow(label: "ПОДОЙДЕТ:", value: "1ПОК. 2002 - 2009")
                            DetailRow(label: "КОЛИЧЕСТВО НА СКЛАДЕ:", value: "16")
                            DetailRow(label: "СОСТОЯНИЕ:", value: "НОВЫЙ")
                            DetailRow(label: "ГАРАНТИЯ:", value: "ЕСТЬ")
                            DetailRow(label: "ТОРГ:", value: "НЕТ")
                        }
                        .padding()
                    }
                    .background(Color(hex: "#adb3bf"))
                    .clipShape(RoundedCorners(topLeft: 40, topRight: 40))
                }
            }
        }
    }

    func getChildViews() -> [CarouselViewChild] {
        var tempViews: [CarouselViewChild] = []

        for i in (1...3) {
            tempViews.append(CarouselViewChild(id: i, content: {
                ZStack {
                    Image("onboard\(i)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .mask {
                            RoundedRectangle(cornerRadius: 18)
                                .frame(width: 300, height: 400)
                        }
                }
                .frame(width: 300, height: 400)
                .shadow(radius: 10)
            }))
        }
        return tempViews
    }
}

struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(Color(hex: "#550486"))
        }
    }
}

#Preview {
    ProductDetailView()
}

