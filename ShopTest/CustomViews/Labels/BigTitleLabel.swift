//
//  BigTitleLabel.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.
//

import UIKit

class BigTitleLabel: UILabel {
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

private extension BigTitleLabel {
    func configure() {
        textColor = UIColor.blueMainColor
        font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont.getFont(.bold, size: 50))

    }
}
