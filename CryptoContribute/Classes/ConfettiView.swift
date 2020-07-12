
 import UIKit
 import QuartzCore

 public enum ConfettiType {
    case confetti
    case triangle
    case star
    case diamond
    case image(UIImage)
 }

 struct ConfettiCardProperties {
    let colorsNodes: Bool
    let colors: [UIColor]
    let type: ConfettiType

    static let `default` = ConfettiCardProperties(colorsNodes: true, colors: ConfettiCardProperties.defaultColors, type: .confetti)

    static let defaultColors: [UIColor] = [
        UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
        UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
        UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
        UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
        UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
 }

 public class ConfettiView: UIView {
    var properties: ConfettiCardProperties
    var emitter: CAEmitterLayer!
    public var colors: [UIColor]!
    public var intensity: Float!
    public var type: ConfettiType = .confetti
    private var active :Bool!

    init(properties: ConfettiCardProperties = .default) {
        self.properties = properties
        super.init(frame: .zero)
        setup()
    }
