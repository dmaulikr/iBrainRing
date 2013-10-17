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
NSString * const kTimerWillStart = @"kTimerWillStart";
NSString * const kTimerDidStart = @"kTimerDidStart";
NSString * const kTimerDidStop = @"kTimerDidStop";
NSString * const kGameDidReset = @"kGameDidReset";
NSString * const kPlayerDidPressButton = @"kPlayerDidPressButton";
NSString * const kShouldProcessFalseStartDidChange = @"kShouldProcessFalseStartDidChange";

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

- (void)startTimerForFullTime
{
    gettimeofday(&_currentTimeVal, NULL);
//    double timeDiff = (timeValueNow.tv_sec - self.startTimeValue.tv_sec) + 1e-6 * (timeValueNow.tv_usec - self.startTimeValue.tv_usec);

}

/// @brief Starts timer for 20 s without a delay.
- (void)startTimerAfterWrongAnswer
{
    
}

/// @brief Force stop the game, e.g. in the case of a referee did something wrong.
- (void)forceStopGame
{
    
}

/// @brief Call this method when the user presses a game button in the client app.
/// @param[in] aPlayer Unique player name.
/// @param[in] aTime Time measured on a device.
/// @param[in] aState Game state on a device.
- (void)player:(NSString *)aPlayer didPressButtonWithInternalTime:(NSTimeInterval)aTime internalGameState:(BRGameState)aState
{
    
}




@end
