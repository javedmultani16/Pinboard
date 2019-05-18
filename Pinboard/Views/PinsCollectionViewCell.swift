//
//  PinsCollectionViewCell.swift
//  PinboardPins
//
//  Created by javedmultani16 on 17/05/19.
//  Copyright © 2019 javedmultani16. All rights reserved.
//

import UIKit
import SwiftyEasyCache

class PinsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var uploadedImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var contentBackgroundView: UIView!
    @IBOutlet weak var likeIconImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var timeInfoLabel: UILabel!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyCornerRadiusToImageView(radius: 4, imageView: uploadedImageView)
        applyCornerRadiusToImageView(radius: 4, imageView: profileImageView)
        configureView(radius: 0, backgroundColor: .white, shadowColor: UIColor.gray.withAlphaComponent(0.6).cgColor, shadowOffset: CGSize(width: 0 , height:0), opacity: 0.8, view: contentBackgroundView)
    }
    
    
    func setCellContent(_ fetchedData: PinData) {

        let uploadedImageURL      = NSURL(string:fetchedData.uploadedImageUrlString!)
        let profileImageURL         = NSURL(string:fetchedData.profileImageUrlString!)
        
        uploadedImageView.swifty_setImageWithUrl(url: uploadedImageURL!, completion: {(error) in })
        profileImageView.swifty_setImageWithUrl(url: profileImageURL!, completion: {(error) in })
//        uploadedImageView.swifty_setImageWithUrl(url: uploadedImageURL!, placeholderImage: UIImage(named: "default-placeholder")) { (err) in
//            print(err.debugDescription)
//        }
        creatorLabel.text = fetchedData.userName
        numberOfLikesLabel.text = String(fetchedData.numberOfLikes ?? 0)
        timeInfoLabel.text = serverTime.date(from:fetchedData.timeInfo ?? "")?.timeAgoDisplay()

    }
    
    
    override func prepareForReuse() {
       // uploadedImageView.image = nil
        profileImageView.image = nil
    }
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            imageViewHeightLayoutConstraint.constant = attributes.photoHeight
        }
    }

}
