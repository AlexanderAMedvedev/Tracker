//
//  HelperCoreData.swift
//  Tracker
//
//  Created by Александр Медведев on 28.12.2023.
//

import CoreData
import UIKit
protocol HelperCoreDataDelegate: AnyObject {
    func updateTrackers()
}

final class HelperCoreData: NSObject {
    
    weak var delegate: HelperCoreDataDelegate?
    
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
        let fetchResultsController = NSFetchedResultsController(fetchRequest: request, 
                                                                managedObjectContext: context,
                                                                sectionNameKeyPath: "category.header",
                                                                cacheName: nil)
        
        fetchResultsController.delegate = self
        
        do  {
            try fetchResultsController.performFetch()
        }
        catch {
            print(error.localizedDescription)
        }
        return fetchResultsController
    }()
    
    func addTrackerToCoreData(model: Tracker, categoryHeader: String) {
        
        let tracker = TrackerCoreData(context: context)
        
        //получение категории
         // создание request
        let trackerCategoryRequest = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
         // уточнение request
        trackerCategoryRequest.predicate = NSPredicate(format: "header == %@", categoryHeader)
         // извлечение запрошенного
        let categoryResult = try? context.fetch(trackerCategoryRequest)
        let categoryCoreData = categoryResult?.first ?? TrackerCategoryCoreData(context: context)
        categoryCoreData.header = categoryHeader
        
        let colorString = uiColorMarshalling.hexString(from: model.color)
        tracker.color = colorString
        tracker.emoji = model.emoji
        tracker.id = model.id
        tracker.name = model.name
        tracker.schedule = model.schedule
        tracker.category = categoryCoreData
        
        appDelegate.saveContext()
    }
    
    func fetchCategory()-> [TrackerCategory] {
        guard let sections = fetchResultsController.sections else {return []}
                                                  // The sections for the fetch results: [NSFetchedResultsSectionInfo]?
        var categories: [TrackerCategory] = []
        
        for section in sections {
            guard let object = section.objects as? [TrackerCoreData] else {
                                     // section.objects - The array of objects in the section: [Any]?
                continue
            }
            var trackers: [Tracker] = []
            for tracker in object {
                let color = uiColorMarshalling.color(from: tracker.color ?? "")
                var records: [TrackerRecord] = []
                for record in tracker.records?.allObjects as [TrackerRecordCoreData] {
                    let newRecord = TrackerRecord(id: record.id!, date: record.date!)
                    records.append(newRecord)
                }
                let newTracker = Tracker(id: tracker.id ?? UUID(),
                                         name: tracker.name ?? "",
                                         color: color,
                                         emoji: tracker.emoji ?? "",
                                         schedule: tracker.schedule ?? [],
                                         records: records)
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
                                   // Executes the controller’s fetch request.
        //обновить коллекцию
        print("Сохранили в CoreData")
        delegate?.updateTrackers()
    }
}
