import UIKit

// MARK: - PROTOCOL:

protocol AddPresenter {
    func saveUser(name: String, surname: String, date: String)
}

// MARK: - CLASS:

final class DefaultAddPresenter: AddPresenter {
    
    unowned let view: AddView
    private let navigationController: UINavigationController
    
    init(view: AddView, navigationController: UINavigationController) {
        self.view = view
        self.navigationController = navigationController
    }
    
    func saveUser(name: String, surname: String, date: String) {
        let result = CoreDataManager.instance.saveUser(name: name, surname: surname, date: date)
        switch result {
        case .success:
            print("Saved")
            let alertSuccess = UIAlertController(title: "Done", message: "The user has been added", preferredStyle: .alert)
            alertSuccess.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            }))
        case .failure(let failure):
            print(failure)
            let alertError = UIAlertController(title: "Error", message: "An error has occurred", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { _ in
            }))
        }
    }
}
