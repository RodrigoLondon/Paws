//
//  BreedListView.swift
//  Paws
//
//  Created by Rodrigo Peña on 3/8/25.
//

import SwiftUI
internal import Combine

// MARK: - BreedList View

struct BreedListView<ViewModel: BreedListViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    let onBreedTap: (String) -> Void

    var body: some View {
        List(viewModel.breeds, id: \.self) { breed in
            HStack {
                Image(systemName: "dog")
                    .imageScale(.medium)
                    .foregroundStyle(.tint)
                Button(breed.capitalized) {
                    onBreedTap(breed)
                }
            }
        }
        .onAppear(perform: viewModel.load)
        .navigationTitle("Breeds")
    }
}

// MARK: - Preview with Mock for BreedListView

#Preview {
    return  NavigationStack {
        BreedListView(viewModel: MockBreedListViewModel()) { breed in
            print("Tapped on \(breed)")
        }
    }
}
