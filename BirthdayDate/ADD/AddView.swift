import UIKit
import Lottie

final class AddView: UIViewController {
    // MARK: - PRIPERTIES:

    private let birthdayLottie = LottieAnimationView(name: "birthdayLottie")
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let dateDatePicker = UIDatePicker()
    private var dateTextField = UITextField()
    private var saveButton = UIButton()
    private let dateFormatter = DateFormatter()
    var presenter: AddPresenter?
    
    // MARK: - LYFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        configureGestures()
    }
    
    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(birthdayLottie, nameTextField, surnameTextField, dateDatePicker, dateTextField, saveButton)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        
        // MARK: BIRTHDAY LOTTIE:
        birthdayLottie.translatesAutoresizingMaskIntoConstraints = false
        birthdayLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        birthdayLottie.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        birthdayLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        birthdayLottie.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: NAME:

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: birthdayLottie.bottomAnchor, constant: 5).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // MARK: SURNAME:

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
        dateDatePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), primaryAction: UIAction(handler: { _ in
            self.presenter?.showInfo(completion: { [weak self] alert in
                self?.present(alert, animated: true)
            })
        }))
        
        // MARK: BIRTHDAY LOTTIE:
        birthdayLottie.play()
        birthdayLottie.loopMode = .loop
        birthdayLottie.animationSpeed = 0.5
        
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
        
        dateTextField.inputView = dateDatePicker
        dateDatePicker.datePickerMode = .date
        dateDatePicker.maximumDate = Date()
        dateDatePicker.preferredDatePickerStyle = .wheels
        dateDatePicker.addTarget(self, action: #selector(dateDatePickerValueChanged), for: .valueChanged)
        
        // MARK: SAVE BUTTON:
        
        saveButton.backgroundColor = .systemGreen
        saveButton.layer.cornerRadius = 15
        saveButton.layer.masksToBounds = true
        saveButton.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        saveButton.addTarget(self, action: #selector(tapOnSaveButton), for: .touchUpInside)
    }
    
    // MARK: FUNC FOR VALUE CHANGE FROM DATE PICKER:
    @objc private func dateDatePickerValueChanged() {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateTextField.text = dateFormatter.string(from: dateDatePicker.date)
    }
    
    // MARK: - HELPERS:
    
    @objc private func tapOnSaveButton() {
        self.presenter?.saveUser(name: nameTextField.text ?? "", surname: surnameTextField.text ?? "", date: dateTextField.text ?? "") { alertController in
            self.present(alertController, animated: true)
        }
    }
    
    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

    @objc func tapGestureDone() {
        view.endEditing(true)
    }
}
