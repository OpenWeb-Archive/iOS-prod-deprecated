//
//  RecirculationTableViewController.m
//  SpotQAApp
//
//  Created by Nissim Pardo on 12/02/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import "RecirculationTableViewController.h"
#import <Spot_IM/Spot_IM.h>

@interface RecirculationTableViewController () <SpotIMControllerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) SpotIMController *spotController;
@property (nonatomic) NSInteger rows;
@end

@implementation RecirculationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Recirculation";
    _rows = 3;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_spotController) {
        _spotController = [SpotIMController new];
        _spotController.view.frame = (CGRect){0, 0,  self.view.frame.size.width,  452};
        _spotController.spotId = _spotId;
        _spotController.configuration.title = @"QA";
        _spotController.configuration.maxCacheSize = 200;
        _spotController.delegate = self;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = indexPath.row == 1 && _rows == 4 ? @"Cell" : @"TextCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.row == 1 && _rows == 4) {
        [cell.contentView addSubview:_spotController.view];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_rows == 4 && indexPath.row == 1) {
        return 452.0;
    }
    return 100;
}

#pragma mark SpotIMControllerDelegate

- (void)didLoadSpotIMController:(SpotIMController *)controller {
    _rows = 4;
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
}

- (void)didFailLoadSpotIMController:(SpotIMController *)controller withError:(NSError *)error {
    
}

- (void)didSelectArticle:(NSURL *)url messageId:(NSString *)messageId {
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

- (void)didSelectComment:(NSURL *)url messageId:(NSString *)messageId {
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}
@end
