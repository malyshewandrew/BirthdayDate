import UIKit

final class AddView: UIViewController {
    // MARK: - PRIPERTIES:

    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let dateDatePicker = UIDatePicker()
    private var datePickerTextField = UITextField()
    private var saveButton = UIButton()
    
    // MARK: - LYFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(nameTextField, surnameTextField, dateDatePicker, datePickerTextField, saveButton)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        // MARK: NAME:

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // MARK: SURNAME

        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        surnameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // MARK: DATE PICKER:
        
        dateDatePicker.translatesAutoresizingMaskIntoConstraints = false
        dateDatePicker.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 20).isActive = true
        dateDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dateDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        dateDatePicker.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        // MARK: SAVE BUTTON:
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: dateDatePicker.bottomAnchor, constant: 20).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalTo: surnameTextField.widthAnchor, multiplier: 0.3).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: TITLE:

        title = NSLocalizedString("New User", comment: "")
        
        // MARK: NAME TEXT FIELD:

        nameTextField.backgroundColor = .colorBackgroundCell
        nameTextField.layer.cornerRadius = 15
        nameTextField.textAlignment = .center
        nameTextField.placeholder = NSLocalizedString("Name", comment: "")
        
        // MARK: SURNAME TEXT FIELD:

        surnameTextField.backgroundColor = .colorBackgroundCell
        surnameTextField.layer.cornerRadius = 15
        surnameTextField.textAlignment = .center
        surnameTextField.placeholder = NSLocalizedString("Surname", comment: "")
        
        // MARK: DATE PICKER:
        
        datePickerTextField.inputView = dateDatePicker
        dateDatePicker.datePickerMode = .date
        dateDatePicker.maximumDate = Date()
        dateDatePicker.preferredDatePickerStyle = .wheels
        
        // MARK: SAVE BUTTON:
        
        saveButton.backgroundColor = .systemGreen
        saveButton.layer.cornerRadius = 15
        saveButton.layer.masksToBounds = true
        saveButton.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
    }
    
    // MARK: - HELPERS:
}
