import CoreData
import UIKit.UIApplication

// MARK: - CORE DATA ERROR:
enum CoreDataError: Error {
    case error(String)
}

// MARK: - CLASS:
final class CoreDataManager {
    static let instance = CoreDataManager()
    private init() {}

    // MARK: - SAVE USER:

    func saveUser(name: String, surname: String, date: String) -> Result<Void, CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.error("AppDelegate not found"))
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        user.setValue(name, forKey: "name")
        user.setValue(surname, forKey: "surname")
        user.setValue(date, forKey: "date")
        do {
            try managedContext.save()
            return .success(())
        } catch {
            return .failure(.error("Could not save. \(error)"))
        }
    }
    
    // MARK: - GET USERS:

    func getUsers() -> Result<[User], CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.error("AppDelegate not found"))
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        do {
            let objects = try managedContext.fetch(fetchRequest)
            return .success(objects)
        } catch {
            return .failure(.error("Could not fetch \(error)"))
        }
    }
    
    // MARK: DELETE USER:

    func deleteUser(_ user: User) -> Result<Void, CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.error("AppDelegate not found"))
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            managedContext.delete(user)
            try managedContext.save()
            return .success(())
        } catch {
            return .failure(.error("Error deleting user: \(error)"))
        }
    }
}
