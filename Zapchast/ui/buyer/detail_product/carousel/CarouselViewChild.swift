//
//  CarouselViewChild.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 14/9/24.
//

import SwiftUI

struct CarouselViewChild: View, Identifiable {
    var id: Int
    @ViewBuilder var content: any View
    
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}
