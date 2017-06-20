//
//  MenuTableViewController.m
//  SpotQAApp
//
//  Created by Nissim Pardo on 19/06/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import "MenuTableViewController.h"
#import "SectionView.h"
#import "DataTableViewCell.h"
#import <Spot_IM/Spot_IM.h>
#import "RecirculationTableViewController.h"
#import "WebviewReadViewController.h"

@interface SpotConversation ()
@property (nonatomic) BOOL isStaging;
@end

@interface SpotIM()
@property (nonatomic) BOOL staging;
@end

@interface MenuTableViewController () <SectionViewDelegate>
@property (nonatomic, copy) NSDictionary *menu;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic, weak) IBOutlet UISegmentedControl *stateControl;
@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
    _menu = [NSDictionary dictionaryWithContentsOfFile:path];
    _currentIndex = -1;
    self.tableView.tableFooterView = [UIView new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversationReady:) name:@"SpotConversationReadyNotification" object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)conversationReady:(NSNotification *)notification {
    if (self.tableView.visibleCells.count > 1) {
        NSString *postId = [self.tableView.visibleCells[1] text];
        [SpotConversation shared].postId = postId;
        NSString *pick = _menu.allKeys[_currentIndex];
        if ([pick isEqualToString:@"Conversation"]) {
            [self performSegueWithIdentifier:@"Conversation" sender:nil];
        } else if ([pick isEqualToString:@"Conversation iFrame"]) {
            [self performSegueWithIdentifier:@"iFrame" sender:nil];
        }
    }
}

- (IBAction)presentSpotIM:(id)sender {
    NSString *pick = _menu.allKeys[_currentIndex];
    NSString *spotId = [self.tableView.visibleCells.firstObject text];
    [SpotConversation shared].isStaging = !_stateControl.selectedSegmentIndex;
    if ([pick isEqualToString:@"Conversation"]) {
        [SpotConversation shared].spotId = spotId;
    } else if ([pick isEqualToString:@"Conversation iFrame"]) {
        [SpotConversation shared].spotId = spotId;
    } else {
        [self performSegueWithIdentifier:@"Recirculation" sender:spotId];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _menu.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_currentIndex == section) {
        return [_menu.allValues[_currentIndex] count];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionView *view = [[SectionView alloc] initWithFrame:(CGRect){CGPointZero, self.view.frame.size.width, 44.0}];
    view.delegate = self;
    view.text = _menu.allKeys[section];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.hint = _menu.allValues[_currentIndex][indexPath.row];
    // Configure the cell...
    
    return cell;
}

- (void)view:(SectionView *)view shouldPresentOptions:(NSArray *)options {
    NSInteger index = [_menu.allKeys indexOfObject:view.text];
    if (index != _currentIndex) {
        if (_currentIndex >= 0) {
            NSMutableArray *indexes = [NSMutableArray new];
            for (int i = 0; i < [_menu.allValues[_currentIndex] count]; i++) {
                [indexes addObject:[NSIndexPath indexPathForRow:i inSection:_currentIndex]];
            }
            _currentIndex = -1;
            [self.tableView deleteRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationLeft];
        }
        _currentIndex = index;
        NSMutableArray *indexes = [NSMutableArray new];
        for (int i = 0; i < [_menu.allValues[_currentIndex] count]; i++) {
            [indexes addObject:[NSIndexPath indexPathForRow:i inSection:_currentIndex]];
        }
        [self.tableView insertRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationRight];
    }
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isKindOfClass:[RecirculationTableViewController class]]) {
        ((RecirculationTableViewController *)segue.destinationViewController).spotId = sender;
        [SpotIM shared].staging = !_stateControl.selectedSegmentIndex;
    } else if ([segue.destinationViewController isKindOfClass:[WebviewReadViewController class]]) {
        ((WebviewReadViewController *)segue.destinationViewController).demoPageLink = [self.tableView.visibleCells.lastObject text];
    }
}



@end
