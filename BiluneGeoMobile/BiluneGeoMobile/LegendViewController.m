//
//  LegendViewController.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "LegendViewController.h"
#import "LegendListCell.h"
#import "LegendEntry.h"

@interface LegendViewController ()

@end

@implementation LegendViewController

@synthesize appDelegate;

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
    
    appDelegate = GetAppDelegate();
    
    self.legendTable.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.legendEntries count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"legendEntryCell";
    
    //get cell
    LegendListCell *cell = (LegendListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = (LegendListCell *)[[LegendListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //get LegendEntry
    LegendEntry *legendEntry = [appDelegate.legendEntries objectAtIndex:indexPath.row];
    if(legendEntry) {
        cell.titleLabel.text = legendEntry.title;
        cell.colorLabel.backgroundColor = legendEntry.color;
    }
    
    return cell;
}

#pragma mark DeviceOrientation
-(BOOL)shouldAutorotate {
    return NO;
}

#pragma mark IBAction
- (IBAction)returnToMap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
