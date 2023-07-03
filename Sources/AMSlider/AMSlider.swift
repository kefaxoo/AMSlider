//
//  AMSlider.swift
//
//
//  Created by Bahdan Piatrouski on 3.07.23.
//

import UIKit

open class CustomAMSlider: UIView {
    private var cornerRadius        : CGFloat = 0
    private var minValue            : Double = 0
    private var maxValue            : Double = 1
    private var width               : Double = UIScreen.main.bounds.width
    private var durationConstraints = [NSLayoutConstraint]()
    private var value               : Double = 0
    private var beginX              : Double = 0
    private var touchType           : TouchType = .none
    
    open var beginTapClosure: (() -> ())?
    open var endTapClosure  : (() -> ())?
    
    fileprivate lazy var durationAMSlider: DurationAMSlider = {
        let durationAMSlider = DurationAMSlider(cornerRadius: self.cornerRadius)
        durationAMSlider.backgroundColor = UIColor.systemBlue
        return durationAMSlider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public init(cornerRadius: CGFloat = 0, minValue: Double = 0, maxValue: Double = 1, width: Double = UIScreen.main.bounds.width, beginTapClosure: (() -> ())? = nil, endTapClosure: (() -> ())? = nil) {
        super.init(frame: .zero)
        self.cornerRadius    = cornerRadius
        self.minValue        = minValue
        self.maxValue        = maxValue
        self.width           = width
        self.beginTapClosure = beginTapClosure
        self.endTapClosure   = endTapClosure
        commonInit()
    }
    
    private func commonInit() {
        self.layer.cornerRadius = self.cornerRadius
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.addSubview(durationAMSlider)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupConstraints() {
        durationConstraints = [
            durationAMSlider.topAnchor.constraint(equalTo: self.topAnchor),
            durationAMSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            durationAMSlider.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            durationAMSlider.widthAnchor.constraint(equalToConstant: value)
        ]
        
        NSLayoutConstraint.activate(durationConstraints)
        self.layoutIfNeeded()
    }
    
    open func setValue(value: Double) {
        durationConstraints[3].isActive = false
        
        self.value = value
        durationConstraints[3] = durationAMSlider.widthAnchor.constraint(equalToConstant: self.value * self.width)
        durationConstraints[3].isActive = true
        
        self.layoutIfNeeded()
    }
    
    private func setTempValue(value: Double) {
        durationConstraints[3].isActive = false
        durationConstraints[3] = durationAMSlider.widthAnchor.constraint(equalToConstant: value * self.width)
        durationConstraints[3].isActive = true
        self.layoutIfNeeded()
    }
    
    open func setTintColor(tintColor: UIColor) {
        durationAMSlider.backgroundColor = tintColor
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let x = (touch.location(in: self).x) / width
            self.beginX = x
            self.touchType = .begin
            self.beginTapClosure?()
        }
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let x = (touch.location(in: self).x) / width
            let newDuration = (x - beginX) + self.value
            if newDuration <= self.width, newDuration >= 0 {
                setTempValue(value: newDuration)
            }
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let x = (touch.location(in: self).x) / width
            let newDuration = (x - beginX) + self.value
            if newDuration <= self.width, newDuration >= 0 {
                setValue(value: newDuration)
            }
            
            self.touchType = .ended
            self.endTapClosure?()
        }
    }
    
    open func getValue() -> Double {
        return self.value
    }
}
