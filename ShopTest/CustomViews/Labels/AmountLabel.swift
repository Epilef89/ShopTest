//
//  AmountLabel.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import UIKit

class AmountLabel: UILabel {
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

private extension AmountLabel {
    func configure() {
        textColor = UIColor.black
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.getFont(.bold, size: 20))
        numberOfLines = 0
    }
}
