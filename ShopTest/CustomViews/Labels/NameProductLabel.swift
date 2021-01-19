//
//  NameProductLabel.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import UIKit

class NameProductLabel: UILabel {
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

private extension NameProductLabel {
    func configure() {
        textColor = UIColor.black
        font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont.getFont(.regular, size: 14))
        numberOfLines = 0

    }
}
