//
//  MapViewController.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>

@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet AGSMapView *mapView;

@end
