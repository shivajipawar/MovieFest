//
//  CachedAsyncImage.swift
//  MovieFest
//
//  Created by Shivaji N. Pawar on 07/09/25.
//

import SwiftUI

import SwiftUI

struct CachedAsyncImage: View {
    @State private var uiImage: UIImage?
    @State private var isLoading = false

    let url: URL?
    let placeholder: AnyView

    init(url: URL?, placeholder: AnyView = AnyView(Color.gray)) {
        self.url = url
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else if isLoading {
                ProgressView()
            } else {
                placeholder
            }
        }
        .task {
            await loadImage()
        }
    }

    private func loadImage() async {
        guard let url = url, uiImage == nil else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
            let (data, _) = try await URLSession.shared.data(for: request)
            if let image = UIImage(data: data) {
                uiImage = image
            }
        } catch {
            print("❌ Image load failed: \(error)")
        }
    }
}
