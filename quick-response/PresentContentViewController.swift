//
//  PresentContentViewController.swift
//  quick-response
//
//  Created by Ivan Hjelmeland on 15/08/2022.
//

import UIKit

class PresentContentViewController: UIViewController {

    private let qrCodeString: String
    
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
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
        let url = URL(string: qrCodeString)
        let animal = url?.valueOf("animal") ?? "Lion"
        let text = url?.valueOf("message") ?? "No message"
        
        animalImageView.image = UIImage(named: animal.lowercased())
        messageLabel.text = text.replacingOccurrences(of: "_", with: " ")
    }

}
