//
//  BSBubble.m
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 18-12-12.
//  Copyright (c) 2012 Thijs Scheepers. All rights reserved.
//

#import "BSBubble.h"

@interface BSBubble ()

- (void)checkBorderingBubbles:(NSMutableArray*)middleBubbles
         checkedBorderBubbles:(NSMutableArray*)borderBubbles;

@end

@implementation BSBubble

@synthesize left,leftAbove,leftBellow,right,rightAbove,rightBellow,popped,marked,mine,game;

- (id) initWithGame:(BSGame*)aGame
{
    if (self = [super init])
    {
        
        game = aGame;
        
        numberOfBorderingMines = -1;
        
    }
    return self;
}

- (void)setLeft:(BSBubble *)theLeft
{
    left = theLeft;
    
    if (left != nil)
        [left setRight:self];
}

- (void)setLeftAbove:(BSBubble *)theLeftAbove
{
    leftAbove = theLeftAbove;
    
    if(leftAbove != nil)
        [leftAbove setRightBellow:self];
}

- (void) setRightAbove:(BSBubble *)theRightAbove
{
    rightAbove = theRightAbove;
    
    if(rightAbove != nil)
        [rightAbove setLeftBellow:self];
}

- (NSArray*)mineFreeBubbles
{
    NSMutableArray* checkedMiddleBubbles = [NSMutableArray new];
    NSMutableArray* checkedBorderBubbles = [NSMutableArray new];
    
    [self checkBorderingBubbles:checkedMiddleBubbles
           checkedBorderBubbles:checkedBorderBubbles];
    
    [checkedMiddleBubbles addObjectsFromArray:checkedBorderBubbles];
    
    return [NSArray arrayWithArray:checkedMiddleBubbles];
}

- (void)checkBorderingBubbles:(NSMutableArray*)middleBubbles
checkedBorderBubbles:(NSMutableArray*)borderBubbles
{
    
    if(![middleBubbles containsObject:self] && ![borderBubbles containsObject:self] && [self numberOfBorderingMines] == 0)
    {
        [[self borderingBubbles] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BSBubble* borderingBubble = (BSBubble*) obj;
            
            if ([borderingBubble numberOfBorderingMines] > 0)
            {
                [borderBubbles addObject:borderingBubble];
            }
            else
            {
                [middleBubbles addObject:self];
                
                [borderingBubble checkBorderingBubbles:middleBubbles
                                  checkedBorderBubbles:borderBubbles];
            }
            
        }];
        
    }
}



- (NSArray*) borderingBubbles
{
    if(borderingBubbles == nil)
    {
        NSMutableArray * result = [NSMutableArray new];
        
        if(left != nil) [result addObject:left];
        if(right != nil) [result addObject:right];
        if(leftAbove != nil) [result addObject:leftAbove];
        if(rightAbove != nil) [result addObject:rightAbove];
        if(leftBellow != nil) [result addObject:leftBellow];
        if(rightBellow != nil) [result addObject:rightBellow];
        
        borderingBubbles = [NSArray arrayWithArray:result];
        
    }
    return borderingBubbles;
}

- (int)numberOfBorderingMines
{
    if(numberOfBorderingMines == -1)
    {
        
        int __block result = 0;
        
        [[self borderingBubbles] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BSBubble* borderingBubble = (BSBubble*) obj;
            if([borderingBubble isMine]) result++;
        }];
        
        numberOfBorderingMines = result;
        
    }
    
    return numberOfBorderingMines;
}

@end
