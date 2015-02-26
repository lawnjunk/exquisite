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
    _serverURLString = @"http://exquisite-prose.herokuapp.com";
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

-(void)createNewAccountWithUserName:(NSString *) username password:(NSString *)passwd email:(NSString *)email location:(NSString*) location {

    NSMutableDictionary *createUserPostBodyDict = [[NSMutableDictionary alloc] init];
    [createUserPostBodyDict setObject:username forKey:@"screenname"];
    [createUserPostBodyDict setObject:email forKey:@"email"];
    [createUserPostBodyDict setObject:location forKey:@"location"];
    [createUserPostBodyDict setObject:passwd forKey:@"password"];
    NSString *urlString = [NSString stringWithFormat:@"%@/user/create_user", self.serverURLString];
    NSURL *url = [[NSURL alloc] initWithString:urlString];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:createUserPostBodyDict options:0 error:&error];
    [request setHTTPBody:postData];
    [request addValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *createAccountDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"srry ther wes an errr creating user \n %@", error);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSInteger statusCode = httpResponse.statusCode;
            
            switch (statusCode) {
                case 200 ... 299: {
                    NSLog(@"statuscode for create user was %ld", (long)statusCode);
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:username forKey:@"username"];
                    break;
                }
                default:
                    break;
            }
        }
    }];
    [createAccountDataTask resume];
}


-(void)postSegment:(Segment *)segment{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSMutableDictionary *segmentPostBodyDict = [[NSMutableDictionary alloc]init];
    [segmentPostBodyDict setObject:segment.text forKey:@"postBody"];
    [segmentPostBodyDict setObject:[userDefaults stringForKey:@"username"] forKey:@"author"];
    [segmentPostBodyDict setObject:segment.storyName forKey:@"storyName"];
    [segmentPostBodyDict setObject: @"1" forKey:@"levelId"];
    [segmentPostBodyDict setObject:segment.storyId forKey:@"storyId"];
    
    NSString *urlString = @"http://exquisite-prose.herokuapp.com/segments/new_segment";
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    NSError *error;
    NSLog(@"%@", segmentPostBodyDict.description);
//    NSData *postSegmentData = [NSJSONSerialization dataWithJSONObject:segmentPostBodyDict options:0 error:&error];
    NSData *postSegmentData = [NSJSONSerialization dataWithJSONObject:segmentPostBodyDict options:0 error:&error];
    if (error){
        NSLog(@"there was n error parsing the postseg json %@", error.description);
    }

    
    [request setHTTPBody:postSegmentData];
    [request addValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *postSegmentDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        if (error) {
            NSLog(@"srry ther wes an errr posting segment \n %@", error.description);
            
        } else {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSInteger statusCode = httpResponse.statusCode;
                                NSLog(@"statuscode for post segment %ld", (long)statusCode);
            switch (statusCode) {
                case 200 ... 299: {

                    NSLog(@"happy resonse: %@", httpResponse);
                    break;
                }
                default:
                    break;
            }
        }
    }];
    
    [postSegmentDataTask resume];

}


-(void)fetchRandomStoryWithCompletionHandler: (void (^)(NSDictionary *results, NSString *error)) completionHandler {
  
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
  
  NSURLSessionTask *postCreateUserTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
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
  [postCreateUserTask resume];
}



-(void)fetchStoryWithIdentifier:(NSString * )storyID withCompletionHandler: (void (^)(NSDictionary *results, NSString *error)) completionHandler {

#warning the urlstring should be changed to storyid argument
    NSString *tempStoryId = @"54eec722cca1290300973582";
    NSString *urlString = [NSString stringWithFormat:@"%@/story/%@",self.serverURLString, tempStoryId];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *fetchStoryWithIdTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"this her did not print");
        if (error) {
            NSLog(@"eek sry madude ther was an error ...\n %@", error);
        } {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSInteger statusCode = httpResponse.statusCode;
            
            switch (statusCode) {
                case 200 ... 299: {
                    NSLog(@"fetch story with id status code was: %ld",(long)statusCode);
                    
                    NSError *parseError;
                    NSDictionary *storyDictionary = [ NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (storyDictionary) {
                            NSError *parseError;
                            completionHandler(storyDictionary,nil);
                        } else {
                            completionHandler(nil,@"Story could not be Serialized");
                        }
                    });

                    break;
                }
                default:
                    break;
            }
        }

    }];
    
            [fetchStoryWithIdTask resume];
//    NSMutableDictionary *createUserPostBodyDict = [[NSMutableDictionary alloc] init];
//    [createUserPostBodyDict setObject:username forKey:@"screenname"];
//    [createUserPostBodyDict setObject:email forKey:@"email"];
//    [createUserPostBodyDict setObject:location forKey:@"location"];
//    [createUserPostBodyDict setObject:passwd forKey:@"password"];
//    NSString *urlString = [NSString stringWithFormat:@"%@/user/create_user", self.serverURLString];
//    NSURL *url = [[NSURL alloc] initWithString:urlString];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    NSError *error;
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:createUserPostBodyDict options:0 error:&error];
//    [request setHTTPBody:postData];
//    [request addValue:@"application/json" forHTTPHeaderField:@"content-type"];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
    
    
//    // using json file for testing until we have working endpoints on the rest api
//    NSString *pathToJson = [[NSBundle mainBundle] pathForResource:@"PretendStory" ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:pathToJson];
//    NSError *parseError;
//    NSDictionary *storyDictionary = [ NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
//    if (parseError) {
//        NSLog(@"there was an error parsing the json story dictionary");
//    } else {
//        NSLog(@"story descriotion %@",storyDictionary.description);
//        //      Story *wat = [[Story alloc]  initWithJSONData:storyDictionary];
//        
//        completionHandler(storyDictionary, nil);
//    }
}

-(void)fetchTimelineForUser:(User *)currentUser withCompletionHandler:(void (^)(NSDictionary *results, NSString *error)) completionHandler {
  
  NSString *userName = currentUser.userName;
  

  NSString *urlString = [NSString stringWithFormat:@"%@/user/%@", self.serverURLString, @"phil"];
    NSLog(@"request string %@", urlString);
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
      NSLog(@"ERROR:%@", error.localizedDescription);
      completionHandler(nil,@"Could not connect");
    } else {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSInteger statusCode = httpResponse.statusCode;
      switch (statusCode) {
        case 200 ... 299: {
          NSLog(@"%ld",(long)statusCode);
          
          NSError *parseError;
          NSDictionary *storyDictionary = [ NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
          
#warning Temporary fix to a sudden endpoint change
          NSDictionary *tempDick = storyDictionary[@"user"];
          
          
          dispatch_async(dispatch_get_main_queue(), ^{
            if (tempDick) {
              completionHandler(tempDick,nil);
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
