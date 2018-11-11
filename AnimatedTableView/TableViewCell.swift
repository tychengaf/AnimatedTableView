//
//  TableViewCell.swift
//  MVC
//
//  Created by Mark Moeykens on 5/2/17.
//  Copyright © 2017 Moeykens. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var data1Label: UILabel!
    @IBOutlet weak var data2Label: UILabel!
    @IBOutlet weak var profileImageStackView: UIStackView!
    

    func setup(model: Model) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subTitle
        //cellImageView.image = model.image
        if model.subTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            subtitleLabel.isHidden = true
        } else {
            subtitleLabel.isHidden = false
        }
        data1Label.text = model.data1
        data2Label.text = model.data2
        var count = 1
        //programmatically adding profile picture into stack view
        if model.images.count > 0 {
           
            for image in model.images {
                if count == 7 {
                    break
                }
                let imageView = UIImageViewX(frame:CGRect(x: 0, y: 0, width: 36, height: 36))
                imageView.image = image
                imageView.layer.borderColor = UIColor.lightGray.cgColor
                imageView.layer.borderWidth = 1
                imageView.layer.cornerRadius = 18
                
                //trim the edge outside the circle
                imageView.layer.masksToBounds = true
                
                //setting constraint so that pic stay 36x36
                let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: 36)
                let heightConstaint = imageView.heightAnchor.constraint(equalToConstant: 36)
                NSLayoutConstraint.activate([widthConstraint,heightConstaint])
                
                profileImageStackView.addArrangedSubview(imageView)
                
                //avoid autoresize ruin our setup
                profileImageStackView.translatesAutoresizingMaskIntoConstraints = false;
                count+=1
            }
        }
    }
}
