//
//  WriteSegmentViewController.m
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "WriteSegmentViewController.h"
#import "NetworkController.h"

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
    }];

    
    
//    
//    
//    NSString *testButton =  @"this is a test";
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:testButton];
//    NSURL *myURL = [NSURL URLWithString:@"1"];
//    NSRange testRange = [testButton rangeOfString:@"is a"];
//    NSRange rangeOfTest = [testButton rangeOfString:@"test"  ];
//    [str addAttribute: value:myURL range:testRange];
//
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rangeOfTest];
//    
//    self.testTextView.attributedText = str;
//    self.testTextView.delegate = self;
//    self.testTextView.editable = false;
//    yourTextView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSUnderlineStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
//
//    self.testTextView.dataDetectorTypes = UIDataDetectorTypeLink ;
//    [self.testTextView setSelectedRange:testRange];
    
  
  
  
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
