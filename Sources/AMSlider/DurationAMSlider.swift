//
//  DurationAMSlider.swift
//
//
//  Created by Bahdan Piatrouski on 3.07.23.
//

import UIKit

internal class DurationAMSlider: UIView {
    private var cornerRadius: CGFloat = 0
    
    weak var delegate: DurationAMSliderDelegate?
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.touchesBegin(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.touchesMove(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.touchesEnd(touches, with: event)
    }
}

internal protocol DurationAMSliderDelegate: AnyObject {
    func touchesBegin(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesMove(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesEnd(_ touches: Set<UITouch>, with event: UIEvent?)
}
