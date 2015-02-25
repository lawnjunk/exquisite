//
//  SwipeShredzViewController.m
//  exquisite
//
//  Created by drwizzard on 2/24/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "SwipeShredzViewController.h"
#import "WriteSegmentViewController.h"

@interface SwipeShredzViewController ()
@property (strong,nonatomic) UIViewController *topViewController;
@property (strong,nonatomic) WriteSegmentViewController *writeVC;
@property (strong,nonatomic) UIPanGestureRecognizer *swipeShredzRecognizer;
@end

@implementation SwipeShredzViewController
//lazy load the view controllers :)
-(WriteSegmentViewController *)writeVC {
    if (!_writeVC) {
        _writeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WRITE_VC"];
    }
    return _writeVC;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"what do ");
    
    [self addChildViewController:self.writeVC];
    self.writeVC.view.frame = self.view.frame;
    [self.view addSubview:self.writeVC.view];
    [self.writeVC didMoveToParentViewController:self];
    self.topViewController = self.writeVC;
    self.swipeShredzRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideShredz:)];
    [self.topViewController.view addGestureRecognizer:self.swipeShredzRecognizer];
    

    // Do any additional setup after loading the view.
}


-(void)slideShredz:(id)sender {
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
    CGPoint translatedPoint = [pan translationInView:self.view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
