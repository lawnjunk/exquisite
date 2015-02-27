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
#import "bowserSegueProtocol.h"


@interface SwipeShredzViewController ()<UITabBarControllerDelegate, bowserSegueProtocol, ProfileSegueDelegate>

@property(strong, nonatomic) UITabBarController *tabBarControler;

@property (strong,nonatomic) UIViewController *topViewController;
@property (strong, nonatomic) WriteSegmentViewController *writeStoryVC;

@property (strong,nonatomic) UITapGestureRecognizer *tapToClose;
@property (strong,nonatomic) UIPanGestureRecognizer *slideRecognizer;

@property(strong, nonatomic) UIButton *profileButton;
@property(strong, nonatomic) UIButton *storiesButton;

@property (weak,nonatomic) UITabBarController *tabBarVC;
@property (nonatomic) NSInteger currentSelectedIndex;
@property(nonatomic) BOOL didSwipeLeft;


@end

@implementation SwipeShredzViewController

//lazy load the view controllers :)
-(WriteSegmentViewController *)writeStoryVC {
    if (!_writeStoryVC) {
        _writeStoryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WRITE_VC"];
    }
    return _writeStoryVC;
}

-(UITabBarController *)tabBarControler {
  if (!_tabBarControler) {
    _tabBarControler = [self.storyboard instantiateViewControllerWithIdentifier:@"TAB_BAR_CONTROLLER"];
  }
  return _tabBarControler;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.currentSelectedIndex = 0;
  self.tabBarControler.delegate = self;

  [self addChildViewController:self.writeStoryVC];
  self.writeStoryVC.view.frame = self.view.frame;
  [self.view addSubview:self.writeStoryVC.view];
  [self.writeStoryVC didMoveToParentViewController:self];
  self.topViewController = self.writeStoryVC;
  
  UIButton *profileButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
  [profileButton setTitle:@"Profilz" forState:UIControlStateNormal];
  [profileButton addTarget:self action:@selector(profileButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [self.writeStoryVC.view addSubview:profileButton];
  
  UIButton *storiesButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 75, 25, 50, 50)];
  [storiesButton setTitle:@"Storiz" forState:UIControlStateNormal];
  [storiesButton addTarget:self action:@selector(storiesButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [self.writeStoryVC.view addSubview:storiesButton];
  
  self.profileButton = profileButton;
  self.storiesButton = storiesButton;
  
  self.tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePanel)];
  
  self.slideRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slidePanel:)];
  [self.topViewController.view addGestureRecognizer:self.slideRecognizer];
  
}

-(void)profileButtonPressed {
  self.didSwipeLeft = true;
  self.tabBarVC.selectedIndex = 0;
  self.currentSelectedIndex = 0;

  
  __weak SwipeShredzViewController *weakSelf = self;
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.topViewController.view.center = CGPointMake(weakSelf.topViewController.view.center.x +400, weakSelf.topViewController.view.center.y);
  } completion:^(BOOL finished) {
    [weakSelf.topViewController.view addGestureRecognizer:weakSelf.tapToClose];

  }];
}

-(void)storiesButtonPressed {
  self.didSwipeLeft = false;
  self.tabBarVC.selectedIndex = 1;
  self.currentSelectedIndex = 1;
  
  __weak SwipeShredzViewController *weakSelf = self;
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.topViewController.view.center = CGPointMake(weakSelf.topViewController.view.center.x -400, weakSelf.topViewController.view.center.y);
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
  }];
}

-(void)slidePanel:(id)sender {
  UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
  
  CGPoint translatedPoint = [pan translationInView:self.view];
  CGPoint velocity = [pan velocityInView:self.view];
  
  if ([pan state] == UIGestureRecognizerStateChanged) {
    if (velocity.x > 0 || self.topViewController.view.frame.origin.x > 0) {
      if (self.currentSelectedIndex == 1 && self.topViewController.view.frame.origin.x > 0) {
        self.tabBarVC.selectedIndex = 0;
        self.currentSelectedIndex = 0;
        self.didSwipeLeft = true;
      }
      self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translatedPoint.x, self.topViewController.view.center.y);
      [pan setTranslation:CGPointZero inView:self.view];
    }
    else if (velocity.x < 0 || self.topViewController.view.frame.origin.x > 0){
      self.tabBarVC.selectedIndex = 1;
      self.currentSelectedIndex = 1;
      self.didSwipeLeft = false;

      self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translatedPoint.x, self.topViewController.view.center.y);
      [pan setTranslation:CGPointZero inView:self.view];
    }
  }
  
  __weak SwipeShredzViewController *weakSelf = self;
  
  if ([pan state] == UIGestureRecognizerStateEnded) {
    if (self.didSwipeLeft == true) {
      if (self.topViewController.view.frame.origin.x > self.view.frame.size.width / 2) {
        NSLog(@"DID SWIPE RIGHT MORE THAN HALF WAY");
        [UIView animateWithDuration:0.3 animations:^{
          self.topViewController.view.center = CGPointMake(weakSelf.view.frame.size.width * 2.00, weakSelf.topViewController.view.center.y);
        } completion:^(BOOL finished) {
          [weakSelf.topViewController.view addGestureRecognizer:weakSelf.tapToClose];
        }];
      }
      else {
        [UIView animateWithDuration:0.3 animations:^{
          weakSelf.topViewController.view.center = weakSelf.view.center;
        }];
        [self.topViewController.view removeGestureRecognizer:self.tapToClose];
      }
    }
    else{
      if ((self.topViewController.view.frame.origin.x + self.view.frame.size.width) < self.view.frame.size.width / 2) {
        NSLog(@"DID SWIPE LEFT MORE THAN HALF WAY");
        [UIView animateWithDuration:0.3 animations:^{
          self.topViewController.view.center = CGPointMake(weakSelf.view.frame.size.width * -1.00, weakSelf.topViewController.view.center.y);
        } completion:^(BOOL finished) {
          [weakSelf.topViewController.view addGestureRecognizer:weakSelf.tapToClose];
        }];
      }
      else {
        [UIView animateWithDuration:0.3 animations:^{
          weakSelf.topViewController.view.center = weakSelf.view.center;
        }];
        [self.topViewController.view removeGestureRecognizer:self.tapToClose];
      }
    }
  }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if ([segue.identifier isEqualToString:@"EMBED_MENU"]) {
    
    UITabBarController *tabbarController = segue.destinationViewController;
    tabbarController.delegate = self;
    BrowseStorysViewController *storyBrowserVC = tabbarController.viewControllers[1];
    storyBrowserVC.delegate = self;
    TimeLineViewController *profileBrowserVC = tabbarController.viewControllers[0];
    profileBrowserVC.delegate = self;
    self.tabBarVC = tabbarController;
  }
}


-(void)switchToViewController:(UIViewController *)destinationVC {
  
  __weak SwipeShredzViewController *weakSelf = self;
  [UIView animateWithDuration:0.3 animations:^{
    
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


-(void)writeStoryButtonPushed{
  NSLog(@"BOOM BITCHES");
  __weak SwipeShredzViewController *weakSelf = self;
  
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.topViewController.view.center = weakSelf.view.center;
  } completion:^(BOOL finished) {
    //completed homay
  }];
}

-(void)writeStoryButtonPushedinProfile{
  __weak SwipeShredzViewController *weakSelf = self;
  
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.topViewController.view.center = weakSelf.view.center;
  } completion:^(BOOL finished) {
    //completed homay
  }];
}

@end
