//
//  BookingViewModel.swift
//  Example
//
//  Created by Danil Kristalev on 19.11.2021.
//  Copyright © 2021 Exyte. All rights reserved.
//

import Foundation
import Combine
import _MapKit_SwiftUI

class BookingScreenViewModel: ObservableObject {
    
    @Published var placeName: String = ""
    @Published var stars: Double = 0.0
    @Published var address: String = ""
    @Published var roomDesription: String = ""
    @Published var badges: [Badge] = []
    @Published var price: Int = 0
    @Published var description: String = ""
    
    @Published private(set) var currentHotel: Hotel = .capoBayHotel
    
    @Published var mapPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.01266423456241, longitude: 34.057450219436646),
            latitudinalMeters: 400,
            longitudinalMeters: 400
        )
    )

    @Published var hotels: [Hotel] = []
    
    private var mapService = MapService()
    
    init() {
        $currentHotel
            .map(\.name)
            .assign(to: &$placeName)
        
        $currentHotel
            .map(\.stars)
            .assign(to: &$stars)
        
        $currentHotel
            .map(\.address)
            .assign(to: &$address)
        
        $currentHotel
            .map(\.address)
            .assign(to: &$address)
        
        $currentHotel
            .map(\.roomDescription)
            .assign(to: &$roomDesription)
        
        $currentHotel
            .map(\.badges)
            .assign(to: &$badges)
        
        $currentHotel
            .map(\.price)
            .assign(to: &$price)
        
        $currentHotel
            .map(\.description)
            .assign(to: &$description)

        mapService.hotels.publisher
            .collect()
            .assign(to: &$hotels)
    }
    
    func select(hotel: Hotel) {
        currentHotel = hotel
    }
}
