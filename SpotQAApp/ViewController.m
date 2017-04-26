//
//  ViewController.m
//  SpotQAApp
//
//  Created by Nissim Pardo on 23/01/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import "ViewController.h"
#import "IntroTableViewController.h"
#import <Spot_IM/Spot_IM.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *spotIdTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@end

@interface SpotConversation ()
@property (nonatomic) BOOL isStaging;
@end

@interface SpotIM()
@property (nonatomic) BOOL staging;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)load:(UIButton *)sender {
    [SpotConversation shared].isStaging = _segment.selectedSegmentIndex == 0;
    [SpotIM shared].staging = _segment.selectedSegmentIndex == 0;
    [SpotConversation shared].spotId = _spotIdTextField.text;
    [[SpotConversation shared] startSSOWithHandler:^(NSString *codeA, NSError *error) {
        NSString *test = [NSString stringWithContentsOfURL:[NSURL URLWithString:[@"http://127.0.0.1:1081/getCodeB?codeA=" stringByAppendingString:codeA]]
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
        NSLog(@"Conversation %@", test);
        [[SpotConversation shared] completeSSO:test completion:^(NSError *error) {
            if (!error) {
                NSLog(@"success");
            }
        }];
    }];
    [_spotIdTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ((IntroTableViewController *)segue.destinationViewController).spotId = _spotIdTextField.text;
}

@end
