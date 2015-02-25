//
//  BrowseStorysViewController.m
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "BrowseStorysViewController.h"
#import "NetworkController.h"

@interface BrowseStorysViewController ()<UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) NetworkController *networkController;

@end

@implementation BrowseStorysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.networkController = [NetworkController sharedService];
  
  [self.networkController fetchCompletedStoriesWithCompletionHandler:^(NSArray *results, NSString *error) {
    NSLog(@"The New Fetch Worked");
    NSLog(@"Results For user timeline fetch: %@", results);
  }];
  
  self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: TableView DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return 1;
}

#pragma turn of the time/battery status bar
-(BOOL)prefersStatusBarHidden {
    return true;
}



@end
