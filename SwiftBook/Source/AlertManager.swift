//
//  AlertManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 22.05.2023.
//

import Foundation

import UIKit

enum StatusAlert {
    
    case success
    case failed
    case nothing
    
}

extension StatusAlert {
    
    var title: String {
        switch self {
        case .success: return "Success"
        case .failed: return "Failed"
        case .nothing: return "No data to get, wrong format or requestion is too big"
        }
    }
    
    var message: String {
        switch self {
        case .success: return "You can see the results in the Debug aria"
        case .failed: return "You can see the error in the Debug aria"
        case .nothing: return "Plese, enter correct name"
        }
    }
    
}

final class AlertManager {
    static let shared = AlertManager()
    
    private init() {}
    
    func showAlert(from linkObject: UIViewController?, status: StatusAlert) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: status.title,
                message: status.message,
                preferredStyle: .alert
            )
    
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            linkObject?.present(alert, animated: true)
        }
    }

}
