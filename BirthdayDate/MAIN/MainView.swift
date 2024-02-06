import UIKit
import WebKit
import SafariServices

// MARK: - PROTOCOL:

protocol MainView: AnyObject {
    func updateData(_ user: [User])
}

// MARK: - MAIN VIEW:

final class DefaultMainView: UIViewController {
    // MARK: - PROPERTIES:

    var presenter: MainPresenter?
    private let tableView = UITableView()
    private let termsButton = UIButton()
    private let webButton = UIButton()
    private let privacyButton = UIButton()

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadUsers()
    }

    // MARK: - ADD SUBVIES:

    private func addSubviews() {
        view.addSubviews(tableView, termsButton, webButton, privacyButton)
    }

    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true

        // MARK: TERMS OF USE:

        termsButton.translatesAutoresizingMaskIntoConstraints = false
        termsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        termsButton.trailingAnchor.constraint(equalTo: webButton.leadingAnchor, constant: -10).isActive = true
        termsButton.heightAnchor.constraint(equalToConstant: 15).isActive = true

        // MARK: WEB:

        webButton.translatesAutoresizingMaskIntoConstraints = false
        webButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        webButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        webButton.heightAnchor.constraint(equalToConstant: 15).isActive = true

        // MARK: PRIVACY:

        privacyButton.translatesAutoresizingMaskIntoConstraints = false
        privacyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        privacyButton.leadingAnchor.constraint(equalTo: webButton.trailingAnchor, constant: 10).isActive = true
        privacyButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
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
            self?.presenter?.addUserTapped()
        }))

        // MARK: TABLE VIEW:

        tableView.backgroundColor = .colorBackground
        
        // MARK: TERMS OF USE:

        let attributedStringTerms = NSAttributedString(string: "TERMS OF USE", attributes: [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        termsButton.setAttributedTitle(attributedStringTerms, for: .normal)
        termsButton.setTitle("TERMS OF USE", for: .normal)
        termsButton.setTitleColor(.colorText, for: .normal)
        termsButton.titleLabel?.font = .systemFont(ofSize: 8, weight: .bold, width: .standard)
        termsButton.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)

        // MARK: WEB:

        let attributedStringWeb = NSAttributedString(string: "WEB SITE", attributes: [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        webButton.setAttributedTitle(attributedStringWeb, for: .normal)
        webButton.setTitleColor(.colorText, for: .normal)
        webButton.titleLabel?.font = .systemFont(ofSize: 8, weight: .bold, width: .standard)
        webButton.addTarget(self, action: #selector(webTapped), for: .touchUpInside)

        // MARK: PRIVACY:

        let attributedStringPrivacy = NSAttributedString(string: "PRIVACY POLICY", attributes: [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        privacyButton.setAttributedTitle(attributedStringPrivacy, for: .normal)
        privacyButton.setTitleColor(.colorText, for: .normal)
        privacyButton.titleLabel?.font = .systemFont(ofSize: 8, weight: .bold, width: .standard)
        privacyButton.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
    }
    
    @objc func termsTapped() {
        guard let url = URL(string: "https://birthdaydate.tilda.ws/termsofuse") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true)
    }

    @objc func webTapped() {
        guard let url = URL(string: "https://birthdaydate.tilda.ws") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true)
    }

    @objc func privacyTapped() {
        guard let url = URL(string: "https://birthdaydate.tilda.ws/privacysecurity") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true)
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainViewCell.self, forCellReuseIdentifier: "MainViewCell")
        tableView.separatorStyle = .none
    }

    // MARK: - HELPERS:

    // MARK: UPDATE DATA:

    func updateData(user: [User]) {
        users = user
    }
}

// MARK: - EXTENSIONS:

extension DefaultMainView: UITableViewDelegate, UITableViewDataSource {
    // MARK: - COUNTS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    // MARK: - CUSTOM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCell", for: indexPath) as? MainViewCell else { return UITableViewCell() }
        let user = users[indexPath.row]
        cell.configureEntity(user: user)
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
                self.presenter?.loadUsers()
            }))
            present(alertDelete, animated: true)
        }
    }
}

// MARK: - EXTENSION. SAFARI VIEW CONTROLLER DELEGATE:

extension DefaultMainView: SFSafariViewControllerDelegate {
    func safariViewControllerWillOpenInBrowser(_ controller: SFSafariViewController) {
        print("Open in Safari app")
    }
}
