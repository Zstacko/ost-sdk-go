
protocol DonateActionDispatching: AnyObject {
    func dispatch(_ action: DonateViewController.Actions)
}

public final class DonateCoordinator {
    private let qrDisplayViewController = QRDispalyViewController()
    public let donationController = DonateViewContr