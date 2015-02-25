//
//  WriteSegmentViewController.m
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "WriteSegmentViewController.h"
#import "NetworkController.h"
#import "ReadStoryViewController.h"

@interface WriteSegmentViewController () <UIGestureRecognizerDelegate>

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
        NSLog(@"%@ thesse results", results);
        self.currentStory = [[Story alloc] initWithJSONData:results];
        NSLog(@"we just tried to init the current story %@", self.currentStory.title);
        NSLog(@"we this is level 0 %@ ", self.currentStory.levels);
        
        
    }];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SHOW_READ_FROM_WRITE"]){
        ReadStoryViewController *readVC = segue.destinationViewController;
        readVC.selectedStory = self.currentStory;
    }
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
