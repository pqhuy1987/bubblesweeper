//
//  BSBubble.h
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 18-12-12.
//  Copyright (c) 2012 Thijs Scheepers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSGame.h"

@interface BSBubble : NSObject
{
    BSBubble * leftAbove;
    BSBubble * rightAbove;
    BSBubble * left;
    BSBubble * right;
    BSBubble * leftBellow;
    BSBubble * rightBellow;
    
    BOOL popped;
    BOOL mine;
    BOOL marked;
    
    NSArray* borderingBubbles;
    int numberOfBorderingMines;
    
    BSGame* game;
}

@property (nonatomic) BSBubble * leftAbove;
@property (nonatomic) BSBubble * rightAbove;
@property (nonatomic) BSBubble * left;
@property (nonatomic) BSBubble * right;
@property (nonatomic) BSBubble * leftBellow;
@property (nonatomic) BSBubble * rightBellow;

@property (nonatomic, getter=isPopped) BOOL popped;
@property (nonatomic, getter=isMine) BOOL mine;
@property (nonatomic, getter=isMarked) BOOL marked;

@property (nonatomic, readonly) BSGame* game;

- (id) initWithGame:(BSGame*)game;

- (NSArray*)mineFreeBubbles;
- (int)numberOfBorderingMines;

@end
