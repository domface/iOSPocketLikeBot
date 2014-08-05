//
//  twitterViewController.h
//  TwitterAPI
//
//  Created by Dominik Andrzejczuk on 6/30/14.
//  Copyright (c) 2014 Dominik Andrzejczuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models/OAuth.h"

@interface twitterViewController : UIViewController

@property (nonatomic, strong) OAuth *theRequest;
@property (nonatomic, weak) IBOutlet UIButton *pushButton;
@property (strong, nonatomic) IBOutlet UILabel *arrayLabel;



@end