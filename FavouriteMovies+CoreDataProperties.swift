//
//  FavouriteMovies+CoreDataProperties.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/27/21.
//
//

import Foundation
import CoreData


extension FavouriteMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteMovies> {
        return NSFetchRequest<FavouriteMovies>(entityName: "FavouriteMovies")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var poster_Path: String?
    @NSManaged public var overview: String?
    @NSManaged public var original_title: String?
    @NSManaged public var popularity: Double
    @NSManaged public var release_date: String?

}

extension FavouriteMovies : Identifiable {

}
