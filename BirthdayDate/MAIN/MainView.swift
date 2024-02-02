import UIKit

// MARK: - PROTOCOL:

protocol MainView: AnyObject {
//    func updateCounterLabel(text: String)
}

// MARK: - MAIN VIEW:

final class DefaultMainView: UIViewController {
    // MARK: - PROPERTIES:

    var presenter: MainPresenter!
    private let tableView = UITableView()

    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }

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

        view.backgroundColor = .colorBackground

        // MARK: TITLE:

        title = NSLocalizedString("Birthday", comment: "")

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { [weak self] _ in
            self?.addUserTapped()
        }))
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .trash)

        // MARK: TABLE VIEW:

        tableView.backgroundColor = .colorBackground
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainViewCell.self, forCellReuseIdentifier: "MainViewCell")
        tableView.separatorStyle = .none
    }

    // MARK: - HELPERS

    @objc private func addUserTapped() {
        let addView = AddView()
        navigationController?.pushViewController(addView, animated: true)
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
    // MARK: - COUNTS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    // MARK: - CUSTOM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCell", for: indexPath) as? MainViewCell else { return UITableViewCell() }
        return cell
    }

    // MARK: - DELETE USER:

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        if editingStyle == .delete {
            let alertDelete = UIAlertController(title: NSLocalizedString("Delete", comment: ""), message: NSLocalizedString("Delete user", comment: ""), preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Delete ok", comment: ""), style: .destructive, handler: { _ in
                _ = CoreDataManager.instance.deleteUser(user)
//                self.viewModel.loadMovies()
            }))
            present(alertDelete, animated: true)
        }
    }

    
}
