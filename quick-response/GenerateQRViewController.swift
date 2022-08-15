//
//  GenerateQRViewController.swift
//  quick-response
//
//  Created by Ivan Hjelmeland on 15/08/2022.
//

import UIKit

class GenerateQRViewController: UIViewController {

    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    private let qrCodeString: String
    
    // Requires > iOS 13, if instansiating storyboard
    init?(string: String, coder: NSCoder) {
        self.qrCodeString = string
        super.init(coder: coder)
    }
    
    // Will actually never run, but we need it still.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Generated QR-code"
        let image = generateQRCode(from: qrCodeString)
        qrCodeImageView.image = image
    }
    
    private func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }

}
