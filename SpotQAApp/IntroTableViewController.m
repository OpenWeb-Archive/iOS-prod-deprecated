//
//  IntroTableViewController.m
//  SpotQAApp
//
//  Created by Nissim Pardo on 01/02/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import "IntroTableViewController.h"
#import "ModuleViewController.h"

@interface IntroTableViewController ()

@end

@implementation IntroTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.row) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"SpotID"
                                                                       message:@"Please enter postId" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"PostID";
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self performSegueWithIdentifier:@"LoadItem" sender:alert.textFields.firstObject.text];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [self performSegueWithIdentifier:@"LoadItem" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ModuleViewController *dest = segue.destinationViewController;
    if (sender) {
        dest.postId = sender;
    }
    dest.spotId = _spotId;
}
@end
