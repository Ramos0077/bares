//
//  MapsViewController.swift
//  Meu primeiro app
//
//  Created by Jonathan on 18/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import MapKit



class MapsViewController: UIViewController {

    @IBOutlet weak var mapsView: MKMapView!
    
    var artworks: [Artwork] = []
    
    func loadInitialData() {
    
        let artwork = Artwork(title: "moitilas",
                              locationName: "Waikiki Gateway Park",
                              discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: -26.8918542, longitude: -49.0655956))
        
        let artwork2 = Artwork(title: "Comunidade lanches",
                              locationName: "Waikiki Gateway Park",
                              discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: -26.8839173, longitude: -49.0844298))
        
        let artwork3 = Artwork(title: "Dile Lanches",
                               locationName: "Waikiki Gateway Park",
                               discipline: "Sculpture",
                               coordinate: CLLocationCoordinate2D(latitude: -26.8091989, longitude: -49.0813009))
        
        let artwork4 = Artwork(title: "dragão Lanches",
                               locationName: "Waikiki Gateway Park",
                               discipline: "Sculpture",
                               coordinate: CLLocationCoordinate2D(latitude: -26.8861998, longitude: -49.0820582))
        
        artworks += [artwork,artwork2, artwork3, artwork4]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: -26.8918542, longitude: -49.0655956)
        
        
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                      latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapsView.setRegion(coordinateRegion, animated: true)
            
            mapsView.register(Artwork.self,
                             forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            
            loadInitialData()
            mapsView.addAnnotations(artworks)
            
        }
        
      

        centerMapOnLocation(location: initialLocation)
        mapsView.delegate = self
        // show artwork on map
        /*let artwork = Artwork(title: "Moitilas",
                              locationName: "Waikiki Gateway Park",
                              discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: -26.8918542, longitude: -49.0655956))
        mapsView.addAnnotation(artwork)*/
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapsViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }

}

