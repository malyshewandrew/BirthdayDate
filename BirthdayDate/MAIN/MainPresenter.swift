import UIKit

// MARK: - PROTOCOL:

protocol MainPresenter {
    func addUserTapped()
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
        let addView = AddView()
        navigationController.pushViewController(addView, animated: true)
        
        let view = AddView()
        let presenter = DefaultAddPresenter(view: view)
        view.presenter = presenter
    }
}
