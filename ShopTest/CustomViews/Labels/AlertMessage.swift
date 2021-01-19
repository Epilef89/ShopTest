//
//  AlertMessage.swift
//  ShopTest
//
//  Created by david cortes on 18/01/21.
//

import UIKit

class AlertMessage: UILabel {
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

private extension AlertMessage {
    func configure() {
        textColor = UIColor.black
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.getFont(.regular, size: 16))
        numberOfLines = 0
        textAlignment = .center
    }
}
