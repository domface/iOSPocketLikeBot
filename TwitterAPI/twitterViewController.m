//
//  twitterViewController.m
//  TwitterAPI
//
//  Created by Dominik Andrzejczuk on 6/30/14.
//  Copyright (c) 2014 Dominik Andrzejczuk. All rights reserved.
//

#import "twitterViewController.h"

@interface twitterViewController ()

@property (strong, nonatomic) IBOutlet UILabel *lblInfo;
@property (strong, nonatomic) NSTimer *myTimer;
@property (strong, nonatomic) IBOutlet UITextField *txtHashtag;

@end

@implementation twitterViewController

- (OAuth *)theRequest {
    if (!_theRequest) _theRequest = [[OAuth alloc] init];
    return _theRequest;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addHashTag:(UIButton *)sender {
    
    [self theRequest];
    [self.theRequest pictureArray];
    NSString *nextHashTag = _txtHashtag.text;
    [self.theRequest.pictureArray addObject:nextHashTag];
    self.arrayLabel.text = nextHashTag;
    
}


- (IBAction)requestButton:(UIButton *)sender {
    
    //[self.theRequest submitString:self.txtHashtag.text];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
                   ^{
                       
                       [self.theRequest request];
                   });

    [self startTimer];
}

- (void) startTimer
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                    target:self
                                                  selector:@selector(timerFired:)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void) stopTimer
{
    [self.myTimer invalidate];
}

- (void) timerFired:(NSTimer*)theTimer
{
    self.lblInfo.text = [NSString stringWithFormat:@"%lu", (unsigned long)[self.theRequest global]];
}
@end