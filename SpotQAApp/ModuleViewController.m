//
//  ModuleViewController.m
//  SpotQAApp
//
//  Created by Nissim Pardo on 01/02/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import "ModuleViewController.h"
#import <Spot_IM/Spot_IM.h>

@interface ModuleViewController ()
@property (nonatomic) BOOL isPresented;
@end

@implementation ModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Conversation";
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = newBackButton;
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:![SpotConversation shared].isLoggedIn ? @"Login" : @"Logout"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(logout:)];
    self.navigationItem.rightBarButtonItem = logoutButton;
    [SpotConversation shared].frame = (CGRect){0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64.0};
    [self.view addSubview:[SpotConversation shared]];
    [SpotConversation shared].postId = _postId;
    [SpotConversation shared].presentingController = self;
}

- (void)back:(UIBarButtonItem *)sender {
    [[SpotConversation shared] dissmiss];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)logout:(UIBarButtonItem *)sender {
    sender.enabled = NO;
    if ([sender.title isEqualToString:@"Logout"]) {
        [[SpotConversation shared] logoutSSOWithCompletion:^{
            sender.title = @"Login";
            sender.enabled = YES;
        }];
    } else {
        [[SpotConversation shared] startSSOWithHandler:^(NSString *codeA, NSError *error) {
            NSString *test = [NSString stringWithContentsOfURL:[NSURL URLWithString:[@"http://127.0.0.1:1081/getCodeB?codeA=" stringByAppendingString:codeA]]
                                                      encoding:NSUTF8StringEncoding
                                                         error:nil];
            NSLog(@"Conversation %@", test);
            [[SpotConversation shared] completeSSO:test completion:^(NSError *error) {
                if (!error) {
                    sender.enabled = YES;
                    sender.title = @"Logout";
                    NSLog(@"success");
                }
            }];
        }];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    if (_postId && [SpotConversation shared].shouldReload) {
//        [SpotConversation shared].frame = (CGRect){0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64.0};
//        [self.view addSubview:[SpotConversation shared]];
//        [SpotConversation shared].postId = _postId;
//        [SpotConversation shared].presentingController = self;
//        [self.view addSubview:[SpotConversation shared]];
//    }
}

//- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
//    [[SpotConversation shared] dissmiss];
//    [super dismissViewControllerAnimated:flag completion:completion];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [SpotConversation shared].frame = [UIScreen mainScreen].bounds;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
    
}

@end
