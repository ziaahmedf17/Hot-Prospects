//
//  ImageSaver.swift
//  Hot Prospects
//
//  Created by Zi on 24/08/2025.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (()-> Void)?
    var errorHandler: ((Error)-> Void)?
    
    func writeToPhotoAlbum(image: UIImage){
        UIImagerWriteToSavedPhtotAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @obj func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error{
            errorHandler?(error)
        }
        else{
            successHandler?()
        }
    }
}
