//
//  BRViewController.m
//  iBrainRing
//
//  Created by Sergey Dunets on 21.09.13.
//  Copyright (c) 2013 Sergey Dunets. All rights reserved.
//

#import "BRViewController.h"
#import <sys/time.h>

@interface BRViewController ()

@property (nonatomic, assign) struct timeval startTimeValue;
@property (nonatomic, assign) BOOL isGameRunning;
@property (nonatomic, retain) NSTimer *gameRandomLatencyTimer;

- (void)gameTimerFired:(id)aTimer;

@end


@implementation BRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.gameRandomLatencyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 + arc4random_uniform(2000) / 1000.0
                                                                   target:self
                                                                 selector:@selector(gameTimerFired:)
                                                                 userInfo:nil
                                                                  repeats:NO];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_infoLabel release];
    [super dealloc];
}

- (IBAction)buttonPressed:(id)sender
{
    if (self.isGameRunning)
    {
        struct timeval timeValueNow = {0, 0};
        gettimeofday(&timeValueNow, NULL);
        double timeDiff = (timeValueNow.tv_sec - self.startTimeValue.tv_sec) + 1e-6 * (timeValueNow.tv_usec - self.startTimeValue.tv_usec);
        
        self.view.backgroundColor = [UIColor greenColor];
        self.infoLabel.text = [NSString stringWithFormat:@"Time: %.3f s", timeDiff];
        NSLog(@"%f", timeDiff);
    }
    else
    {
        self.infoLabel.text = @"Falstart!";
        self.view.backgroundColor = [UIColor redColor];
        [self.gameRandomLatencyTimer invalidate];
        NSLog(@"Falstart");
    }
    
    self.gameRandomLatencyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 + arc4random_uniform(2000) / 1000.0
                                                                   target:self
                                                                 selector:@selector(gameTimerFired:)
                                                                 userInfo:nil
                                                                  repeats:NO];
    self.isGameRunning = NO;
}

- (void)gameTimerFired:(id)aTimer
{
    if (aTimer == self.gameRandomLatencyTimer)
    {
        self.infoLabel.text = @"Go!";
        self.view.backgroundColor = [UIColor blueColor];
        self.isGameRunning = YES;
        gettimeofday(&_startTimeValue, NULL);
    }
}

@end
