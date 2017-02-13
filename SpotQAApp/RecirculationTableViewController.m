//
//  RecirculationTableViewController.m
//  SpotQAApp
//
//  Created by Nissim Pardo on 12/02/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import "RecirculationTableViewController.h"
#import <Spot_IM/Spot_IM.h>

@interface RecirculationTableViewController ()
@property (nonatomic, strong) SpotIMController *spotController;
@end

@implementation RecirculationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Recirculation";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_spotController) {
        _spotController = [SpotIMController new];
        _spotController.view.frame = (CGRect){0, 0,  self.view.frame.size.width,  452};
        _spotController.spotId = _spotId;
        _spotController.configuration.title = @"QA";
        _spotController.configuration.maxCacheSize = 200;
        [self.view addSubview:_spotController.view];
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        [cell.contentView addSubview:_spotController.view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        _spotController.view.frame = (CGRect){CGPointZero, size.width, 452.0};
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

@end
