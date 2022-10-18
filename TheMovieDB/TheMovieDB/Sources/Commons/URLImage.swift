//
//  URLImage.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import SwiftUI

struct URLImage: View {
    
    let url: String
    let placeholder: String
    
    @ObservedObject var imageLoader = ImageLoader()
    
    init(url: String, placeholder: String = "placeholder") {
        self.url = url
        self.placeholder = placeholder
        self.imageLoader.loadImage(url: self.url)
    }
    
    var body: some View {
        if let img = self.imageLoader.downloadedData {
            return Image(uiImage: img)
                .resizable()
                .clipped()
        } else {
            return Image(placeholder)
                .resizable()
                .clipped()
        }
    }
}

#if DEBUG
struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: "https://fyrafix.files.wordpress.com/2011/08/url-8.jpg")
    }
}
#endif
