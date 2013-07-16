//
//  SearchOccupantsViewController.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchOccupantsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
- (IBAction)returnToMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *occupantsList;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *filteredOccupants;
@property BOOL isFiltered;

@end
