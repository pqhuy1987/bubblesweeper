//
//  BSGame.m
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 31-12-12.
//  Copyright (c) 2012 Thijs Scheepers. All rights reserved.
//

#import "BSGame.h"
#import "BSBubble.h"
#import "NSMutableArray+Shuffle.h"

@implementation BSGame

@synthesize finished,score,mines,gameOver,bubblesPerRow,numberOfRows,bubbles,delegate;

- (id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

- (void) setupBubbles
{
    
    bubbles = [NSMutableArray new];
    
    int i = 0;
    
    while (i < (2 * bubblesPerRow - 1) * numberOfRows / 2)
    {
        
        BSBubble* bubble = [[BSBubble alloc] initWithGame:self];
        [bubbles addObject:bubble];
        
        if(i % (2 * bubblesPerRow - 1) != 0 && i % (2 * bubblesPerRow - 1) != bubblesPerRow)
            [bubble setLeft:[bubbles objectAtIndex:i - 1]];
        
        if(i >= bubblesPerRow && i % (2 * bubblesPerRow - 1) != 0)
            [bubble setLeftAbove:[bubbles objectAtIndex:i - bubblesPerRow]];
        
        if(i >= bubblesPerRow && i % (2 * bubblesPerRow - 1) != bubblesPerRow - 1)
            [bubble setRightAbove:[bubbles objectAtIndex:i - bubblesPerRow + 1]];
        
        i++;
    }
    
    NSMutableArray * minesArray = [NSMutableArray arrayWithArray:bubbles];
    [minesArray shuffle];
    
    i = 0;
    while (i < [self mines])
    {
        BSBubble* bubbleWithMine = [minesArray objectAtIndex:i];
        [bubbleWithMine setMine:YES];
        
        i++;
    }
}

- (void) setGameOver:(BOOL)aGameOver
{
    gameOver = aGameOver;
    
    if(gameOver && delegate != nil && [delegate respondsToSelector:@selector(game:didFinishedWithStatus:)])
        [delegate game:self didFinishedWithStatus:NO];
}

- (void) checkIfGameFinished
{
    BOOL __block finishedCheck = YES;
    
    [bubbles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BSBubble* bubble = (BSBubble*)obj;
        if([bubble isMine] && ![bubble isMarked])
        {
            finishedCheck = NO;
            *stop = YES;
        }
        if(![bubble isMine] && ![bubble isPopped])
        {
            finishedCheck = NO;
            *stop = YES;
        }
        
    }];
    
    if(finishedCheck)
    {
        self.finished = YES;
        
        if(delegate != nil && [delegate respondsToSelector:@selector(game:didFinishedWithStatus:)])
            [delegate game:self didFinishedWithStatus:YES];
    }
    
}

@end
