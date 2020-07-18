
protocol DonateActionDispatching: AnyObject {
    func dispatch(_ action: DonateViewController.Actions)
}

public final class DonateCoordinator {
    private le