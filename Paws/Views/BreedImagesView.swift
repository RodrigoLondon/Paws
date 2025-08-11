//
//  BreedImagesView.swift
//  Paws
//
//  Created by Rodrigo Peña on 3/8/25.
//

import SwiftUI
internal import Combine

struct BreedImagesView<ViewModel: BreedImagesViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    @State private var selected: Bool = false
    @State private var selectedImage: URL? = nil
    
    let gridItems = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: gridItems) {
                    ForEach(viewModel.images, id: \.self) { url in
                        AsyncImage(url: url) { image in
                            image.resizable().aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedImage = url
                        }
                    }
                }
                .padding()
            }
            .blur(radius: selectedImage != nil ? 10 : 0)
            
            if let selected = selectedImage {
                Color.black.opacity(0.1).ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            selectedImage = nil
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                    
                    AsyncImage(url: selected) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 400)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 10)
                    } placeholder: {
                            ProgressView().controlSize(.extraLarge)

                    }
                    Spacer()
                }
                .transition(.scale.combined(with: .opacity))
            }
        }
        .onAppear(perform: viewModel.load)
        .navigationTitle(viewModel.breed.capitalized)
        .animation(.easeInOut, value: selectedImage)
    }
}


// MARK: - Preview with Mock for BreedImagesView

#Preview {
    return NavigationStack {
        BreedImagesView(viewModel: MockBreedImagesViewModel())
    }
}
