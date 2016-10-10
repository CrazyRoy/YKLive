//
//  LiveTableViewCell.swift
//  映客直播
//
//  Created by CodeLL on 2016/10/9.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class LiveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgPor: UIImageView!
    @IBOutlet weak var labelNick: UILabel!
    @IBOutlet weak var labelAddr: UILabel!
    @IBOutlet weak var labelViewers: UILabel!
    @IBOutlet weak var imgBgPor: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
