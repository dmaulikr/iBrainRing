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
NSString * const kGameDidStartFullTime = @"kGameDidStart";
NSString * const kPlayerDidPressButton = @"kPlayerDidPressButton";
NSString * const kGameDidStartShortTime = @"kGameDidResumeAfterWrongAnswer";

// Notification Info keys
NSString * const kPlayersKey = @"kPlayersKey";
NSString * const kDelayKey = @"kDelayKey";
NSString * const kPlayerKey = @"kPlayerKey";
NSString * const kPlayerTimeKey = @"kPlayerTimeKey";

const NSUInteger kMaxPlayersCount = 2;

const NSTimeInterval kFullTime = 60.0;
const NSTimeInterval kShortTime = 20.0;


@interface BRBrainRingManager ()

@property (nonatomic, assign) BRGameState       gameState;
@property (nonatomic, retain) NSMutableArray    *allPlayers;
@property (nonatomic, retain) NSMutableArray    *playersInGame;
@property (nonatomic, assign) struct timeval    currentTimeVal;
@property (nonatomic, retain) NSTimer           *gameTimer;

- (void)randomDelayTimerFired:(NSTimer *)aTimer;
- (void)fullTimeTimerFired:(NSTimer *)aTimer;
- (void)shortTimerFired:(NSTimer *)aTimer;
- (BOOL)startTimerForFullTime;
- (void)stopGame;

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
        gettimeofday(&_currentTimeVal, NULL);
    }
    
    return self;
}

- (void)dealloc
{
    [_gameTimer invalidate];
    [_gameTimer release];
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
    [self.playersInGame removeObject:aPlayer];
}

#pragma mark - Gameplay

- (void)player:(NSString *)aPlayer didPressButtonWithInternalTime:(NSTimeInterval)aTime internalGameState:(BRGameState)aState
{
    switch (aState)
    {
        case kGameStateStopped:
        case kGameStateDelayedBeforeTimerStart:
        {
            self.gameState = kGameStateFalseStart;
            [self.gameTimer invalidate];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kPlayerDidPressFalseStart
                                                                object:self
                                                              userInfo:@{kPlayerKey:aPlayer, kPlayerTimeKey:@(aTime)}];
            break;
        }
        case kGameStateTimerCountsFullTime:
        case kGameStateTimerCountsShortTime:
        {
            self.gameState = kGameStatePaused;
            [[NSNotificationCenter defaultCenter] postNotificationName:kPlayerDidPressButton
                                                                object:self
                                                              userInfo:@{kPlayerKey:aPlayer, kPlayerTimeKey:@(aTime)}];
            break;
        }
        default:
            return;
    }
    
    //    double timeDiff = (timeValueNow.tv_sec - self.startTimeValue.tv_sec) + 1e-6 * (timeValueNow.tv_usec - self.startTimeValue.tv_usec);
}

- (void)player:(NSString *)aPLayer didAnswerCorrecly:(BOOL)aFlag
{
    
}

- (BOOL)startTimerForFullTimeAfterRandomDelay
{
    assert(![self.gameTimer isValid]);
    
    BOOL result = self.gameState == kGameStateStopped;
    
    if (result)
        result = self.allPlayers.count == kMaxPlayersCount;
    
    if (result)
    {
        // delay for 1-1.5 s
        NSTimeInterval randomDelay = 1.0 + arc4random_uniform(500.0) / 500.0;
        
        self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:randomDelay
                                                          target:self
                                                        selector:@selector(randomDelayTimerFired:)
                                                        userInfo:nil
                                                         repeats:NO];
        self.gameState = kGameStateDelayedBeforeTimerStart;
        [[NSNotificationCenter defaultCenter] postNotificationName:kGameWillStartAfterDelay
                                                            object:self
                                                          userInfo:@{kDelayKey:@(randomDelay)}];
    }
    
    return result;
}

- (BOOL)startTimerForShortTime
{
    assert(![self.gameTimer isValid]);
    
    BOOL result = self.gameState == kGameStatePaused || self.gameState == kGameStateFalseStart;
    
    if (result)
        result = self.playersInGame.count == 1;
    
    if (result)
    {
        self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:kShortTime
                                                          target:self
                                                        selector:@selector(shortTimerFired:)
                                                        userInfo:nil
                                                         repeats:NO];
        self.gameState = kGameStateTimerCountsShortTime;
        [[NSNotificationCenter defaultCenter] postNotificationName:kGameDidStartShortTime
                                                            object:self
                                                          userInfo:nil];
        gettimeofday(&_currentTimeVal, NULL);
    }
    
    return result;
}

- (void)forceStopGame
{
    [self.gameTimer invalidate];
    [self stopGame];
}

#pragma mark - Private

- (void)randomDelayTimerFired:(NSTimer *)aTimer
{
    if (aTimer == self.gameTimer)
    {
        assert(![self.gameTimer isValid]);
        
        self.gameTimer = nil;
        [self startTimerForFullTime];
    }
}

- (void)fullTimeTimerFired:(NSTimer *)aTimer
{
    if (aTimer == self.gameTimer)
    {
        self.gameTimer = nil;
        [self stopGame];
    }
}

- (void)shortTimerFired:(NSTimer *)aTimer
{
    if (aTimer == self.gameTimer)
    {
        self.gameTimer = nil;
        [self stopGame];
    }
}

- (BOOL)startTimerForFullTime
{
    assert(![self.gameTimer isValid]);
    
    BOOL result = self.gameState == kGameStateDelayedBeforeTimerStart;
    
    if (result)
        result = self.allPlayers.count == kMaxPlayersCount;
    
    if (result)
    {
        self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:kFullTime
                                                          target:self
                                                        selector:@selector(fullTimeTimerFired:)
                                                        userInfo:nil
                                                         repeats:NO];
        self.gameState = kGameStateTimerCountsFullTime;
        [[NSNotificationCenter defaultCenter] postNotificationName:kGameDidStartFullTime
                                                            object:self
                                                          userInfo:nil];
        gettimeofday(&_currentTimeVal, NULL);
    }
    
    return result;
}

- (void)stopGame
{
    self.gameState = kGameStateStopped;
    self.playersInGame = [[self.allPlayers mutableCopy] autorelease];
}


@end
