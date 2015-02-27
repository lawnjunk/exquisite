//
//  BrowseStorysViewController.m
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "BrowseStorysViewController.h"
#import "StoryTableViewCell.h"
#import "NetworkController.h"
#import "Story.h"

@interface BrowseStorysViewController ()<UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) NetworkController *networkController;

@property(strong, nonatomic) NSArray *allStorys;

@end

@implementation BrowseStorysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.networkController = [NetworkController sharedService];
  
  [self.networkController fetchStoriesForBrowserWithCompletionHandler:^(NSArray *results, NSString *error) {
    NSLog(@"The New Fetch Worked");
    NSLog(@"Results For story browser fetch: %@", results);
    
    NSMutableArray *allStorySegments = [[NSMutableArray alloc] init];
    
    for(NSDictionary *storyDictionary in results){
      [allStorySegments addObject:storyDictionary];
    }
    
    self.allStorys = allStorySegments;
    
    [self.tableView reloadData];

  }];
  
  self.tableView.dataSource = self;
  
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 100;
    // Do any additional setup after loading the view.
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

//MARK: TableView DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
  if(self.allStorys != nil){
    NSDictionary *currentStory = self.allStorys[indexPath.row];
    cell.storySegment.text = currentStory[@"author"];
    cell.storyTitle.text = currentStory[@"name"];
    
    cell.dateLabel.text = currentStory[@"createdAt"];

  }

  return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  if (self.allStorys !=nil) {
    return self.allStorys.count;
  }
  
  return 5;
  
}
- (IBAction)writeStoryButtonPushed:(UIButton *)sender {
  [self.delegate writeStoryButtonPushed];
}

#pragma turn of the time/battery status bar
-(BOOL)prefersStatusBarHidden {
    return true;
}



@end
