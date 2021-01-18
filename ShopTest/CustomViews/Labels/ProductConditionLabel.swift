//
//  ProductConditionLabel.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import UIKit

class ProductConditionLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

private extension ProductConditionLabel {
    func configure() {
        textColor = UIColor.white
        backgroundColor = UIColor.blueMainColor
        layer.masksToBounds = true
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.getFont(.regular, size: 14))
        numberOfLines = 0
    }
}

