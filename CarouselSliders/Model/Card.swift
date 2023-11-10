//
//  Card.swift
//  CarouselSliders
//
//  Created by Omid Shojaeian Zanjani on 10/11/23.
//

import Foundation
import SwiftUI


struct Card: Identifiable, Hashable, Equatable {
    var id:UUID = .init()
    var image:String
    var previousOffset:CGFloat = 0
}
