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
    
    override func awakeFromNib() {
        //Setup initial load from nib name
        barImageView.contentMode = .scaleAspectFill
        let blurView =  getBlurryViewWithFrame(viewBgTitle.bounds, border: true)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        viewBgTitle.insertSubview(blurView, at: 0);
//        viewBgTitle.addConstraints(constraisBlur)
    }
    
    func setBarItem(bar: Place) {
//        if let urlString = bar.photoURL?.replacingOccurrences(of: ":", with: "=") {
//            let newString = urlString.replacingOccurrences(of: "//=", with: "//:")
        if let urlString = bar.photoURL {
            if let url = URL(string: urlString) {
                barImageView.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.global(qos: .default), imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: { [weak self] (response) in
                    if let sf = self {
                        if let im = response.result.value {
                            sf.barImageView.image = im
                        }
                        print("response: \(response)")
                        print("result: \(response.error?.localizedDescription)")
                    }
                })
            }
            
        }
        barTitleLabel.text = bar.name ?? ""
    }
}
