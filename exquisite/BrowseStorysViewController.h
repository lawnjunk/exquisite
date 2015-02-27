//
//  BrowseStorysViewController.h
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bowserSegueProtocol.h"

@interface BrowseStorysViewController : UIViewController

@property(weak) id<bowserSegueProtocol> delegate;

@end
