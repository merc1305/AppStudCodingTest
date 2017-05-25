//
//  PlaceViewCell.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

class PlaceViewCell: UITableViewCell {
    @IBOutlet weak var barTitleLabel: UILabel!
    @IBOutlet weak var barImageView: UIImageView!
    @IBOutlet weak var viewBgTitle: UIView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        //Setup initial load from nib name
        barImageView.contentMode = .scaleAspectFill
        barImageView.clipsToBounds = true
        let blurView =  getBlurryViewWithFrame(viewBgTitle.bounds, border: true)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        viewBgTitle.insertSubview(blurView, at: 0);
        
        let constraisBlur: [NSLayoutConstraint] = [getTopConstraintForViewsAndInset(blurView, viewBgTitle, 0),
                                                   getLeftConstraintForViewsAndInset(blurView, viewBgTitle, 0),
                                                   getRightConstraintForViewsAndInset(blurView, viewBgTitle, 0),
                                                   getBottomConstraintForViewsAndInset(blurView, viewBgTitle, 0)]
        
        viewBgTitle.addConstraints(constraisBlur)
    }
    
    func setBarItem(bar: Place) {
        let replaceImage = UIImage(named: "No_Image_Available")
        if let urlString = bar.photoURL {
            if let url = URL(string: urlString) {
                indicator.startAnimating()
                barImageView.af_setImage(withURL: url, placeholderImage: replaceImage, filter: nil, progress: nil, progressQueue: DispatchQueue.global(qos: .default), imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: { [weak self] (response) in
                    if let sf = self {
                        if let im = response.result.value {
                            sf.barImageView.image = im
                        } else {
                            sf.barImageView.image = replaceImage
                        }
                        sf.indicator.stopAnimating()
                    }
                })
            } else {
                barImageView.image = replaceImage
            }
        } else {
            barImageView.image = replaceImage
        }
        barTitleLabel.text = bar.name ?? ""
    }
}
