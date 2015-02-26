//
//  TimelineTableViewCell.h
//  exquisite
//
//  Created by Adam Wallraff on 2/25/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimelineTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *storyTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *storySegmentText;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end
