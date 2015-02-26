//
//  TimeLineViewController.m
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "TimeLineViewController.h"
#import "TimelineTableViewCell.h"
#import "NetworkController.h"
#import "Segment.h"

@interface TimeLineViewController ()<UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *header;
@property (strong, nonatomic) IBOutlet UILabel *screenName;
@property (strong, nonatomic) IBOutlet UILabel *numberOfSegments;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;


//@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) NetworkController *networkController;

@property(strong, nonatomic) NSArray *allPosts;

@end

@implementation TimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.tableView.dataSource = self;
  
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 100;
  
  self.networkController = [NetworkController sharedService];
  
  [self.networkController fetchTimelineForUser:self.currentUser withCompletionHandler:^(NSDictionary *results, NSString *error) {
    NSLog(@"The New Fetch Worked");
    NSLog(@"Results For user timeline fetch: %@", results);
    
    NSMutableArray *allStorySegments = [[NSMutableArray alloc] init];
    NSString *screenName = results[@"screenname"];
    NSString *location = results[@"location"];
    self.screenName.text = screenName;
    self.userName.text = screenName;
    self.locationLabel.text = location;
    
    NSArray *posts = results[@"posts"];
    for(NSDictionary *currentSegmentDictionary in posts){
      Segment *seg = [[Segment alloc] initWithDictionary:currentSegmentDictionary];
      [allStorySegments addObject:seg];
    }

    self.allPosts = allStorySegments;
    self.numberOfSegments.text = [NSString stringWithFormat:@"%lu Contributions", (unsigned long)self.allPosts.count];
    NSLog(@"%lu", (unsigned long)self.allPosts.count);
    [self.tableView reloadData];
  }];
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];

}



//MARK: TableView DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  TimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
//  if(self.allPosts != nil){
//    
//    Segment *currentSegment = self.allPosts[indexPath.row];
//    cell.storySegmentText.text = currentSegment.text;
//    NSLog(@"%@",currentSegment.text);
//  }
//  else{
  
    //this is just for test reasons
  
    cell.storyTitleLabel.text = @"Never Again";
    cell.storySegmentText.text = @"this is just a test to see haosidjlkhadghfakjhsdflkjhweopihjasdf;lkhj lkajsdf;ljk ;lkajsd;flkj ;lkajsdf;lkjasd ;lkajsdf;lkj ";
    cell.dateLabel.text = @"2/15/14";
  
  [cell updateConstraintsIfNeeded];
//  }
  
  return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  if (self.allPosts == nil) {
    return 10;
  }
  return 10;
}


#pragma turn of the time/battery status bar
-(BOOL)prefersStatusBarHidden {
    return true;
}

@end
