//
//  TitleDetailLabel.swift
//  ShopTest
//
//  Created by david cortes on 19/01/21.
//

import UIKit

class TitleDetailLabel: UILabel {
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

private extension TitleDetailLabel {
    func configure() {
        textColor = UIColor.black
        font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont.getFont(.bold, size: 20))
        numberOfLines = 0
        textAlignment = .left
    }
}
