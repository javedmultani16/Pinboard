//
//  LoadMoreCell.swift
//  PinboardPins
//
//  Created by javedmultani16 on 18/05/19.
//  Copyright © 2019 javedmultani16. All rights reserved.
//

import UIKit

class LoadMoreCell: UICollectionViewCell {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadButton.layer.cornerRadius = self.loadButton.bounds.height / 2
        self.loadButton.backgroundColor = APP_THEME_COLOR
    }
    
}
