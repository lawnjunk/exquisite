//
//  TimeLineViewController.m
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//
#import "FXBlurView.h"
#import "TimeLineViewController.h"

@interface TimeLineViewController ()<UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *header;
@property (strong, nonatomic) IBOutlet UILabel *headerUsername;

//@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

//@property(strong, nonatomic) IBOutlet UIImageView *headerImageView;
//@property(strong, nonatomic) IBOutlet UIImageView *headerBlurImageView;
//@property(nonatomic) CGFloat offSetHeaderStop;
//@property(nonatomic) CGFloat offsetBLabelHeader;
//@property(nonatomic) CGFloat distanceWLabelHeader;

@end

@implementation TimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.tableView.dataSource = self;
  
  self.avatarImage.backgroundColor = [UIColor blackColor];
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  //SETUP AVATAR IMAGE:
  self.avatarImage.layer.cornerRadius = 45.0;
  self.avatarImage.layer.borderWidth = 5.0;
  self.avatarImage.layer.borderColor = [[UIColor darkGrayColor]CGColor];
  
//  self.offSetHeaderStop = 40.0;
//  self.offsetBLabelHeader = 95.0;
//  self.distanceWLabelHeader = 35.0;
  
//  self.headerImageView = [[UIImageView alloc] initWithFrame:self.header.bounds];
//#warning image name needed
//  self.headerImageView.image = [UIImage imageNamed:@""];
//  self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
//  
//  [self.header insertSubview:self.headerImageView belowSubview:self.headerUsername];
//  
//  //Header - Blurred Image
//  self.headerBlurImageView = [[UIImageView alloc] initWithFrame:self.header.bounds];
//#warning image name needed
//  self.headerBlurImageView.image = [UIImage imageNamed:@""];
//  [self.headerBlurImageView.image blurredImageWithRadius:10 iterations:20 tintColor:[UIColor clearColor]];
//  self.headerBlurImageView.contentMode = UIViewContentModeScaleAspectFill;
//  self.headerBlurImageView.alpha =0.0;
//  [self.header insertSubview:self.headerBlurImageView belowSubview:self.headerUsername];
//  self.header.clipsToBounds = true;
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//  
//  CGFloat offSet = self.scrollView.contentOffset.y;
//  CATransform3D avatarTransform = CATransform3DIdentity;
//  CATransform3D headerTransform = CATransform3DIdentity;
//  CATransform3D labelTransform = CATransform3DIdentity;
//
//
//  //PULL DOWN:
//  if (offSet < 0) {
//    CGFloat headerHeight = self.header.bounds.size.height;
//    
//    CGFloat headerScaleFactor = -(offSet) / headerHeight;
//    CGFloat headerSizeVariation = ((headerHeight * (1.0 + headerScaleFactor)) - headerHeight)/2.0;
//    
//    headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizeVariation, 0);
//    headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0);
//    self.header.layer.transform = headerTransform;
//  }
//  //SCROLL UP/DOWN:
//  else{
//    headerTransform = CATransform3DTranslate(headerTransform, 0, MAX(-self.offSetHeaderStop, -offSet), 0);
//    
//    //Label Transform
//    labelTransform = CATransform3DMakeTranslation(0, MAX(-self.distanceWLabelHeader, self.offsetBLabelHeader), 0);
//    self.headerUsername.layer.transform = labelTransform;
//    
//    //Blur
//    self.headerBlurImageView.alpha = MIN(1.0, (offSet - self.offsetBLabelHeader)/self.distanceWLabelHeader);
//    
//    //User Image
//    CGFloat avatarImageHeight = self.avatarImage.bounds.size.height;
//    CGFloat avatarScaleFactor = (MIN(self.offSetHeaderStop, offSet))/ avatarImageHeight / 1.4;
//    CGFloat avatarSizeVariation = ((avatarImageHeight * (1.0 + avatarScaleFactor)) - avatarImageHeight) / 2.0;
//    
//    avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0);
//    avatarTransform = CATransform3DScale(avatarTransform, 1.0-avatarScaleFactor, 1.0-avatarScaleFactor, 0);
//    
//    if (offSet <= self.offSetHeaderStop) {
//      if (self.avatarImage.layer.zPosition < self.header.layer.zPosition) {
//        self.header.layer.zPosition = 0;
//      }
//    }
//    else{
//      if (self.avatarImage.layer.zPosition >= self.header.layer.zPosition) {
//        self.header.layer.zPosition = 2;
//      }
//    }
//  }
//  
//  self.header.layer.transform = headerTransform;
//  self.avatarImage.layer.transform = avatarTransform;
//  
//}

//var offset = scrollView.contentOffset.y
//var avatarTransform = CATransform3DIdentity
//var headerTransform = CATransform3DIdentity
//// PULL DOWN -----------------
//if offset < 0 {
//  let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
//  let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
//  headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
//  headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
//  header.layer.transform = headerTransform
//}
//// SCROLL UP/DOWN ------------
//else {
//  // Header -----------
//  headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
//  //  ------------ Label
//  let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0)
//  headerLabel.layer.transform = labelTransform
//  //  ------------ Blur
//  headerBlurImageView?.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
//  // Avatar -----------
//  let avatarScaleFactor = (min(offset_HeaderStop, offset)) / avatarImage.bounds.height / 1.4 // Slow down the animation
//  let avatarSizeVariation = ((avatarImage.bounds.height * (1.0 + avatarScaleFactor)) - avatarImage.bounds.height) / 2.0
//  avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
//  avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
//  
//  if offset <= offset_HeaderStop {
//    if avatarImage.layer.zPosition < header.layer.zPosition{
//      header.layer.zPosition = 0
//    }
//  }else {
//    if avatarImage.layer.zPosition >= header.layer.zPosition{
//      header.layer.zPosition = 2
//    }
//  }
//}
//
//// Apply Transformations
//header.layer.transform = headerTransform
//avatarImage.layer.transform = avatarTransform

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
