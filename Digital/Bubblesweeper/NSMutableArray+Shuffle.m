//
//  NSMutableArray+Shuffle.m
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 31-12-12.
//  Copyright (c) 2012 Thijs Scheepers. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"

@implementation NSMutableArray (Shuffle)

// http://stackoverflow.com/questions/56648/whats-the-best-way-to-shuffle-an-nsmutablearray
- (void)shuffle
{
    NSUInteger count = [self count];
    
    for (NSUInteger i = 0; i < count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end
