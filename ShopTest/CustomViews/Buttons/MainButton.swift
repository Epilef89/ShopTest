//
//  MainButton.swift
//  ShopTest
//
//  Created by david cortes on 18/01/21.
//

import UIKit


class MainButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure() {
        setTitleColor(UIColor.blueMainColor, for: .normal)
        titleLabel?.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont.getFont(.bold, size: 20))
        backgroundColor = UIColor.yellowMainColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = 8
    }

}
