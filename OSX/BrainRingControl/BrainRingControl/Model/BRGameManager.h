//
//  BRGameManager.h
//  BrainRingControl
//
//  Created by Sergey Dunets on 06.10.13.
//  Copyright (c) 2013 Sergey Dunets. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Constants

/// Notification names
extern NSString * const kTimerWillStart;
extern NSString * const kTimerDidStart;
extern NSString * const kTimerDidStop;
extern NSString * const kGameDidReset;
extern NSString * const kPlayerDidPressButton;
extern NSString * const kShouldProcessFalseStartDidChange;

/// Notification info keys
extern NSString * const kPlayerKey;
extern NSString * const kPlayerTimeKey;

/// @enum BRGameState Subclasses should decide how to use these constants
typedef NS_ENUM(NSInteger, BRGameState) {
    kGameStateStopped,      ///< Game stopped. Initial game state.
    kGameStateDelay,        ///< Delay before the timer starts.
    kGameStateTimerOn,      ///< Timer is on.
    kGameStateTimerPaused   ///< Timer is paused.
};

/**
 A basic class for all games using time control system (Brain-ring, Jeopardy, etc.).
 */
@interface BRGameManager : NSObject

/** 
 @brief Designated.
 @param[in] aTimeIntervals An array of times in format: @[time1, time2, ...]. Times are used in timers.
 @param[in] aCount Max count of players.
 */
- (id)initWithTimeIntervals:(NSArray *)aTimeIntervals maxPlayersCount:(NSInteger)aCount;

/**
 @brief Adds a player to a game. If a player already exists, it won't be added.
 @param[in] aPlayer Unique player name. This can be a device ID or a custom string.
 @return YES if a player was added; NO otherwise.
 */
- (BOOL)addPlayer:(NSString *)aPlayer;

/**
 @brief Removes the player from a game.
 @param[in] aPlayer Unique player name. If no user is found, nothing happens.
 */
- (void)removePlayer:(NSString *)aPlayer;

- (void)startFirstTimer;
- (void)startNextTimer;
- (void)startTimerWithIntervalAtIndex:(NSUInteger)anIndex withMinDelay:(NSTimeInterval)aMinDelay maxDelay:(NSTimeInterval)aMaxDelay;
- (void)pauseTimerAtIndex:(NSUInteger)anIndex;
- (void)resumeTimerAtIndex:(NSUInteger)anIndex;
- (void)stopTimerAtIndex:(NSUInteger)anIndex;
- (void)resetTimerAtIndex:(NSUInteger)anIndex;

/**
 @brief This method must be implemented in subclasses. Call this method when the user presses a game button on his client.
 @param[in] aPlayer Unique player name.
 @param[in] aTime Time measured on a device.
 @param[in] aState Game state on a device.
 */
- (void)player:(NSString *)aPlayer didPressButtonWithInternalTime:(NSTimeInterval)aTime internalGameState:(BRGameState)aState;

- (NSTimeInterval)commonTime;

@end
