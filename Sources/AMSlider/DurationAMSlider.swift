//
//  DurationAMSlider.swift
//
//
//  Created by Bahdan Piatrouski on 3.07.23.
//

import UIKit

internal class DurationAMSlider: UIView {
    private var cornerRadius: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.cornerRadius = cornerRadius
        commonInit()
    }
    
    private func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = self.cornerRadius
    }
}
