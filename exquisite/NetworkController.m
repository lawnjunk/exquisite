//
//  NetworkController.m
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "NetworkController.h"
#import "Story.h"

@interface NetworkController()

@property(strong,nonatomic) NSString *serverURLString;

@end

@implementation NetworkController


-(NSString *)serverURLString{
  if (!_serverURLString) {
    _serverURLString = @"10.97.110.240:3000";
  }
  return _serverURLString;
}

+(id)sharedService {
    static NetworkController *theSharedService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theSharedService = [[NetworkController alloc] init];
    });
    return theSharedService;
}

//-(void)requestAceessToken{
//#warning we need this url to make the real request.
// NSString *url = @"";
//}

//-(void) handleCallBackURL:(NSURL *)url {
//  
//  NSString *code = url.query;
//  
//  //This is one way you can pass back info in a POST, via passing items as parameters in the URL
//  
////  NSURL *oauthURL = "https://github.com/login/oauth/access_token?\(code!)&client_id=\(self.clientID)&client_secret=\(self.clientSecret)";
//  NSString *oauthURL = @"https://github.com/login/oauth/access_token?\(code!)&client_id=\(self.clientID)&client_secret=\(self.clientSecret)";
//
//  NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:oauthURL]];
//  postRequest.HTTPMethod = @"POST";
//  
//}

-(void)createNewAccountWithUserName:(NSString *) username password:(NSString *)passwd{
  
  NSString *urlString = [NSString stringWithFormat:@"%@/user/%@", self.serverURLString, username];
  
  NSURL *url = [[NSURL alloc] initWithString:urlString];

  NSURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  
    NSLog(@"i made a fake token");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = @"thisTokenIsATempForTest";
    [userDefaults setObject:token forKey:@"token"];
    [userDefaults synchronize];
}


-(void)fetchStoryWithCompletionHandler: (void (^)(NSDictionary *results, NSString *error)) completionHandler {
  
  NSString *urlString = [NSString stringWithFormat:@"%@/story/", self.serverURLString];
  
//  urlString = [urlString stringByAppendingString:@"search?order=desc&sort=activity&site=stackoverflow&intitle="];
//  urlString = [urlString stringByAppendingString:searchTerm];
//  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//  NSString *token = [defaults objectForKey:@"token"];
//  if (token) {
//    urlString = [urlString stringByAppendingString:@"&access_token="];
//    urlString = [urlString stringByAppendingString:token];
//    urlString = [urlString stringByAppendingString:@"&key=5Vpg3uTqCwAssGUjZx73wg(("];
//  }
  
  NSURL *url = [NSURL URLWithString:urlString];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  request.HTTPMethod = @"GET";
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"THERE WAS AN ERROR WITH THE DATA TASK");
      completionHandler(nil,@"Could not connect");
    } else {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSInteger statusCode = httpResponse.statusCode;
      switch (statusCode) {
        case 200 ... 299: {
          NSLog(@"%ld",(long)statusCode);
          
          NSError *parseError;
          NSDictionary *storyDictionary = [ NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
          
          dispatch_async(dispatch_get_main_queue(), ^{
            if (storyDictionary) {
              completionHandler(storyDictionary,nil);
            } else {
              completionHandler(nil,@"Story could not be Serialized");
            }
          });
          break;
        }
        default:
          NSLog(@"%ld",(long)statusCode);
          break;
      }
      
    }
  }];
  [dataTask resume];
}


-(void)fetchTimelineForUser:(User *)currentUser withCompletionHandler:(void (^)(NSDictionary *results, NSString *error)) completionHandler {
  
  NSString *userName = currentUser.userName;
  
  NSString *urlString = [NSString stringWithFormat:@"%@/user/%@", self.serverURLString, userName];
  
  //  urlString = [urlString stringByAppendingString:@"search?order=desc&sort=activity&site=stackoverflow&intitle="];
  //  urlString = [urlString stringByAppendingString:searchTerm];
  //  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  //  NSString *token = [defaults objectForKey:@"token"];
  //  if (token) {
  //    urlString = [urlString stringByAppendingString:@"&access_token="];
  //    urlString = [urlString stringByAppendingString:token];
  //    urlString = [urlString stringByAppendingString:@"&key=5Vpg3uTqCwAssGUjZx73wg(("];
  //  }
  
  NSURL *url = [NSURL URLWithString:urlString];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  request.HTTPMethod = @"GET";
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"THERE WAS AN ERROR WITH THE DATA TASK");
      completionHandler(nil,@"Could not connect");
    } else {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSInteger statusCode = httpResponse.statusCode;
      switch (statusCode) {
        case 200 ... 299: {
          NSLog(@"%ld",(long)statusCode);
          
          NSError *parseError;
          NSDictionary *storyDictionary = [ NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
          
          dispatch_async(dispatch_get_main_queue(), ^{
            if (storyDictionary) {
              completionHandler(storyDictionary,nil);
            } else {
              completionHandler(nil,@"Story could not be Serialized");
            }
          });
          break;
        }
        default:
          NSLog(@"%ld",(long)statusCode);
          break;
      }
      
    }
  }];
  [dataTask resume];
}

-(void)fetchStoriesForBrowserWithCompletionHandler: (void (^)(NSArray *results, NSString *error)) completionHandler {
  
  NSString *urlString = [NSString stringWithFormat:@"%@/story/", self.serverURLString];
  
  //  urlString = [urlString stringByAppendingString:@"search?order=desc&sort=activity&site=stackoverflow&intitle="];
  //  urlString = [urlString stringByAppendingString:searchTerm];
  //  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  //  NSString *token = [defaults objectForKey:@"token"];
  //  if (token) {
  //    urlString = [urlString stringByAppendingString:@"&access_token="];
  //    urlString = [urlString stringByAppendingString:token];
  //    urlString = [urlString stringByAppendingString:@"&key=5Vpg3uTqCwAssGUjZx73wg(("];
  //  }
  
  NSURL *url = [NSURL URLWithString:urlString];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  request.HTTPMethod = @"GET";
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"THERE WAS AN ERROR WITH THE DATA TASK");
      completionHandler(nil,@"Could not connect");
    } else {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSInteger statusCode = httpResponse.statusCode;
      switch (statusCode) {
        case 200 ... 299: {
          NSLog(@"%ld",(long)statusCode);
          
          NSError *parseError;
          NSDictionary *storyDictionary = [ NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
          
          dispatch_async(dispatch_get_main_queue(), ^{
            if (storyDictionary) {
              completionHandler(storyDictionary,nil);
            } else {
              completionHandler(nil,@"Story could not be Serialized");
            }
          });
          break;
        }
        default:
          NSLog(@"%ld",(long)statusCode);
          break;
      }
      
    }
  }];
  [dataTask resume];
  
}

@end
