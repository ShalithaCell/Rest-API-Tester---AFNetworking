//
//  ViewControllerMain.h
//  AFNetworking practice
//
//  Created by Shalitha Senanayaka on 2019-04-30.
//  Copyright © 2019 Shalitha Senanayaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewControllerMain : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtRestLink;
- (IBAction)btnCall:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITextView *txtResponseView;


@end

NS_ASSUME_NONNULL_END
