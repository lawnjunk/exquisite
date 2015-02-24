//
//  WriteSegmentViewController.m
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "WriteSegmentViewController.h"
#import "NetworkController.h"

@interface WriteSegmentViewController ()

@property (strong,nonatomic) NetworkController *networkController;

@end

@implementation WriteSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.networkController = [NetworkController sharedService];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults stringForKey:@"token"];
    if (!token) {
        #warning we shut be presenting modal a login controller
        NSLog(@"there was no token");
        
        [self.networkController createNewAccountWithUserName:@"lulwat" password:@"passwordJokes"];
    }
    
    [self.networkController fetchStoryWithCompletionHandler:^(NSDictionary *results, NSString *error) {
        NSLog(@"whatttt the fuuuuuuk are we dooing");
    }];

  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma turn of the time/battery status bar
-(BOOL)prefersStatusBarHidden {
    return true;
}

@end
