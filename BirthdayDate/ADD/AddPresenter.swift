import UIKit

// MARK: - PROTOCOL:

protocol AddPresenter {
    func saveUser(name: String, surname: String, date: String, completion: ((UIAlertController) -> Void)?)
    var showAlert: ((UIAlertController) -> Void)? { get set }
}

// MARK: - CLASS:

final class DefaultAddPresenter: AddPresenter {
    var showAlert: ((UIAlertController) -> Void)?
    
    
    unowned let view: AddView
    private let navigationController: UINavigationController
    
    init(view: AddView, navigationController: UINavigationController) {
        self.view = view
        self.navigationController = navigationController
    }
    
    func saveUser(name: String, surname: String, date: String, completion: ((UIAlertController) -> Void)?) {
        let alertController: UIAlertController
        guard name != "", surname != "", date != ""
        else {
            alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Nil data", comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            }))
            completion?(alertController)
            return
        }
        
        
        let result = CoreDataManager.instance.saveUser(name: name, surname: surname, date: date)


        switch result {
        case .success:
            alertController = UIAlertController(title: NSLocalizedString("Success", comment: ""), message: NSLocalizedString("Success message", comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.navigationController.popViewController(animated: true)
            }))
            completion?(alertController)
        case .failure(let failure):
            print(failure)
            alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Error message", comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            }))
            completion?(alertController)
        }
    }
}
