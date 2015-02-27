//
//  TimeLineViewController.h
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "ProfileSegueDelegate.h"

@interface TimeLineViewController : UIViewController

@property(weak) id<ProfileSegueDelegate> delegate;

@property(strong, nonatomic) User *currentUser;

@end
