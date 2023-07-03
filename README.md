# AMSlider

## Slider like in Apple Music from iOS 16+

## Requirements

* An iPhone/iPad running iOS 16.0+

---

## Installation

### Swift Package Manager

Using XCode UI: Project Settings -> Swift Packages and add AMSlider from there

## Usage

Simple example using NSLayoutConstraint:

```swift
lazy var constraints: [NSLayoutConstraint] = {
    return [
        self.amSlider.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        self.amSlider.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20),
        self.amSlider.heightAnchor.constraint(equalToConstant: 10),
        self.amSlider.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
    ]
}()

lazy var amSlider: AMSlider = {
    let slider = AMSlider(
        cornerRadius: 5,
        width: UIScreen.main.bounds.width - 20
    )
}()

override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(amSlider)
    self.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(constraints)

    amSlider.setTintColor(tintColor: UIColor.systemPurple)
    amSlider.beginTapClosure = {
        self.constraints[1].isActive = false
        self.constraints[2].isActive = false
        
        self.constraints[1] = self.amSlider.widthAnchor.constraint(equalToConstant: self.amSlider.frame.width + 10)
        self.constraints[2] = self.amSlider.heightAnchor.constraint(equalToConstant: self.amSlider.frame.height + 10)
        
        self.constraints[1].isActive = true
        self.constraints[2].isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }

    amSlider.endTapClosure = {
        self.constraints[1].isActive = false
        self.constraints[2].isActive = false
        
        self.constraints[1] = self.amSlider.widthAnchor.constraint(equalToConstant: self.amSlider.frame.width - 10)
        self.constraints[2] = self.amSlider.heightAnchor.constraint(equalToConstant: self.amSlider.frame.height - 10)
        
        self.constraints[1].isActive = true
        self.constraints[2].isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
}
```