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
//    NSLog(@"Results For user timeline fetch: %@", results);
    
    NSMutableArray *allStorySegments = [[NSMutableArray alloc] init];
    NSDictionary *userDictionary = results[@"user"];
    NSString *screenName = userDictionary[@"screenname"];
    NSString *location = userDictionary[@"location"];
    self.screenName.text = screenName;
    self.userName.text = screenName;
    self.locationLabel.text = location;
    
    NSArray *posts = results[@"segments"];
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

-(void)viewWillAppear:(BOOL)animated{
  for(UIView *view in self.tabBarController.view.subviews)
  {
    if([view isKindOfClass:[UITabBar class]])
    {
      view.hidden = true;
    }
  }
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self.tableView reloadData];
}

//MARK: TableView DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  TimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
  if(self.allPosts != nil){
    Segment *currentSegment = self.allPosts[indexPath.row];
    cell.storyTitleLabel.text = currentSegment.storyName;
    cell.storySegmentText.text = currentSegment.text;
    cell.dateLabel.text = currentSegment.createdAt;
  }
  [cell updateConstraintsIfNeeded];
  
  return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  if (self.allPosts == nil) {
    return 10;
  }
  return self.allPosts.count;
}

- (IBAction)writeButtonPressed:(UIButton *)sender {
  [self.delegate writeStoryButtonPushedinProfile];

}

#pragma turn of the time/battery status bar
-(BOOL)prefersStatusBarHidden {
    return true;
}

@end
