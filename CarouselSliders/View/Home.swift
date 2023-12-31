//
//  Home.swift
//  CarouselSliders
//
//  Created by Omid Shojaeian Zanjani on 10/11/23.
//

import Foundation
import SwiftUI


struct Home:View {
    @State private var cards:[Card] = [
        .init(image: "Pic 1"),
        .init(image: "Pic 2"),
        .init(image: "Pic 3"),
        .init(image: "Pic 4"),
        .init(image: "Pic 5"),
        .init(image: "Pic 6"),
        .init(image: "Pic 7"),
        .init(image: "Pic 8")
    ]
    @State private var currentScrollID: UUID?
    var body: some View {
        VStack{
            GeometryReader{
                let size = $0.size
                ScrollView(.horizontal){
                    HStack(spacing:10){
                        ForEach(cards, id: \.id){ card in
                            CardView(card)
                        }
                    }
                    .padding(.trailing, size.width - 180)
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $currentScrollID)
                .scrollIndicators(.hidden)
                .clipShape(.rect(cornerRadius: 25))
                /// Advanced Method
                .onChange(of: size, initial: false) { oldValue, newValue in
                    if oldValue.width != newValue.width {
                        if let card = cards.first(where: {
                            $0.id == currentScrollID
                        }) {
                            currentScrollID = nil
                            DispatchQueue.main.async {
                                withAnimation(.snappy) {
                                    currentScrollID = card.id
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.top, 30)
            .frame(height: 210)
            
            Spacer(minLength: 0)
        }
    }
    
    /// Card View
    @ViewBuilder
    func CardView(_ card: Card) -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            let minX = proxy.frame(in: .scrollView).minX
            /// 190: 180 - Card Width; 10 - Spacing
            let reducingWidth = (minX / 190) * 130
            let cappedWidth = min(reducingWidth, 130)
            
            let frameWidth = size.width - (minX > 0 ? cappedWidth : -cappedWidth)
            
            Image(card.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .frame(width: frameWidth < 0 ? 0 : frameWidth)
                .clipShape(.rect(cornerRadius: 25))
                .offset(x: minX > 0 ? 0 : -cappedWidth)
                .offset(x: -card.previousOffset)
        }
        .frame(width: 180, height: 200)
        .offsetX { offset in
            let reducingWidth = (offset / 190) * 130
            let index = cards.indexOf(card)
            
            if cards.indices.contains(index + 1) {
                cards[index + 1].previousOffset = (offset < 0 ? 0 : reducingWidth)
            }
        }
    }
}




#Preview {
    ContentView()
}
