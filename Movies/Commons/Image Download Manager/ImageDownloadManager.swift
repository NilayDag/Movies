//
//  ImageDownloadManager.swift
//  Movies
//
//  Created by Eda Nilay DAĞDEMİR on 16.12.2020.
//  Copyright © 2020 Eda Nilay DAĞDEMİR. All rights reserved.
//

import Foundation
import SDWebImage

class ImageDownloadManager: NSObject {
    static let shared = ImageDownloadManager()
    
    private override init() { }

    func downloadImageForImageView(url: String?, imageView: UIImageView) {
        guard let downloadURL = url, downloadURL.isValidURL() else {
            print("IDM Error: Given URL String is either nil, unusable or not a valid url.")
            return
        }
        setImage(url: URL(string: downloadURL),
                      imageView: imageView,
                      placeHolder: nil,
                      options: .progressiveLoad)
    }

    private func setImage(url: URL?, imageView: UIImageView, placeHolder: UIImage?, options: SDWebImageOptions) {
        /*
         Downloads the image at the given URL if not present in cache or return the cached version otherwise.

         - parameters:
         - url: The URL to the image
         - options: A mask to specify options to use for this request
         - progressBlock: A block called while image is downloading
         - completedBlock: A block called when operation has been completed.
         */
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: url!,
                              placeholderImage: placeHolder,
                              options: options) { (downloadedImage, _, _, _) in
            if downloadedImage != nil {
                imageView.image = downloadedImage
            }
        }
    }
}
