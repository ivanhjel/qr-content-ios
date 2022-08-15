//
//  ViewController.swift
//  quick-response
//
//  Created by Ivan Hjelmeland on 15/08/2022.
//

import UIKit
import SwiftQRCodeScanner

class ViewController: UIViewController {
    
    let animals = ["Lion", "Giraffe", "Elephant", "Bear", "Hippo", "Monkey"]
    
    @IBAction func generateQRButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Generate QR-code", message: "What do you want your QR-code to say?", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Your message"
            textField.keyboardType = UIKeyboardType.default
        })
        alert.addAction(UIAlertAction(title: "Generate QR-code", style: .default, handler: { action in
            let animalAlert = UIAlertController(title: "What animal!?", message: "What animal do you want to present your message?", preferredStyle: .actionSheet)
            self.animals.forEach {
                animalAlert.addAction(UIAlertAction(title: $0, style: .default, handler: { action in
                    let message = alert.textFields?.first?.text ?? "No message"
                    self.show(self.makeQRGeneratorView(string: "www.quickresponseprototype.no/content?animal=\(action.title!)&message=\(message.replacingOccurrences(of: " ", with: "_"))"), sender: self)
                }))
            }
            self.present(animalAlert, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @IBAction func scanQRButtonPressed(_ sender: Any) {
        present(makeQRScannerView(), animated: true)
    }
    
    private func makeQRGeneratorView(string: String) -> GenerateQRViewController {
        let generateQR = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "GenerateQRViewController") { coder in
            GenerateQRViewController(string: string, coder: coder)!
        }
        return generateQR
    }
    
    private func makeQRScannerView() -> QRCodeScannerController {
        let scanner = QRCodeScannerController()
        scanner.delegate = self
        return scanner
    }
    
    private func makePresentContentView(_ content: String) -> PresentContentViewController {
        let presenctContent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PresentContentViewController") { coder in
            PresentContentViewController(string: content, coder: coder)!
        }
        return presenctContent
    }

}

extension ViewController: QRScannerCodeDelegate {
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        controller.dismiss(animated: true)
        present(makePresentContentView(result), animated: true)
    }
    
    func qrScannerDidFail(_ controller: UIViewController, error: QRCodeError) { }
    func qrScannerDidCancel(_ controller: UIViewController) { }
}

