//
//  BSWrapView.m
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 18-12-12.
//  Copyright (c) 2012 Thijs Scheepers. All rights reserved.
//

#import "BSGameView.h"
#import "BSBubble.h"
#import "BSBubbleView.h"


@implementation BSGameView

- (id)initWithGame:(BSGame*)aGame andFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
        [self setBackgroundColor:[UIColor colorWithRed:255/255.f green:130/255.f blue:71/255.f alpha:1]];
       
        game = aGame;
        
        int widthPerBubble = frame.size.width / game.bubblesPerRow;
        game.numberOfRows = frame.size.height / widthPerBubble;
        
        [game setupBubbles];
        
        int __block x = 0;
        int __block y = 0;
        
        [game.bubbles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            BSBubble* bubble = (BSBubble*)obj;
            [self addSubview:[[BSBubbleView alloc] initWithBubble:bubble andFrame:CGRectMake(x, y, widthPerBubble, widthPerBubble)]];
             
            if([bubble right] == nil && [bubble rightBellow] != nil) {
                y = y + widthPerBubble;
                x = 0;
            }
            else if ([bubble right] == nil && [bubble rightBellow] == nil) {
                y = y + widthPerBubble;
                x = widthPerBubble / 2;
            }
            else {
                x = x + widthPerBubble;
            }
            
        }];
        
         
    }
    return self;
}


@end
