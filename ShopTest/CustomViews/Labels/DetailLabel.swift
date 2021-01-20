//
//  DetailLabel.swift
//  ShopTest
//
//  Created by david cortes on 19/01/21.
//

import UIKit

class DetailLabel: UILabel {
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

private extension DetailLabel {
    func configure() {
        textColor = UIColor.blueMainColor
        font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont.getFont(.light, size: 16))
        numberOfLines = 0
        textAlignment = .left
    }
}
