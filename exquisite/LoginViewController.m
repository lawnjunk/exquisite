
//
//  LoginViewController.m
//  exquisite
//
//  Created by Adam Wallraff on 2/25/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "LoginViewController.h"
#import "NetworkController.h"


@interface LoginViewController ()  <UITextFieldDelegate>
//@property (strong, nonatomic) IBOutlet UIButton *loginButton;
//@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
//
//@property (strong, nonatomic) IBOutlet UIButton *doneButton;
//@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
//
//@property (strong, nonatomic) IBOutlet UITextField *userNameField;
//@property (strong, nonatomic) IBOutlet UITextField *emailField;
//@property (strong, nonatomic) IBOutlet UITextField *passwordField;


@property (strong,nonatomic) UIButton *loginButton;
@property (strong,nonatomic) UIButton *signUpButton;

@property (strong,nonatomic ) UIButton *cancelButton;
@property (strong,nonatomic) UIButton *doneButton;

@property (strong,nonatomic) UITextField *usernameField;
@property (strong,nonatomic) UITextField *emailField;
@property (strong,nonatomic) UITextField *passwdFeild;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.usernameField.delegate = self;
    self.emailField.delegate = self;
    self.passwdFeild.delegate = self;
    
    
    self.loginButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 100, 25)];
    self.loginButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height * 0.3);
    self.loginButton.backgroundColor = [UIColor blackColor];
    [self.loginButton setTitle:@"lawgin" forState:UIControlStateNormal];
    self.loginButton.layer.borderWidth = 4;
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.layer.masksToBounds = true;
    [self.view addSubview:self.loginButton];
    [self.loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.signUpButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 100, 25)];
    self.signUpButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height * 0.6);
    self.signUpButton.backgroundColor = [UIColor blackColor];
    [self.signUpButton setTitle:@"psygn up" forState:UIControlStateNormal];
    self.signUpButton.layer.borderWidth = 4;
    self.signUpButton.layer.cornerRadius = 5;
    self.signUpButton.layer.masksToBounds = true;
    [self.view addSubview:self.signUpButton];
    [self.signUpButton addTarget:self action:@selector(signUpButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 100, 25)];
    self.cancelButton.center = CGPointMake(-100 , self.view.frame.size.height * 0.95);
    self.cancelButton.backgroundColor = [UIColor blackColor];
    [self.cancelButton setTitle:@"cawncle" forState:UIControlStateNormal];
    self.cancelButton.layer.borderWidth = 4;
    self.cancelButton.layer.cornerRadius = 5;
    self.cancelButton.layer.masksToBounds = true;
    [self.view addSubview:self.cancelButton];
    [self.cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.doneButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 100, 25)];
    self.doneButton.center = CGPointMake(self.view.frame.size.width + 100, self.view.frame.size.height * 0.95);
    self.doneButton.backgroundColor = [UIColor blackColor];
    [self.doneButton setTitle:@"dunsun" forState:UIControlStateNormal];
    self.doneButton.layer.borderWidth = 4;
    self.doneButton.layer.cornerRadius = 5;
    self.doneButton.layer.masksToBounds = true;
    [self.view addSubview:self.doneButton];
    [self.doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.usernameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.usernameField.center = CGPointMake(-100, self.view.frame.size.height * 0.3);
    self.usernameField.layer.borderWidth = 2;
    self.usernameField.borderStyle = UITextBorderStyleRoundedRect;
    self.usernameField.font = [UIFont systemFontOfSize:15];
    self.usernameField.placeholder = @"screen name";
    self.usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.usernameField.keyboardType = UIKeyboardTypeDefault;
    self.usernameField.returnKeyType = UIReturnKeyDone;
    self.usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.usernameField.delegate = self;
    [self.view addSubview:self.usernameField];
    
    self.emailField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.emailField.center = CGPointMake(-100, self.view.frame.size.height * 0.5);
    self.emailField.layer.borderWidth = 2;
    self.emailField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailField.font = [UIFont systemFontOfSize:15];
    self.emailField.placeholder = @"email";
    self.emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.emailField.keyboardType = UIKeyboardTypeDefault;
    self.emailField.returnKeyType = UIReturnKeyDone;
    self.emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.emailField.delegate = self;
    [self.view addSubview:self.emailField];
    
    self.passwdFeild = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.passwdFeild.center = CGPointMake(-100, self.view.frame.size.height * 0.7);
    self.passwdFeild.layer.borderWidth = 2;
    self.passwdFeild.borderStyle = UITextBorderStyleRoundedRect;
    self.passwdFeild.font = [UIFont systemFontOfSize:15];
    self.passwdFeild.placeholder = @"password";
    self.passwdFeild.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passwdFeild.keyboardType = UIKeyboardTypeDefault;
    self.passwdFeild.returnKeyType = UIReturnKeyDone;
    self.passwdFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwdFeild.delegate = self;
    [self.view addSubview:self.passwdFeild];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //    [userDefaults setObject:@"dug" forKey:@"username"];
    [userDefaults synchronize];
    NSString *defaultsUsername = [userDefaults objectForKey:@"username"];
    if (!defaultsUsername){
        NSLog(@"there was no username in userdfaults");
        
        [self performSegueWithIdentifier:@"SHOWSHWIPESHREDZ" sender:self];

    }

}



