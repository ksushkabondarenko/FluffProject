import UIKit
import CoreData

final class CoreDataManager {
    static let instance = CoreDataManager()
    
    func saveWeight(_ task: WeightModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "WeightEntity", in: managedContext)!
        
        let toDo = NSManagedObject(entity: entity, insertInto: managedContext)
        
        toDo.setValue(task.weight, forKey: "weight")
        toDo.setValue(task.date, forKey: "date")
        
        do {
            try managedContext.save()
            print("Saved")
        } catch let error as NSError {
            print("Error - \(error)")
        }
    }
    
    func getWeight() -> [WeightModel]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WeightEntity")
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            var weights = [WeightModel]()
            for object in objects {
                guard let weightTitle = object.value(forKey: "weight") as? Double, let date = object.value(forKey: "date") as? Date else { return nil}
                let weight = WeightModel(weight: weightTitle, date: date)
                weights.append(weight)
            }
            return weights
        } catch let error as NSError {
            print("Error - \(error)")
        }
        return nil
    }
    
    func removeWeight(_ indexPath: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WeightEntity")
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            managedContext.delete(objects[indexPath])
            print("Deleted")
            try managedContext.save()
        } catch let error as NSError {
            print("Error - \(error)")
        }
    }
    
    private init() { }
}
