//
//  ASAnnotationView.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation
import MapKit

class ASAnnotationView: MKAnnotationView {

    var alreadyLoad = false

    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !alreadyLoad {
            alreadyLoad = true
            let round: CGFloat = 60
            let rect = CGRect(x: 0, y: 0, width: round, height:  round)
            frame = rect
            let imageView = UIImageView(frame: rect)
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.fullyRound(60, borderColor: UIColor.black, borderWidth: 1)
            image = nil
            addSubview(imageView)
            let replaceImage = UIImage(named: "No_Image_Available")
            if let ano = annotation as? ASAnnotation {
                if let urlString = ano.imageUrl {
                    if let url = URL(string: urlString) {
                        imageView.af_setImage(withURL: url, placeholderImage: replaceImage, filter: nil, progress: nil, progressQueue: DispatchQueue.global(qos: .default), imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: { [weak self] (response) in
                            if let im = response.result.value {
                                Utils.runOnMainThread {
                                    imageView.image = im
                                    imageView.fullyRound(60, borderColor: UIColor.black, borderWidth: 1)
                                    self?.image = nil
                                }
                            }
                        })
                    } else {
                        imageView.image = replaceImage
                    }
                } else {
                    imageView.image = replaceImage
                }
            }
        }
        backgroundColor = UIColor.clear
    }
    
}
