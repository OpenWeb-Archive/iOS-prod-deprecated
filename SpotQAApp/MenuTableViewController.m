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
#import "SwitchTableViewCell.h"

@interface SpotConversation ()
@property (nonatomic) BOOL isStaging;
@end

@interface SpotIM()
@property (nonatomic) BOOL staging;
@end

@interface MenuTableViewController () <SectionViewDelegate, SwitchTableViewCellDelegate>
@property (nonatomic, copy) NSDictionary *menu;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic, weak) IBOutlet UISegmentedControl *stateControl;
@property (nonatomic) SwitchTableViewCell *switchCell;

@property (nonatomic) NSString *spotID;
@property (nonatomic) NSString *postID;
@property BOOL shouldLoadDefaultValues;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnLoad;
@property (nonatomic) UIActivityIndicatorView *loader;


@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Swith to FALSE if no default values desired:
    _shouldLoadDefaultValues = YES;
    _spotID = @"sp_IjnMf2Jd"; //AOL
    _postID = @"23307176"; // Post @ Production
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
    _menu = [NSDictionary dictionaryWithContentsOfFile:path];
    _currentIndex = -1;
    self.tableView.tableFooterView = [UIView new];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(conversationReady:)
                                                 name:@"SpotConversationReadyNotification"
                                               object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// in Order to Load the Default Values:

- (void)loadDefaultValue:(NSString *) spotID andPost:(NSString *) postID {
    [self.tableView.visibleCells.firstObject setText:spotID];
    for (int i = 0; i < [_menu.allKeys count]; i++) {
        [self.tableView.visibleCells[1] setText:postID];
    }
}

- (void)conversationReady:(NSNotification *)notification {
    [_loader stopAnimating];
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
    _spotID = [self.tableView.visibleCells.firstObject text];
    if ([self.tableView.visibleCells count] > 1) {
        _postID = [self.tableView.visibleCells[1] text];
    }
    [SpotConversation shared].isStaging = !_stateControl.selectedSegmentIndex;
    if ([pick isEqualToString:@"Recirculation"]) {
        [self performSegueWithIdentifier:@"Recirculation" sender:_spotID];
    } else if ([pick isEqualToString:@"Conversation iFrame"]) {
        [self performSegueWithIdentifier:@"iFrame" sender:nil];
    } else {
        [self prepareConversation:_spotID];
    }
}

- (void)showLoader {
    if (_loader == nil) {
        _loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loader.hidesWhenStopped = YES;
        _loader.frame = self.view.frame;
        [self.view addSubview:_loader];
    }
    [_loader startAnimating];
}

- (void)prepareConversation:(NSString *)spotId {
    // Updating the UI:
    [self showLoader];
    ////
    [SpotConversation shared].spotId = spotId;
    if (_switchCell.isEnabled) {
        [[SpotConversation shared] startSSOWithHandler:^(NSString *codeA, NSError *error) {
            if (!codeA && !error) {
                _switchCell.loggedIn = YES;
                return;
            }
            NSString *test = [NSString stringWithContentsOfURL:[NSURL URLWithString:[@"http://127.0.0.1:3000/getCodeB?codeA=" stringByAppendingString:codeA]]
                                                      encoding:NSUTF8StringEncoding
                                                         error:nil];
            [[SpotConversation shared] completeSSO:test completion:^(NSError *error) {
                if (!error) {
                    _switchCell.loggedIn = YES;
                } else {
                    NSLog(@"SSO ERROR::: %@", error.description);
                }
            }];
        }];
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
    NSString *identifier = [_menu.allValues[_currentIndex][indexPath.row] lastObject];
    DataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(setHint:)]) {
        NSArray* menuValues = _menu.allValues[_currentIndex][indexPath.row];
        cell.hint = [menuValues firstObject];
        // Loading Default Values:
        if (self.shouldLoadDefaultValues) {
            if ([[menuValues firstObject] isEqualToString:@"SpotId"]) {
                [cell setDefaultText:_spotID];
            }
            if ([[menuValues firstObject] isEqualToString:@"PostId"]) {
                [cell setDefaultText:_postID];
            }
        }
    } else {
        _switchCell = (SwitchTableViewCell *)cell;
        _switchCell.delegate = self;
    }
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


- (void)cell:(SwitchTableViewCell *)cell didChangeLoginState:(BOOL)isLoggedIn {
    if (isLoggedIn) {
        [[SpotConversation shared] logoutSSOWithCompletion:^{
            _switchCell.loggedIn = NO;
        }];
    } else {
        [[SpotConversation shared] startSSOWithHandler:^(NSString *codeA, NSError *error) {
            if (!codeA && !error) {
                _switchCell.loggedIn = YES;
                return;
            }
            NSString *test = [NSString stringWithContentsOfURL:[NSURL URLWithString:[@"http://127.0.0.1:3000/getCodeB?codeA=" stringByAppendingString:codeA]]
                                                      encoding:NSUTF8StringEncoding
                                                         error:nil];
            [[SpotConversation shared] completeSSO:test completion:^(NSError *error) {
                if (!error) {
                    _switchCell.loggedIn = YES;
                } else {
                }
            }];
        }];
    }
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isKindOfClass:[RecirculationTableViewController class]]) {
        ((RecirculationTableViewController *)segue.destinationViewController).spotId = sender;
        [SpotIM shared].staging = !_stateControl.selectedSegmentIndex;
    } else if ([segue.destinationViewController isKindOfClass:[WebviewReadViewController class]]) {
        ((WebviewReadViewController *)segue.destinationViewController).demoPageLink = [self.tableView.visibleCells.lastObject text];
        ((WebviewReadViewController *)segue.destinationViewController).spotId = _spotID;
        ((WebviewReadViewController *)segue.destinationViewController).postId = _postID;
        ((WebviewReadViewController *)segue.destinationViewController).isStaging = !_stateControl.selectedSegmentIndex;
    }
}



@end
