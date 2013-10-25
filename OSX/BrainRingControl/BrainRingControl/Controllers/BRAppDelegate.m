//
//  BRAppDelegate.m
//  BrainRingControl
//
//  Created by Sergey Dunets on 27.09.13.
//  Copyright (c) 2013 Sergey Dunets. All rights reserved.
//

#import "BRAppDelegate.h"
#import "BRBrainRingManager.h"

@interface BRAppDelegate ()

@property (retain, nonatomic) BRBrainRingManager *brManager;
@property (retain, nonatomic) NSString *currentPlayer;

@end

@implementation BRAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.brManager = [[BRBrainRingManager new] autorelease];
    [self.brManager addPlayer:@"Player 1"];
    [self.brManager addPlayer:@"Player 2"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(somethingDidHappen:)
                                                 name:nil
                                               object:self.brManager];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)somethingDidHappen:(NSNotification *)aNotification
{
    NSLog(@"%@ %@", [aNotification name], [aNotification userInfo]);
}

- (IBAction)startTimer:(id)sender
{
    if (self.brManager.gameState == kGameStateStopped)
    {
        [self.brManager startTimerForFullTimeAfterRandomDelay];
    }
    else if (self.brManager.gameState == kGameStatePaused || self.brManager.gameState == kGameStateFalseStart)
    {
        [self.brManager startTimerForShortTime];
    }
}

- (IBAction)stopGameDidPress:(id)sender
{
    [self.brManager resetGame];
}

- (IBAction)player1DidPress:(id)sender
{
    self.currentPlayer = [sender title];
    [self.brManager player:self.currentPlayer didPressButtonWithInternalTime:1.0 internalGameState:self.brManager.gameState];
}

- (IBAction)player2DidPress:(id)sender
{
    self.currentPlayer = [sender title];
    [self.brManager player:self.currentPlayer didPressButtonWithInternalTime:0.9 internalGameState:self.brManager.gameState];
}

- (IBAction)correctAnswerDidPress:(id)sender
{
    [self.brManager player:self.currentPlayer didAnswerCorrecly:YES];
}

- (IBAction)incorrectAnswerDidPress:(id)sender
{
    [self.brManager player:self.currentPlayer didAnswerCorrecly:NO];
}

@end
