//
//  BRBrainRingManager.h
//  BrainRingControl
//
//  Created by Sergey Dunets on 06.10.13.
//  Copyright (c) 2013 Sergey Dunets. All rights reserved.
//

#import <Foundation/Foundation.h>

// Notification names

/// The @c kGameDidStop notification is sent after the game was stopped.
/// userInfo keys:
/// @arg @c kPlayersKey - NSArray of players
extern NSString * const kGameDidReset;

/// The @c kGameWillStartAfterDelay notification is sent after the delay timer was run.
/// userInfo keys:
/// @arg @c kDelayKey - the delay time in seconds.
extern NSString * const kGameWillStartAfterDelay;

/// A player had pressed the game button before the timer started.
/// userInfo keys:
/// @arg @c kPlayerKey - the player name.
/// @arg @c kPlayerTimeKey - the player time in seconds after the game was stopped.
extern NSString * const kPlayerDidPressFalseStart;

/// Full time timer (60 s) was run.
extern NSString * const kGameDidStartFullTime;

/// A player pressed the game button.
/// userInfo keys:
/// @arg @c kPlayerKey - the player name.
/// @arg @c kPlayerTimeKey - the player time in seconds after the game timer was run.
extern NSString * const kPlayerDidPressButton;

/// 20 second timer was run.
extern NSString * const kGameDidStartShortTime;


// Notification userInfo dictionary keys
extern NSString * const kPlayersKey;
extern NSString * const kDelayKey;
extern NSString * const kPlayerKey;
extern NSString * const kPlayerTimeKey;

// Game states
typedef NS_ENUM(NSInteger, BRGameState) {
    kGameStateStopped,                          ///< An initial game state.
    
    kGameStateDelayedBeforeTimerStart,          ///< Random delay before the timer starts.
    
    kGameStateFalseStart,                       ///< The user inited state.
                                                ///< A player had pressed button before the timer was run, i.e. while
                                                ///< kGameStateDelayedBeforeTimerStart.
    
    kGameStateTimerCountsFullTime,              ///< The timer is counting full time (60 seconds in brain ring).
    
    kGameStatePaused,                           ///< The user inited state.
                                                ///< The timer is stopped. A player/team answers the question.
                                                ///< If the answer is correct the game state changes to kGameStateStopped, otherwise
                                                ///< timer runs additional time for another team
                                                ///< changing the state to kGameStateTimerCountsTimeAfterWrongAnswer
    
    kGameStateTimerCountsShortTime   ///< The timer runs if the previous player/team answered wrong.
};

/// @class BRBrainRingManager
/// @brief This is the main model class in the application.
@interface BRBrainRingManager : NSObject

/// @brief Current game state.
@property (nonatomic, assign) BRGameState       gameState;

#pragma mark - Managing players

/// @brief Adds a player to a game. If a player already exists, it won't be added.
/// @param[in] aPlayer Unique player name. This can be a device ID or a custom string.
/// @return YES if a player was added; NO otherwise.
- (BOOL)addPlayer:(NSString *)aPlayer;

/// @brief Removes the player from a game.
/// @param[in] aPlayer Unique player name. If no user is found, nothing happens.
- (void)removePlayer:(NSString *)aPlayer;

#pragma mark - Gameplay

/// @brief Call this method when the user presses a game button in the client app.
/// @param[in] aPlayer Unique player name.
/// @param[in] aTime Time measured on a device.
/// @param[in] aState Game state on a device.
- (void)player:(NSString *)aPlayer didPressButtonWithInternalTime:(NSTimeInterval)aTime internalGameState:(BRGameState)aState;

/// @brief Call this method after the user answered a question. This method must be called only after a player presses the button.
/// @param[in] aPlayer Unique player name.
/// @param[in] aFlag Boolean flag: YES if the answer was correct.
- (void)player:(NSString *)aPLayer didAnswerCorrecly:(BOOL)aFlag;

/// @brief Starts timer for 60 s after a short delay.
/// @return NO if an error occurs
- (BOOL)startTimerForFullTimeAfterRandomDelay;

/// @brief Starts timer for 20 s without a delay.
/// @return NO if an error occurs
- (BOOL)startTimerForShortTime;

/// @brief Resets the game, resets all players.
- (void)resetGame;

@end
