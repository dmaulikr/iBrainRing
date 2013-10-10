//
//  BRBrainRingManager.m
//  BrainRingControl
//
//  Created by Sergey Dunets on 06.10.13.
//  Copyright (c) 2013 Sergey Dunets. All rights reserved.
//

#import "BRBrainRingManager.h"
#import <sys/time.h>

/// Notifications
NSString * const kTimerWillStart = @"kTimerWillStart";
NSString * const kTimerDidStart = @"kTimerDidStart";
NSString * const kTimerDidStop = @"kTimerDidStop";
NSString * const kGameDidReset = @"kGameDidReset";
NSString * const kPlayerDidPressButton = @"kPlayerDidPressButton";
NSString * const kShouldProcessFalseStartDidChange = @"kShouldProcessFalseStartDidChange";

/// Notification Info keys
NSString * const kPlayerKey = @"kPlayerKey";
NSString * const kPlayerTimeKey = @"kPlayerTimeKey";

const NSUInteger kMaxPlayersCount = 2;

const NSTimeInterval kFullTime = 60.;
const NSTimeInterval kTimeAfterWrongAnswer = 20.;


@interface BRBrainRingManager ()

@property (nonatomic, assign) BRGameState       gameState;
@property (nonatomic, retain) NSMutableArray    *players;
@property (nonatomic, assign) BOOL              shouldProcessFalseStart;
@property (nonatomic, assign) struct timeval    currentTimeVal;

@end

@implementation BRBrainRingManager

- (BOOL)addPlayer:(NSString *)aPlayer
{
    BOOL result = NO;
    NSMutableArray *players = self.players;
    if (kMaxPlayersCount < players.count && ![players containsObject:aPlayer])
    {
        [players addObject:aPlayer];
        result = YES;
    }
    
    return result;
}

- (void)removePlayer:(NSString *)aPlayer
{
    [self.players removeObject:aPlayer];
}

- (void)startTimerForBothTeams
{
    gettimeofday(&_currentTimeVal, NULL);
    double timeDiff = (timeValueNow.tv_sec - self.startTimeValue.tv_sec) + 1e-6 * (timeValueNow.tv_usec - self.startTimeValue.tv_usec);

}

@end
