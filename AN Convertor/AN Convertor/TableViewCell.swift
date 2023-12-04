//
//  TableViewCell.swift
//  AN Convertor
//
//  Created by Maheshwar Punyam Anand on 12/4/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var imageIV: UIImageView!
    
    
    @IBOutlet weak var textLBL: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
