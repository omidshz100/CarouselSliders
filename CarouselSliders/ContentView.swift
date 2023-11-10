//
//  ContentView.swift
//  CarouselSliders
//
//  Created by Omid Shojaeian Zanjani on 10/11/23.
//
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            Home()
                .navigationTitle("CarouselSliders")
        }
    }
}

#Preview {
    ContentView()
}
