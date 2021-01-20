//
//  QuantityProductLabel.swift
//  ShopTest
//
//  Created by david cortes on 19/01/21.
//

import UIKit

class QuantityProductLabel: UILabel {
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

private extension QuantityProductLabel {
    func configure() {
        textColor = UIColor.grayDark
        font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont.getFont(.bold, size: 14))
        numberOfLines = 0
        textAlignment = .left
    }
}
