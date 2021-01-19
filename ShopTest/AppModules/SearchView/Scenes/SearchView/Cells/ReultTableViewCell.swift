//
//  ReultTableViewCell.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import UIKit
import SDWebImage


class ReultTableViewCell: UITableViewCell {
    
    //MARK: Variables or Constant
    static let identifier:String = "ReultTableViewCell"
    
    //MARK: IBOutlets
    @IBOutlet weak var productImageView: SDAnimatedImageView!
    @IBOutlet weak var nameProductLabel: NameProductLabel!
    @IBOutlet weak var productCostLabel: AmountLabel!
    @IBOutlet weak var productConditionLabel: ProductConditionLabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setWith(result:ResultSearch){
        self.nameProductLabel.text = result.title
        self.productCostLabel.text = result.priceDisplaypriceDisplay
        self.productConditionLabel.text = result.conditionDisplay
        let loaderImage = UIImage(named: "productDefaultImage")
        guard let url = URL(string: result.thumbnail ?? "") else{
            self.productImageView.image = loaderImage
            return}
        self.productImageView.sd_setImage(with: url, placeholderImage:loaderImage)
        self.productConditionLabel.layer.cornerRadius = 2
    }
    
    
}
