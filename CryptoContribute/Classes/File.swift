extension UIImage {
    convenience init?(podAssetName: String) {
        let podBundle = Bundle(for: ConfettiView.self)
        
        /// A given