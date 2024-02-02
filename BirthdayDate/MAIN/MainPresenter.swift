import UIKit

// MARK: - PROTOCOL:

protocol MainPresenter {
    func addUserTapped()
    func loadUsers()
}

// MARK: - CLASS:

final class DefaultMainPresenter: MainPresenter {
    // MARK: PROPERTIES:

    unowned let view: MainView
    private let navigationController: UINavigationController

    init(view: MainView, navigationController: UINavigationController) {
        self.view = view
        self.navigationController = navigationController
    }

    func addUserTapped() {
        let view = AddView()
        let presenter = DefaultAddPresenter(view: view, navigationController: navigationController)
        view.presenter = presenter
        navigationController.pushViewController(view, animated: true)
    }
    
    func loadUsers() {
        let operationResult = CoreDataManager.instance.getUsers()
        switch operationResult {
        case .success(let users):
            print("test")
        case .failure(let failure):
            print(failure)
        }
    }
    
}
