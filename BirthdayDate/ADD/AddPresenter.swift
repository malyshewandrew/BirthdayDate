import UIKit

// MARK: - PROTOCOL:

protocol AddPresenter {
    func saveUser()
}

// MARK: - CLASS:

final class DefaultAddPresenter: AddPresenter {
    
    unowned let view: AddView
    
    init(view: AddView) {
        self.view = view
    }
    
    func saveUser() {
        print("test")
    }
}



/*
 let view = AddView()
 let presenter = DefaultAddPresenter(view: view)
 view.presenter = presenter
 */
