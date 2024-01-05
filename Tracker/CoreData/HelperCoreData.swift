//
//  HelperCoreData.swift
//  Tracker
//
//  Created by Александр Медведев on 28.12.2023.
//

import CoreData
import UIKit

final class HelperCoreData: NSObject {
    private lazy var appDelegate = {
        UIApplication.shared.delegate as! AppDelegate
    }()
    
    private lazy var context = {
        appDelegate.persistentContainer.viewContext
    }()
    
    //преобразование цвета из string в UIColor и наоборот
    private let uiColorMarshalling = UIColorMarshalling()
    
    // класс для связывания таблицы и данных, полученных с помощью NSFetchRequest
    private lazy var fetchResultsController: NSFetchedResultsController<TrackerCoreData> = {
        //хотим получить записи TrackerCoreData и ответ привести к типу TrackerCoreData
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        //
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TrackerCoreData.category?.header, ascending: true)]
        let fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "category.header", cacheName: nil)
        
        fetchResultsController.delegate = self
        do  {
            try fetchResultsController.performFetch()
        }
        catch {
            print(error.localizedDescription)
        }
        return fetchResultsController
    }()
    
    func addTrackerToCoreData(model: Tracker, category: TrackerCategory) {
        //есть ли категория
        let tracker = TrackerCoreData(context: context)
        
        let colorString = uiColorMarshalling.hexString(from: model.color)
        tracker.color = colorString
        tracker.emoji = model.emoji
        tracker.id = model.id
        tracker.name = model.name
        tracker.schedule = model.schedule
        tracker.category = category
        
        appDelegate.saveContext()
    }
    
    func fetchCategory()-> [TrackerCategory] {
        guard let sections = fetchResultsController.sections else {return []}
        var categories: [TrackerCategory] = []
        
        for section in sections {
            guard let object = section.objects as? [TrackerCoreData] else {
                continue
            }
            var trackers: [Tracker] = []
            for tracker in object {
                let color = uiColorMarshalling.color(from: tracker.color ?? "")
                let newTracker = Tracker(id: tracker.id ?? UUID(),
                                         name: tracker.name ?? "",
                                         color: color,
                                         emoji: tracker.emoji ?? "",
                                         schedule: tracker.schedule ?? [])
                trackers.append(newTracker)
            }
            let newCategory = TrackerCategory(header: section.name, relevantTrackers: trackers)
            categories.append(newCategory)
        }
        return categories
    }
    
}

extension HelperCoreData: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        try? fetchResultsController.performFetch()
        //обновить коллекцию
    }
}
