//
//  CarouselView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 14/9/24.
//

import SwiftUI

struct CarouselView: View {
    @State private var snappedItem = 0.0
    @State private var draggingItem = 1.0
    @State private var activeIndex: Int = 0
    
    var views: [CarouselViewChild]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CarouselView()
}
