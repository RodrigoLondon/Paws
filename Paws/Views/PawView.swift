//
//  PawView.swift
//  Paws
//
//  Created by Rodrigo Peña on 6/8/25.
//

import SwiftUI

struct PawView: View {
    var body: some View {
        VStack {
            Image("paw").placeholder(width: 100, height: 100)
        }
    }
}

#Preview {
    PawView()
}
