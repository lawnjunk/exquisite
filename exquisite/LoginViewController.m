


////
////  LoginViewController.m
////  exquisite
////
////  Created by Adam Wallraff on 2/25/15.
////  Copyright (c) 2015 nacnud. All rights reserved.
////
//
//#import "LoginViewController.h"
//
//@interface LoginViewController ()
//@property (strong, nonatomic) IBOutlet UIButton *loginButton;
//@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
//
//@property (strong, nonatomic) IBOutlet UIButton *doneButton;
//@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
//
//@property (strong, nonatomic) IBOutlet UITextField *userNameField;
//@property (strong, nonatomic) IBOutlet UITextField *emailField;
//@property (strong, nonatomic) IBOutlet UITextField *passwordField;
//
//@property(nonatomic) CGPoint loginCenter;
//@property(nonatomic) CGPoint signUpCenter;
//
//@property(nonatomic) CGPoint userNameOffScreenCenterLocation;
//@property(nonatomic) CGPoint passwordOffScreenCenterLocation;
//@property(nonatomic) CGPoint emailOffScreenCenterLocation;
//
//@end
//
//@implementation LoginViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//  
//  self.cancelButton.enabled = false;
//  self.cancelButton.alpha = 0.0;
//  self.doneButton.enabled = false;
//  self.doneButton.alpha = 0.0;
//  
//  self.userNameField.enabled = false;
//  self.userNameField.hidden = true;
//  self.emailField.enabled = false;
//  self.emailField.hidden = true;
//  self.passwordField.enabled = false;
//  self.passwordField.hidden = true;
//  
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//  
//}
//
//- (IBAction)loginButtonPressed:(UIButton *)sender {
//  [UIView animateWithDuration:0.5 animations:^{
//
//    [self startInitialAnimation];
//    
//  } completion:^(BOOL finished) {
//    //Completed Animation
//  }];
//}
//
//- (IBAction)signUpButtonPressed:(UIButton *)sender {
//  [UIView animateWithDuration:0.5 animations:^{
//
//    [self startInitialAnimation];
//    
//  } completion:^(BOOL finished) {
//    //Completed Animation
//  }];
//}
//- (IBAction)cancelButtonPressed:(UIButton *)sender {
//  [UIView animateWithDuration:0.5 animations:^{
//
//    [self animateBackToOrginal];
//
//    
//  } completion:^(BOOL finished) {
//    //Completed Animation
//    NSLog(@"%f , %f",self.userNameField.center.x, self.userNameField.center.y);
//    NSLog(@"%f , %f",self.emailField.center.x, self.emailField.center.y);
//    NSLog(@"%f , %f",self.passwordField.center.x, self.passwordField.center.y);
//    
//    self.userNameField.hidden = true;
//    self.emailField.hidden = true;
//    self.passwordField.hidden = true;
//  }];
//}
//- (IBAction)doneButtonPressed:(UIButton *)sender {
//  [UIView animateWithDuration:0.5 animations:^{
//
//    [self animateBackToOrginal];
//    
//  } completion:^(BOOL finished) {
//    //Completed Animation
//    self.userNameField.hidden = true;
//    self.emailField.hidden = true;
//    self.passwordField.hidden = true;
//  }];
//}
//
//-(void)startInitialAnimation{
//  self.cancelButton.enabled = true;
//  self.cancelButton.alpha = 1.0;
//  self.doneButton.enabled = true;
//  self.doneButton.alpha = 1.0;
//  
//  self.userNameField.enabled = true;
//  self.emailField.enabled = true;
//  self.passwordField.enabled = true;
//  
//  self.userNameField.hidden = false;
//  self.emailField.hidden = false;
//  self.passwordField.hidden = false;
//  
//  self.loginButton.center = CGPointMake(-500, self.loginButton.center.y);
//  self.signUpButton.center = CGPointMake(500, self.signUpButton.center.y);
//  
//  self.userNameField.center = CGPointMake(self.view.frame.size.width/2, self.userNameField.center.y);
//  self.emailField.center = CGPointMake(self.view.frame.size.width/2, self.emailField.center.y);
//  self.passwordField.center = CGPointMake(self.view.frame.size.width/2, self.passwordField.center.y);
//}
//
//-(void)animateBackToOrginal{
//  self.cancelButton.enabled = false;
//  self.cancelButton.alpha = 0.0;
//  self.doneButton.enabled = false;
//  self.doneButton.alpha = 0.0;
//  
//  self.userNameField.enabled = false;
//  self.emailField.enabled = false;
//  self.passwordField.enabled = false;
//
//  self.loginButton.center = CGPointMake(self.view.frame.size.width/2, self.loginButton.center.y);
//  self.signUpButton.center = CGPointMake(self.view.frame.size.width/2, self.signUpButton.center.y);
//  
//  self.userNameField.center = CGPointMake(-300, self.userNameField.center.y);
//  self.emailField.center = CGPointMake(700, self.emailField.center.y);
//  self.passwordField.center = CGPointMake(-300, self.passwordField.center.y);
//
//  
//}
//
//
//
//@end
