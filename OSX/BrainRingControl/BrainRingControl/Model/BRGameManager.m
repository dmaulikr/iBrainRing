//
//  BRGameManager.m
//  BrainRingControl
//
//  Created by Sergey Dunets on 06.10.13.
//  Copyright (c) 2013 Sergey Dunets. All rights reserved.
//

#import "BRGameManager.h"


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


@interface BRGameManager ()

@property (nonatomic, retain) NSArray           *timeIntervals;
@property (nonatomic, retain) NSMutableArray    *players;
@property (nonatomic, assign) NSInteger         maxPlayersCount;

@property (nonatomic, assign) BRGameState       gameState;
@property (nonatomic, assign) BOOL              shouldProcessFalseStart;

@end


@implementation BRGameManager

/// Designated initializer
- (id)initWithTimeIntervals:(NSArray *)aTimeIntervals maxPlayersCount:(NSInteger)aCount
{
    if (self = [super init])
    {
        _timeIntervals = [aTimeIntervals retain];
        _maxPlayersCount = aCount;
    }
    
    return self;
}

- (void)dealloc
{
    [_timeIntervals release];
    [_players release];
    [super dealloc];
}

- (BOOL)addPlayer:(NSString *)aPlayer
{
    BOOL result = NO;
    NSMutableArray *players = self.players;
    if (self.maxPlayersCount < players.count && ![players containsObject:aPlayer])
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

- (void)startTimerAtIndex:(NSUInteger)anIndex withMinDelay:(NSTimeInterval)aMinDelay maxDelay:(NSTimeInterval)aMaxDelay
{
    assert(aMinDelay <= aMaxDelay);
    if (aMinDelay <= aMaxDelay)
    {
        
    }
}
/*
- (BOOL)startNextTimer;
- (BOOL)pauseTimerAtIndex:(NSUInteger)anIndex;
- (BOOL)resumeTimerAtIndex:(NSUInteger)anIndex;
- (BOOL)resetTimerAtIndex:(NSUInteger)anIndex;
*/
- (void)player:(NSString *)aPlayer didPressButtonWithInternalTime:(NSTimeInterval)aTime internalGameState:(BRGameState)aState
{
    [self doesNotRecognizeSelector:_cmd];
}

@end
