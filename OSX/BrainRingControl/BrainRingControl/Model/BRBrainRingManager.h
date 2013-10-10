//
//  BRBrainRingManager.h
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


@interface BRBrainRingManager : NSObject

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


/**
 @brief Starts timer for 60 s.
 */
- (void)startTimerForFullTime;

/**
 @brief Starts timer for the second team, 20 s.
 */
- (void)startTimerAfterWrongAnswer;

/**
 @brief Stops the timer.
 */
- (void)resetCurrentTimer;

/**
 @brief Call this method when the user presses a game button on his client.
 @param[in] aPlayer Unique player name.
 @param[in] aTime Time measured on a device.
 @param[in] aState Game state on a device.
 */
- (void)player:(NSString *)aPlayer didPressButtonWithInternalTime:(NSTimeInterval)aTime internalGameState:(BRGameState)aState;


@end
