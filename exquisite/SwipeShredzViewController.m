//
//  SwipeShredzViewController.m
//  exquisite
//
//  Created by drwizzard on 2/24/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "SwipeShredzViewController.h"
#import "TimeLineViewController.h"
#import "BrowseStorysViewController.h"
#import "WriteSegmentViewController.h"

@interface SwipeShredzViewController ()

@property (strong,nonatomic) UIViewController *topViewController;
@property (strong,nonatomic) TimeLineViewController *myProfileVC;
@property (strong, nonatomic) WriteSegmentViewController *writeStoryVC;
@property (strong, nonatomic) BrowseStorysViewController *storyBrowserVC;

@property (strong,nonatomic) UITapGestureRecognizer *tapToClose;
@property (strong,nonatomic) UIPanGestureRecognizer *slideRecognizer;

@property(strong, nonatomic) UIButton *profileButton;

@end

@implementation SwipeShredzViewController

//lazy load the view controllers :)
-(WriteSegmentViewController *)writeStoryVC {
    if (!_writeStoryVC) {
        _writeStoryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WRITE_VC"];
    }
    return _writeStoryVC;
}

-(TimeLineViewController *)myProfileVC {
  if (!_myProfileVC) {
    _myProfileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PROFILE_VC"];
  }
  return _myProfileVC;
}

-(BrowseStorysViewController *)storyBrowserVC {
  if (!_storyBrowserVC) {
    _storyBrowserVC = [self.storyboard instantiateViewControllerWithIdentifier:@"STORIES_VC"];
  }
  return _storyBrowserVC;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self addChildViewController:self.writeStoryVC];
  self.writeStoryVC.view.frame = self.view.frame;
  [self.view addSubview:self.writeStoryVC.view];
  [self.writeStoryVC didMoveToParentViewController:self];
  self.topViewController = self.writeStoryVC;
  
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
  [button setTitle:@"Profilz" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(profileButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [self.writeStoryVC.view addSubview:button];
  
  self.profileButton = button;
  
  self.tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePanel)];
  
  self.slideRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slidePanel:)];
  [self.topViewController.view addGestureRecognizer:self.slideRecognizer];
  
}

-(void)profileButtonPressed {
  
  self.profileButton.userInteractionEnabled = false;
  
  __weak SwipeShredzViewController *weakSelf = self;
  [UIView animateWithDuration:.3 animations:^{
    weakSelf.topViewController.view.center = CGPointMake(weakSelf.topViewController.view.center.x +400, weakSelf.topViewController.view.center.y);
  } completion:^(BOOL finished) {
    [weakSelf.topViewController.view addGestureRecognizer:weakSelf.tapToClose];
  }];
}

-(void)closePanel {
  
  [self.topViewController.view removeGestureRecognizer:self.tapToClose];
  
  __weak SwipeShredzViewController *weakSelf = self;
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.topViewController.view.center = weakSelf.view.center;
  } completion:^(BOOL finished) {
    weakSelf.profileButton.userInteractionEnabled = true;
  }];
}

-(void)slidePanel:(id)sender {
  UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
  
  CGPoint translatedPoint = [pan translationInView:self.view];
  CGPoint velocity = [pan velocityInView:self.view];
  
  if ([pan state] == UIGestureRecognizerStateChanged) {
    
    if (velocity.x > 0 || self.topViewController.view.frame.origin.x > 0) {
      self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translatedPoint.x, self.topViewController.view.center.y);
      [pan setTranslation:CGPointZero inView:self.view];
      
    }
  }
  if ([pan state] == UIGestureRecognizerStateEnded) {
    __weak SwipeShredzViewController *weakSelf = self;

    if (self.topViewController.view.frame.origin.x > self.view.frame.size.width / 2) {
      self.profileButton.userInteractionEnabled = false;
      [UIView animateWithDuration:0.3 animations:^{
        self.topViewController.view.center = CGPointMake(weakSelf.view.frame.size.width *2.00, weakSelf.topViewController.view.center.y);
      } completion:^(BOOL finished) {
        [weakSelf.topViewController.view addGestureRecognizer:weakSelf.tapToClose];
      }];
    }
    else {
      [UIView animateWithDuration:0.2 animations:^{
        weakSelf.topViewController.view.center = weakSelf.view.center;
      }];
      [self.topViewController.view removeGestureRecognizer:self.tapToClose];
    }
  }
 }

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if ([segue.identifier isEqualToString:@"EMBED_MENU"]) {
    TimeLineViewController *destinationVC = segue.destinationViewController;
    self.myProfileVC = destinationVC;
  }
}

-(void)switchToViewController:(UIViewController *)destinationVC {
  
  __weak SwipeShredzViewController *weakSelf = self;
  [UIView animateWithDuration:0.2 animations:^{
    
    weakSelf.topViewController.view.frame = CGRectMake(weakSelf.view.frame.size.width, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
  } completion:^(BOOL finished) {
    
    destinationVC.view.frame = self.topViewController.view.frame;
    
    [self.topViewController.view removeGestureRecognizer:self.slideRecognizer];
    [self.profileButton removeFromSuperview];
    [self.topViewController willMoveToParentViewController:nil];
    [self.topViewController.view removeFromSuperview];
    [self.topViewController removeFromParentViewController];
    
    self.topViewController = destinationVC;
    
    [self addChildViewController:self.topViewController];
    [self.view addSubview:self.topViewController.view];
    [self.topViewController didMoveToParentViewController:self];
    [self.topViewController.view addSubview:self.profileButton];
    [self.topViewController.view addGestureRecognizer:self.slideRecognizer];
    
    [self closePanel];
  } ];
}

@end
