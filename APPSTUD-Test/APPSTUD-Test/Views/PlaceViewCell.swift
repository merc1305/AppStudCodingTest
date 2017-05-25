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

class PlaceViewCell: UITableViewCell {
    @IBOutlet weak var barTitleLabel: UILabel!
    @IBOutlet weak var barImageView: UIImageView!
    
    override func awakeFromNib() {
        //Setup initial load from nib name
        barImageView.contentMode = .scaleAspectFill
    }
    
    func setBarItem(bar: Place) {
        if let url = URL(string: "") {
            barImageView.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.global(qos: .default), imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: { [weak self] (response) in
                if let sf = self {
                    if let im = response.result.value {
                        
                    }
                }
            })
        }
    }
    
}
