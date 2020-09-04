import UIKit
import Anchorage

final class DonateView: UIView {
    weak var dispatcher: DonateActionDispatching?
    let btc = UIButton()
    let eth = UIButton()
    let ltc = UIButton()
    let stack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        btc.setImage(UIImage(podAssetName: "btc"), for: .normal)
        btc.contentMode = .scaleAspectFit

        btc.addAction { [weak self] in
            self?.dispatcher?.dispatch(.presentDonationOptions(.btc))
        }

        eth.setImage(UIImage(podAssetName: "eth"), for: .normal)
        eth.contentMode = .scaleAspectFit

        eth.addAction { [weak self] in
            self?.dispatcher?.dispatch(.presentDonationOptions(.eth))
        }

        ltc.setImage(UIImage(podAssetName: "litecoin"), for: .normal)
        ltc.contentMode = .scaleAspectFit

        ltc.addAction { [weak self] in
            self?.dispatcher?.dispatch(.presentDonationOptions(.ltc))
        }

        