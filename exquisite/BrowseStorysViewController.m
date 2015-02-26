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

@property(strong, nonatomic) NSArray *allStoryHeaders;

@end

@implementation BrowseStorysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.networkController = [NetworkController sharedService];
  
  [self.networkController fetchStoriesForBrowserWithCompletionHandler:^(NSArray *results, NSString *error) {
    NSLog(@"The New Fetch Worked");
    NSLog(@"Results For user timeline fetch: %@", results);
    
    NSMutableArray *storyHeaders = [[NSMutableArray alloc] init];
    for(NSDictionary *currentStoryHeader in results){
      NSDictionary *currentStorySegment = currentStoryHeader[@"firstSegment"];
      NSString *storyHeader = currentStorySegment[@"text"];
      [storyHeaders addObject:storyHeader];
    }
    self.allStoryHeaders = storyHeaders;
    [self.tableView reloadData];

  }];
  
  self.tableView.dataSource = self;
  
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 100;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: TableView DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
//  if(self.allStoryHeaders != nil){
//    NSString *currentStoryHeader = self.allStoryHeaders[indexPath.row];
//    cell.textLabel.text = currentStoryHeader;
//  }
  
  cell.storyTitle.text = @"Gnar";
  cell.storySegment.text = @"l;akjsd;lfkjkajhkjh ;lkjasdfpon lkjasl;dkjf;lkjasdf ;lkajsdf ;lkjasdf ;ljasdf;lkjweohwovkjn kf;jgp ovkngopwklh lkd ;lkasdk ;hwhfu";
  cell.dateLabel.text = @"2/15/15";
  
  
  
  return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
//  if (self.allStoryHeaders !=nil) {
//    return self.allStoryHeaders.count;
//  }
  
  return 25;
  
}

#pragma turn of the time/battery status bar
-(BOOL)prefersStatusBarHidden {
    return true;
}



@end
