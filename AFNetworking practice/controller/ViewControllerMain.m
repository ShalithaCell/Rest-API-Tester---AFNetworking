//
//  ViewControllerMain.m
//  AFNetworking practice
//
//  Created by Shalitha Senanayaka on 2019-04-30.
//  Copyright © 2019 Shalitha Senanayaka. All rights reserved.
//

#import "ViewControllerMain.h"

@interface ViewControllerMain ()

@end

@implementation ViewControllerMain

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnCall:(UIButton *)sender {
    //keyboard dismiss
    [self.txtRestLink resignFirstResponder];
    
    NSString *restURL = [[NSString alloc]init];
    if(self.txtRestLink.text.length > 0)
        restURL = self.txtRestLink.text;
    else
        restURL = @"https://anapioficeandfire.com/api/characters/583";
    
    
    NSURL *URL = [NSURL URLWithString:restURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", @"audio/wav", @"application/octest-stream", nil];
    
    [manager GET:URL.absoluteString parameters:nil headers:nil progress:^(NSProgress * _Nonnull uploadProgress){
    
        [manager setDataTaskDidReceiveDataBlock:^(NSURLSession *session,
                                                  NSURLSessionDataTask *dataTask,
                                                  NSData *data)
         {
             if (dataTask.countOfBytesExpectedToReceive == NSURLSessionTransferSizeUnknown)
                 return;
             NSUInteger code = [(NSHTTPURLResponse *)dataTask.response statusCode];
             
             NSLog(@"status from server=%lu",(unsigned long)code);
             
             if (!(code> 199 && code < 400))
                 return;
             
             long long  bytesReceived = [dataTask countOfBytesReceived];
             long long  bytesTotal = [dataTask countOfBytesExpectedToReceive];
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 NSLog(@"show progress status :) ................");
                 NSLog(@"%@", [NSString stringWithFormat:
                               @"%f", (CGFloat)bytesReceived / bytesTotal]);
                 
             });
             
         }];
    }
         success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        
        self.txtResponseView.text = [NSString stringWithFormat:@"%@", responseObject];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.txtResponseView.text = [NSString stringWithFormat: @"%@", [error localizedDescription]];
    }];
    
    
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.txtRestLink resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.txtRestLink resignFirstResponder];
    
    return NO;
    
}

@end