-(void)loginButtonPressed:(UIButton *)sender{
    NSLog(@"that there login button whaz pressed");
    [UIView animateWithDuration:0.3 animations:^{
        [self setloginAndsignInOffScreen];
        //            [self showUserNameField];
        [self showPasswordField];
        [self showEmailField];
        [self showDoneandCancel];
    }];
    
}



-(void)signUpButtonPressed:(UIButton *)sender{
    NSLog(@"that there signup button whaz pressed");
    [UIView animateWithDuration:0.3 animations:^{
        [self setloginAndsignInOffScreen];
        [self showUserNameField];
        [self showPasswordField];
        [self showEmailField];
        [self showDoneandCancel];
    }];
    
}


-(void)doneButtonPressed:(UIButton *)sender{
    NSLog(@"that there done button whaz pressed");
    [UIView animateWithDuration:0.3 animations:^{
        NSLog(@"screenname field: %@", self.usernameField.text );
        NSLog(@"email field: %@", self.emailField.text );
        NSLog(@"password field: %@", self.passwdFeild.text );
        
        
        
        if (![self.emailField.text isEqualToString:@""] &&![self.passwdFeild.text isEqualToString:@""]&&![self.usernameField.text isEqualToString:@""]) {
            [[NetworkController sharedService] createNewAccountWithUserName:self.usernameField.text password:self.passwdFeild.text email:self.emailField.text location:@"somewhere" withCompletionHandler:^(NSString *token, NSString *username) {
                NSLog(@"got a token from pressing a button %@", token);
                NSLog(@"got a username that is goled %@", username);
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:token forKey:@"token"];
                [userDefaults setObject:username forKey:@"username"];
                [userDefaults synchronize];
            }];

            [self performSegueWithIdentifier:@"SHOWSHWIPESHREDZ" sender:self];
        } else {
            NSLog(@"your fields werre empty fix plz");
        }
    }];
    
}


-(void)cancelButtonPressed:(UIButton *)sender{
    NSLog(@"that there cancel button whaz pressed");
    [UIView animateWithDuration:0.3 animations:^{
        [self hidetextField];
        [self hideDoneCancle];
        [self setloginAndsignInCenterScreen];
        [self clearAllFields];
        
    }];
    
}

-(void) clearAllFields {
    self.usernameField.text = @"";
    self.passwdFeild.text = @"";
    self.emailField.text =@"";
}


-(void) setloginAndsignInOffScreen {
    self.loginButton.center = CGPointMake(-100, self.loginButton.center.y);
    
    
    self.signUpButton.center = CGPointMake(self.view.frame.size.width + 100, self.signUpButton.center.y);
}

-(void) setloginAndsignInCenterScreen {
    self.loginButton.center = CGPointMake(self.view.frame.size.width/2, self.loginButton.center.y);
    self.signUpButton.center = CGPointMake(self.view.frame.size.width/2, self.signUpButton.center.y);
    ;
}


-(void) showUserNameField {
    self.usernameField.center = CGPointMake(self.view.frame.size.width/2, self.usernameField.center.y);
}

-(void) showPasswordField {
    self.passwdFeild.center = CGPointMake(self.view.frame.size.width/2, self.passwdFeild.center.y);
}


-(void) showEmailField {
    self.emailField.center = CGPointMake(self.view.frame.size.width/2, self.emailField.center.y);
}


-(void) showDoneandCancel {
    self.doneButton.center = CGPointMake(self.view.frame.size.width * 0.8, self.view.frame.size.height * 0.95);
    self.cancelButton.center = CGPointMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.95);
}

-(void) hidetextField {
    self.usernameField.center = CGPointMake(-100, self.view.frame.size.height * 0.3);
    self.emailField.center = CGPointMake(-100, self.view.frame.size.height * 0.5);
    self.passwdFeild.center = CGPointMake(-100, self.view.frame.size.height * 0.7);;
    
    
}


-(void) hideDoneCancle {
    self.doneButton.center = CGPointMake(self.view.frame.size.width + 100, self.view.frame.size.height * 0.95);
    self.cancelButton.center = CGPointMake(-100, self.view.frame.size.height * 0.95);
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.passwdFeild resignFirstResponder];
    [self.usernameField resignFirstResponder];
    [self.emailField resignFirstResponder];
    
    return true;
}



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



@end


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
