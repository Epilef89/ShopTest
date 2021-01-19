//
//  AlertTitle.swift
//  ShopTest
//
//  Created by david cortes on 18/01/21.
//

import UIKit

class AlertTitle: UILabel {
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

private extension AlertTitle {
    func configure() {
        textColor = UIColor.blueMainColor
        font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont.getFont(.bold, size: 20))
        numberOfLines = 0
    }
}
