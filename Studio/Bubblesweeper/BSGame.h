//
//  BSGame.h
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 31-12-12.
//  Copyright (c) 2012 Thijs Scheepers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSGameDelegate.h"

@interface BSGame : NSObject {
    
    BOOL gameOver;
    BOOL finished;
    
    int score;
    int mines;
    
    int bubblesPerRow;
    int numberOfRows;
    
    NSMutableArray* bubbles;
    id<BSGameDelegate> delegate;
}

@property (nonatomic,getter = isFinished) BOOL finished;
@property (nonatomic,getter = isGameOver) BOOL gameOver;

@property (nonatomic) int score;
@property (nonatomic) int mines;

@property (nonatomic) int bubblesPerRow;
@property (nonatomic) int numberOfRows;

@property (nonatomic) NSMutableArray* bubbles;
@property (nonatomic) id<BSGameDelegate> delegate;

- (void) setupBubbles;

- (void) checkIfGameFinished;

@end
