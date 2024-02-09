import CoreData
import UIKit

// MARK: - PROTOCOL:

protocol AddPresenter {
    func saveUser(name: String, surname: String, date: String, completion: ((UIAlertController) -> Void)?)
    var showAlert: ((UIAlertController) -> Void)? { get set }
    func showInfo(completion: ((UIAlertController) -> Void)?)
}

// MARK: - CLASS:

final class DefaultAddPresenter: AddPresenter {
    func showInfo(completion: ((UIAlertController) -> Void)?) {
        let alertController: UIAlertController
        alertController = UIAlertController(title: NSLocalizedString("Notification", comment: ""), message: NSLocalizedString("Notification message", comment: ""), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
        }))
        completion?(alertController)
    }
    
    
    // MARK: PROPERTIES:
    var showAlert: ((UIAlertController) -> Void)?
    private unowned let view: AddView
    private let navigationController: UINavigationController
    
    init(view: AddView, navigationController: UINavigationController) {
        self.view = view
        self.navigationController = navigationController
    }
    
    // MARK: SAVE USER:
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
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            do {
                let count = try context.count(for: fetchRequest)
                NotificationManager.instance.setNotification(message: "Message", id: count, user: (name, surname, date))
            } catch let error as NSError {
                print("Не удалось получить количество объектов: \(error), \(error.userInfo)")
            }
        case .failure(let failure):
            print(failure)
            alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Error message", comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            }))
            completion?(alertController)
        }
    }
}
