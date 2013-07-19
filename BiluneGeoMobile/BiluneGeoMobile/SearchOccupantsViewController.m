//
//  SearchOccupantsViewController.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "SearchOccupantsViewController.h"
#import "MainMenuViewController.h"
#import "AppDelegate.h"
#import "Occupant.h"

@interface SearchOccupantsViewController ()

@end

@implementation SearchOccupantsViewController

@synthesize filteredOccupants, isFiltered;

AppDelegate *appDelegate = nil;

NSMutableArray *initialSections = nil;
NSMutableArray *filteredSections = nil;

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
    
    
    [self.occupantsList setDataSource:self];
    [self.occupantsList setDelegate:self];
    
    [self.searchBar setDelegate:self];
    
    isFiltered = false;
    
    //initialize initialSections
    if(appDelegate == nil) {
        appDelegate = GetAppDelegate();
    }
    
    initialSections = [self generateSectionArrayWidthOccupants:appDelegate.occupants];
}

///generates a MutableArray with a Dictionary with the following format:
///"firstLetter":NSString, "index":NSNumber
-(NSMutableArray *)generateSectionArrayWidthOccupants:(NSMutableArray *)data {
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:26];
    
    int i = 0;
    int keyCounter = 0;
    for (Occupant *occupant in data) {
        NSString *firstLetter = [[NSString stringWithFormat:@"%c",[occupant.occupantName characterAtIndex:0]] uppercaseString];
        
        NSDictionary *currentDict = nil;
        if(keyCounter > 0) {
            currentDict = (NSDictionary *)returnArray[keyCounter -1];
        }
        if(keyCounter == 0|| ![firstLetter isEqualToString:[(NSString *)[currentDict valueForKey:@"firstLetter"] uppercaseString]]) {
            NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc] init];
            [newDictionary setValue:firstLetter forKey:@"firstLetter"];
            [newDictionary setValue:[NSNumber numberWithInteger:i] forKey:@"index"];
            returnArray[keyCounter] = newDictionary;
            keyCounter++;
        }
        i++;
    }
    return returnArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *sections = nil;
    if(isFiltered) {
        sections = filteredSections;
    } else {
        sections = initialSections;
    }
    
    NSMutableDictionary *currentSection = sections[section];
    
    //if there is a nexSection to use 
    if(section < ([sections count] -1)) {
        NSMutableDictionary *nextSection = sections[section + 1];
    
        return(NSInteger)([(NSNumber *)[nextSection valueForKey:@"index"] integerValue]  - [(NSNumber *)[currentSection valueForKey:@"index"] integerValue]);
    } else {
        if(appDelegate == nil) {
            appDelegate = GetAppDelegate();
        }
        if(isFiltered) {
            return [filteredOccupants count] - [(NSNumber *)[currentSection valueForKey:@"index"] integerValue];
        } else {
            return [appDelegate.occupants count] - [(NSNumber *)[currentSection valueForKey:@"index"] integerValue];
        }
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSMutableArray *sections = nil;
    if(isFiltered) {
        sections = filteredSections;
    } else {
        sections = initialSections;
    }
    
    NSMutableDictionary *currentSection = sections[section];
    
    return [(NSString *)currentSection valueForKey:@"firstLetter"];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    if(isFiltered) {
        return (NSInteger)filteredSections.count;
    } else {
        return (NSInteger)initialSections.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"OccupantCell";
    
    //get cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Occupant *occupant = nil;
    if(isFiltered) {
        NSNumber *indexOfFirstOccupantOfSection = [(NSMutableDictionary *)filteredSections[indexPath.section] valueForKey:@"index"];
        occupant = [filteredOccupants objectAtIndex:([indexOfFirstOccupantOfSection integerValue] + indexPath.row)];
    } else {
        if(appDelegate == nil) {
            appDelegate = GetAppDelegate();
        }
        NSNumber *indexOfFirstOccupantOfSection = [(NSMutableDictionary *)initialSections[indexPath.section] valueForKey:@"index"];
        occupant = [appDelegate.occupants objectAtIndex:([indexOfFirstOccupantOfSection integerValue] + indexPath.row)];
    }
    
    [cell.textLabel setText:occupant.occupantName];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@: %@", occupant.locTypeDesignation, occupant.locCode]];
    return cell;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dict in initialSections) {
        [returnArray addObject:[dict valueForKey:@"firstLetter"]];
    }
    return returnArray;
}

#pragma mark UITableViewDelegate


#pragma mark UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if(searchText.length == 0) {
        isFiltered = false;
    } else {
        
        if(appDelegate == nil) {
            appDelegate = GetAppDelegate();
        }
        isFiltered = true;
        
        //generate filteredOccupants
        filteredOccupants = [[NSMutableArray alloc] init];
        for(Occupant *occupant in appDelegate.occupants) {
            NSRange occupantNameRange = [occupant.occupantName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(occupantNameRange.location != NSNotFound) {
                [filteredOccupants addObject:occupant];
            }
        }
        
        //generate filteredSections
        filteredSections = [self generateSectionArrayWidthOccupants:filteredOccupants];
    }
    
    [self.occupantsList reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    isFiltered = false;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    isFiltered = false;
}

#pragma mark IBAction


- (IBAction)returnToMenu:(id)sender {
    //show main menu
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
    MainMenuViewController *viewController = (MainMenuViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
    [self presentViewController:viewController animated:YES completion:nil];
}


@end
