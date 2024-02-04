import UIKit

// MARK: - PROTOCOL:

protocol MainPresenter {
    func addUserTapped()
    func loadUsers()
}

// MARK: - CLASS:

final class DefaultMainPresenter: MainPresenter {
    // MARK: PROPERTIES:

    private unowned let view: DefaultMainView
    private let navigationController: UINavigationController

    init(view: DefaultMainView, navigationController: UINavigationController) {
        self.view = view
        self.navigationController = navigationController
    }

    // MARK: ADD USER:
    func addUserTapped() {
        let view = AddView()
        let presenter = DefaultAddPresenter(view: view, navigationController: navigationController)
        view.presenter = presenter
        navigationController.pushViewController(view, animated: true)
    }
    
    // MARK: LOAD USERS:
    func loadUsers() {
        let operationResult = CoreDataManager.instance.getUsers()
        switch operationResult {
        case .success(let users):
            view.updateData(user: users)
        case .failure(let failure):
            print(failure)
        }
    }
}
