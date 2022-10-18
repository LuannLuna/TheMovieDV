//
//  ImageLoader.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import UIKit

class ImageLoader: ObservableObject {
    @Published var downloadedData: UIImage?
    var imageCache = ImageCache.getImageCache()
    
    func loadImage(url: String) {
        if loadImageFromCache(url) { return }
        downloadImage(url: url)
    }
    
    private
    func downloadImage(url: String) {
        guard let imageURL = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            guard let data = data, error == nil else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.downloadedData = image
                self.imageCache.set(forKey: url, image: image)
            }
        }.resume()
    }
    
    private
    func loadImageFromCache(_ url: String) -> Bool {
        guard let cacheImage = imageCache.get(forKey: url) else {
            return false
        }
        
        downloadedData = cacheImage
        return true
    }
}
