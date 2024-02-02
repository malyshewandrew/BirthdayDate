import UIKit

// MARK: - PROTOCOL:
protocol MainPresenter {

}

// MARK: - CLASS:
final class DefaultMainPresenter: MainPresenter {
    
    unowned let view: MainView
    
    init(view: MainView) {
        self.view = view
    }
    
    
}
