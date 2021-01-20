//
//  DetailTableViewCell.swift
//  ShopTest
//
//  Created by david cortes on 19/01/21.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    //MARK: Identifier
    static let identifier:String = "DetailTableViewCell"
    
    //MARK: IBOutlets
    @IBOutlet weak var descriptionTitleLabel: TitleDetailLabel!
    @IBOutlet weak var detailDescriptionTitle: DetailLabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setWith(detail:DetailDescription){
        self.descriptionTitleLabel.text = detail.title
        self.detailDescriptionTitle.text = detail.detail
    }
    
}


