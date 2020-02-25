//
//  Event.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 2/25/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//
class Event {
    
    
    var event_title: String?
    var description: String?
    var summery: String?
    var location: String?
    var imageUrl: String?
    
    init(event_title: String?, description: String?, summery: String?, location: String?, imageUrl: String?){
        
        //self.id = id
        self.event_title = event_title
        self.description = description
        self.summery = summery
        self.location = location
        self.imageUrl = imageUrl
    }
}
