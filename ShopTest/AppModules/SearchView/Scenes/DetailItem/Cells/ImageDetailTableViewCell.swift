//
//  ImageDetailTableViewCell.swift
//  ShopTest
//
//  Created by david cortes on 19/01/21.
//

import UIKit

class ImageDetailTableViewCell: UITableViewCell {

    //MARK: identifier
    static let identifier:String = "ImageDetailTableViewCell"
    
    //MARK: IBOutlets
    @IBOutlet weak var conditionProductLabel: ProductConditionLabel!
    @IBOutlet weak var ShippingProductLabel: FreeShippingLabel!
    @IBOutlet weak var avaliableProductLabel: QuantityProductLabel!
    @IBOutlet weak var soldProductLabel: QuantityProductLabel!
    @IBOutlet weak var imageProduct: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setWith(result:ResultSearch){
        self.conditionProductLabel.text = result.conditionDisplay
        self.ShippingProductLabel.isHidden = !(result.shipping?.freeShipping ?? false)
        self.ShippingProductLabel.text = result.typeShipping
        self.avaliableProductLabel.text = result.availableProductsDisplay
        self.soldProductLabel.text = result.soldQuantityProductDisplay
        let loaderImage = UIImage(named: "productDefaultImage")
        guard let url = URL(string: result.thumbnail ?? "") else{
            self.imageProduct.image = loaderImage
            return}
        self.imageProduct.sd_setImage(with: url, placeholderImage:loaderImage)
    }
    
}
