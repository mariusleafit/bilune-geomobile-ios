//
//  MapViewController.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>
#import "ScaleBarView.h"
#import "Building.h"
#import "RoomQueryDelegate.h"

@interface MapViewController : UIViewController<AGSMapViewTouchDelegate, AGSMapViewLayerDelegate, RoomQueryDelegate, AGSCalloutDelegate> {
    int scaleBarValueInMeters;
}
@property (weak, nonatomic) IBOutlet AGSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *compass;
- (IBAction)returnToMenu:(id)sender;
- (IBAction)showMapOverview:(id)sender;
- (IBAction)showLegend:(id)sender;
-(void) updateVisibleFloorsFromBuilding:(Building *)building;
@property (weak, nonatomic) IBOutlet ScaleBarView *mapScale;
///set before display of view --> map gets zoomed to this room and room gets highlighted
-(void)setRoomToZoomTo:(Room *)room;
@end
