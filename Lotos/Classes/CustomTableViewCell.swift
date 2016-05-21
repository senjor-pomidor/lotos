//
//  CustomTableViewCell.swift
//  Lotos
//
//  Created by Andrey Torlopov on 21/05/16.
//  Copyright © 2016 Andrey Torlopov. All rights reserved.
//

import UIKit


//MARK:- properties and lifecycle
class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
