//
//  RoomInfoViewController.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "RoomInfoViewController.h"

@interface RoomInfoViewController () {
    Room *room;
    NSArray *infoDataTitle;
    NSArray *infoDataSubTitle;
}

@end

@implementation RoomInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //if attribute == nil --> set to N/A
    if(!room.address){room.address = @"N/A";}
    if(!room.name){room.name = @"N/A";}
    if(!room.area){room.area = @"N/A";}
    if(!room.type){room.type = @"N/A";}
    if(!room.occupants){room.occupants = @"N/A";}
    
    //initialize Data
    infoDataTitle = [NSArray arrayWithObjects:@"Addresse",@"Etage",@"Local",@"Surface",@"Type",@"Occupants", nil];
    infoDataSubTitle = [NSArray arrayWithObjects:room.address,room.parentFloor.floorName, room.name, [NSString stringWithFormat:@"%@ m2",room.area], room.type, room.occupants, nil];
    
    self.infoTable.dataSource = self;
    self.infoTable.delegate = self;
    
    self.title = room.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRoom:(Room *)pRoom {
    room = pRoom;
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [infoDataTitle count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"RoomInfoCell";
    
    //get cell
    UITableViewCell *cell = [self.infoTable dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if([((NSString *)[infoDataTitle objectAtIndex:indexPath.row]) isEqualToString:@"Occupants"]) {
        cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.detailTextLabel.numberOfLines = 8;
    }
    
    //get data
    cell.textLabel.text = [infoDataTitle objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [infoDataSubTitle objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark DeviceOrientation
-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Occupants uses more space
    if([((NSString *)[infoDataTitle objectAtIndex:indexPath.row]) isEqualToString:@"Occupants"]) {
        //if the occupants fields needs more than one line
        if([[infoDataSubTitle objectAtIndex:indexPath.row] length] > 35) {
            return 80;
        } else {
            return 44;
        }
    } else {
        return 44;
    }
}
@end
