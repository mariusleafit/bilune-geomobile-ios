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
#import "CompassView.h"

@interface MapViewController : UIViewController<AGSMapViewTouchDelegate, AGSMapViewLayerDelegate, RoomQueryDelegate, AGSCalloutDelegate> {
    float scaleBarValueInMeters;
}
- (IBAction)showInfo:(id)sender;
@property (weak, nonatomic) IBOutlet AGSMapView *mapView;
@property (weak, nonatomic) IBOutlet CompassView *compass;

- (IBAction)showLegend:(id)sender;
-(void) updateVisibleFloorsFromBuilding:(Building *)building;
@property (weak, nonatomic) IBOutlet ScaleBarView *mapScale;
///set before display of view --> map gets zoomed to this room and room gets highlighted
-(void)setRoomToZoomTo:(Room *)room;
- (IBAction)toggleGPS:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *gpsButton;
- (IBAction)toggleSatelite:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sateliteButton;
@property (weak, nonatomic) IBOutlet UILabel *mapInfoText;
@end
