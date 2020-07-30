
protocol DonateActionDispatching: AnyObject {
    func dispatch(_ action: DonateViewController.Actions)
}

public final class DonateCoordinator {
    private let qrDisplayViewController = QRDispalyViewController()
    public let donationController = DonateViewController()

    public init() {
        donationController.dispatcher = self
    }
}

extension DonateCoordinator: DonateActionDispatching {
    func dispatch(_ action: DonateViewController.Actions) {
        switch action {
        default: return
        }
    }
}

extension DonateCoordinator {
    private func handleCurrency(_ currency: DonationCurrency) {
        let alert = makeDonateActionSheet(for: currency)
        donationController.present(alert, animated: true, completion: nil)
    }

    private func handleDonation(_ donation: DonateViewController.Actions.Donation) {
        switch donation {
        case let .copyAddress(currency):
            UIPasteboard.general.string = currency.address
            let alert = UIAlertController.confirmationAlert(
                confirmationTitle: "Copied.",
                confirmationMessage: "Wallet address \(currency.address) has been copied to your clipboard."
            )
            donationController.present(alert, animated: true, completion: nil)

        case let .qr(currency):
            qrDisplayViewController.currency = currency