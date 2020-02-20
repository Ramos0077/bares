//
//  ArtworkViews.swift
//  Meu primeiro app
//
//  Created by Jonathan on 19/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import MapKit
    
    class ArtworkMarkerView: MKMarkerAnnotationView {
        override var annotation: MKAnnotation? {
            willSet {
                // 1
                guard let artwork = newValue as? Artwork else { return }
                canShowCallout = true
                calloutOffset = CGPoint(x: -5, y: 5)
                let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                        size: CGSize(width: 30, height: 30)))
                mapsButton.setBackgroundImage(UIImage(named: "image"), for: UIControl.State())
                rightCalloutAccessoryView = mapsButton
               
                if let imageName = artwork.imageName {
                    image = UIImage(named: imageName)
                } else {
                    image = nil
                }
            }
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


