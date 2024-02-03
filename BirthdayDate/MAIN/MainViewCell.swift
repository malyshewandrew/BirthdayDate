import UIKit

// MARK: - CLASS:

class MainViewCell: UITableViewCell {
    // MARK: PROPERTIES:

    private let containerView = UIView()
    private let nameLabel = UILabel()
    private let surnameLabel = UILabel()
    private let dateLabel = UILabel()
    
    // MARK: LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstraints()
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ADD SUBVIES:

    private func addSubviews() {
        contentView.addSubviews(containerView)
        containerView.addSubviews(nameLabel, surnameLabel, dateLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        
        // MARK: CONTAINER VIEW:
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        // MARK: NAME LABEL:
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.bottomAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        
        // MARK: SURNAME LABEL:
        surnameLabel.translatesAutoresizingMaskIntoConstraints = false
        surnameLabel.topAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 5).isActive = true
        surnameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        
        // MARK: DATE LABEL:
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: CONTENT VIEW:
        
        contentView.backgroundColor = .colorBackground
        
        // MARK: CONTAINER VIEW:

        containerView.backgroundColor = .colorBackgroundCell
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = true
        
        // MARK: NAME LABEL:
        
        nameLabel.textColor = .colorText
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold, width: .standard)
        
        // MARK: SURNAME LABEL:
        surnameLabel.textColor = .colorText
        surnameLabel.font = .systemFont(ofSize: 16, weight: .bold, width: .standard)
        
        // MARK: DATE LABEL:
        dateLabel.textColor = .colorText
        dateLabel.font = .systemFont(ofSize: 16, weight: .bold, width: .standard)
    }
    
    // MARK: HELPERS:
    func configureEntity(user: User) {
        nameLabel.text = user.name
        surnameLabel.text = user.surname
        dateLabel.text = user.date
    }
}
