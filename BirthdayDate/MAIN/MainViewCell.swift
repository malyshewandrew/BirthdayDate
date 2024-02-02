import UIKit

// MARK: - CLASS:
class MainViewCell: UITableViewCell {
    
    // MARK: LIFECYCLE:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstraints()
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ADD SUBVIES:

    private func addSubviews() {

    }
    
    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {

    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: CONTENT VIEW:
        
        contentView.backgroundColor = .red
    }
    
}
