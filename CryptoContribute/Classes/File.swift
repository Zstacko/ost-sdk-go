extension UIImage {
    convenience init?(podAssetName: String) {
        let podBundle = Bundle(for: ConfettiView.self)
        
        /// A given class within your Pod framework
        guard let url = podBundle.url(forResource: "CryptoCont