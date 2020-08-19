import UIKit
import Anchorage

final class DonateView: UIView {
    weak var dispatcher: DonateActionDispatching?
    let btc = UIButton()
    let eth = UIButton()
    let ltc = UIButton()
    let stack = UIStackView()

    override in