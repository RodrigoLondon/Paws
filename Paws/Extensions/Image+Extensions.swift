//
//  Image+Extensions.swift
//  Paws
//
//  Created by Rodrigo Peña on 3/8/25.
//

import SwiftUI

extension Image {
    func placeholder(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .foregroundColor(.clear)
            .frame(width: width, height: height)
    }
}
