//
//  BRBrainRingManager.m
//  BrainRingControl
//
//  Created by Sergey Dunets on 06.10.13.
//  Copyright (c) 2013 Sergey Dunets. All rights reserved.
//

#import "BRBrainRingManager.h"
#import <sys/time.h>

// Notifications
NSString * const kGameDidStop = @"kGameDidStop";
NSString * const kGameWillStartAfterDelay = @"kGameWillStartAfterDelay";
NSString * const kPlayerDidPressFalseStart = @"kPlayerDidPressFalseStart";
NSString * const kGameDidStart = @"kGameDidStart";
NSString * const kPlayerDidPressButton = @"kPlayerDidPressButton";
NSString * const kGameDidResumeAfterWrongAnswer = @"kGameDidResumeAfterWrongAnswer";

// Notification Info keys
NSString * const kPlayersKey = @"kPlayersKey";
NSString * const kDelayKey = @"kDelayKey";
NSString * const kPlayerKey = @"kPlayerKey";
NSString * const kPlayerTimeKey = @"kPlayerTimeKey";

const NSUInteger kMaxPlayersCount = 2;

const NSTimeInterval kFullTime = 60.;
const NSTimeInterval kTimeAfterWrongAnswer = 20.;


@interface BRBrainRingManager ()

@property (nonatomic, assign) BRGameState       gameState;
@property (nonatomic, retain) NSMutableArray    *allPlayers;
@property (nonatomic, retain) NSMutableArray    *playersInGame;
@property (nonatomic, assign) struct timeval    currentTimeVal;

@end


@implementation BRBrainRingManager

#pragma mark - Public

- (id)init
{
    if (self = [super init])
    {
        _allPlayers = [NSMutableArray new];
        _playersInGame = [NSMutableArray new];
        _gameState = kGameStateStopped;
    }
    
    return self;
}

- (void)dealloc
{
    [_allPlayers release];
    [_playersInGame release];
    
    [super dealloc];
}

#pragma mark - Managing players

- (BOOL)addPlayer:(NSString *)aPlayer
{
    BOOL result = NO;
    NSMutableArray *players = self.allPlayers;
    if (kMaxPlayersCount < players.count && ![players containsObject:aPlayer])
    {
        [players addObject:aPlayer];
        result = YES;
    }
    
    return result;
}

- (void)removePlayer:(NSString *)aPlayer
{
    [self.allPlayers removeObject:aPlayer];
}

#pragma mark - Automatic gameplay

- (BOOL)startGameInAutomaticModeError:(NSError **)anError
{
    if (anError)
    {
        *anError = nil;
    }
    
    BOOL result = self.allPlayers.count == 2;
    
    if (result && ![self startTimerForFullTime])
    {
        result = NO;
    }
    
    // ...
    
    return result;
}

- (void)player:(NSString *)aPlayer didPressButtonWithInternalTime:(NSTimeInterval)aTime internalGameState:(BRGameState)aState
{
    
}

- (void)player:(NSString *)aPLayer didAnswerCorrecly:(BOOL)aFlag
{
    
}

#pragma mark - Basic gameplay methods

- (BOOL)startTimerForFullTime
{
    BOOL result = YES;
    gettimeofday(&_currentTimeVal, NULL);
//    double timeDiff = (timeValueNow.tv_sec - self.startTimeValue.tv_sec) + 1e-6 * (timeValueNow.tv_usec - self.startTimeValue.tv_usec);
    return result;
}

- (BOOL)startTimerAfterWrongAnswer
{
    BOOL result = YES;
    return result;
}

- (void)forceStopGame
{
    
}

@end
