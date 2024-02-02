import UIKit

protocol MainView: AnyObject {
//    func updateCounterLabel(text: String)
}

// MARK: - MAIN VIEW:

final class DefaultMainView: UIViewController {
    // MARK: - PROPERTIES:

    private let tableView = UITableView()
    
    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        configureTableView()
    }
    
    // MARK: - ADD SUBVIES:

    private func addSubviews() {
        view.addSubviews(tableView)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:
        view.backgroundColor = .blue
        
        // MARK: TABLE VIEW:
        tableView.backgroundColor = .blue
        
    }
    
    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainViewCell.self, forCellReuseIdentifier: "MainViewCell")
        tableView.separatorStyle = .none
    }
}

// MARK: - EXTENSIONS:
extension DefaultMainView: MainView {
//    func updateCounterLabel(text: String) {
//
//    }
}

// MARK: TABLE VIEW:
extension DefaultMainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCell", for: indexPath) as? MainViewCell else { return UITableViewCell() }
        return cell
    }
    
    
}
