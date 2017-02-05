//
//  BSBubbleView.m
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 18-12-12.
//  Copyright (c) 2012 Thijs Scheepers. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "AVAudioPlayer+soundNamed.h"
#import "BSBubbleView.h"
#import "BSBubble.h"

@implementation BSBubbleView

- (id) initWithBubble:(BSBubble*)aBubble andFrame:(CGRect)frame;
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor clearColor]];
        
        bubble = aBubble;
        
        UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popTheBubble)];
        
        UILongPressGestureRecognizer* pressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(markTheBubble:)];
        
        [self addGestureRecognizer:tapGestureRecognizer];
        [self addGestureRecognizer:pressGestureRecognizer];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rectangle = CGRectMake(1,1,self.frame.size.width - 2,self.frame.size.height - 2);
    
    CGContextAddEllipseInRect(context, rectangle);
    CGContextSetLineWidth(context, 0.0);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    
    if([bubble isMine] && [bubble isPopped])
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    else if([bubble isMarked] && ![bubble.game isGameOver])
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0.5f blue:0 alpha:1].CGColor);
    else if([bubble isMarked] && [bubble.game isGameOver] && [bubble isMine])
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0.5f blue:0 alpha:1].CGColor);
    else if([bubble isMarked] && [bubble.game isGameOver] && ![bubble isMine])
        CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
#ifdef TESTING
    else if([bubble isMine] && ![bubble isPopped])
        CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
#endif
    else
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    if([bubble isPopped])
    {
        UIImage* poppedImage  = [UIImage imageNamed:@"Popped"];
        [poppedImage drawInRect:rect];
    }
    else
    {
        UIImage* bubbleImage  = [UIImage imageNamed:@"Bubble"];
        [bubbleImage drawInRect:rect];
    }
    
    
    if([bubble isPopped] && ![bubble isMine] && [bubble numberOfBorderingMines] > 0)
    {
        CGRect textRect = CGRectMake(0, self.frame.size.height / 4, self.frame.size.width, self.frame.size.height / 2);
        NSString* string = [NSString stringWithFormat:@"%i",[bubble numberOfBorderingMines]];
        
        if([string isEqualToString:@"1"])
            [[UIColor colorWithRed:0 green:0.0f blue:0.5f alpha:1] set];
        else if([string isEqualToString:@"2"])
            [[UIColor colorWithRed:0 green:0.5f blue:0 alpha:1] set];
        else if([string isEqualToString:@"3"])
            [[UIColor colorWithRed:0.5f green:0.0f blue:0.0f alpha:1] set];
        else if([string isEqualToString:@"4"])
            [[UIColor purpleColor] set];
        else if([string isEqualToString:@"5"])
            [[UIColor orangeColor] set];
        else if([string isEqualToString:@"6"])
            [[UIColor yellowColor] set];
        else
            [[UIColor whiteColor] set];
        
        [string drawInRect:textRect
                  withFont:[UIFont systemFontOfSize:self.frame.size.height / 2]
             lineBreakMode:NSLineBreakByTruncatingMiddle alignment:NSTextAlignmentCenter];
    }
}

- (void) popTheBubble
{
    
    if(![bubble isMine] && ![bubble isMarked] && ![bubble isPopped])
    {
        [bubble setPopped:YES];
        
        BOOL __block lotsOfPops = NO;
        
        [[bubble mineFreeBubbles] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            BSBubble* borderingBubble = (BSBubble*)obj;
            [borderingBubble setPopped:YES];
            [borderingBubble setMarked:NO];
            
            lotsOfPops = YES;
        }];
        
        [BSBubbleView playPopSound];
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
        
        if(lotsOfPops)
        {
            // I know, this is very ugly
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
                [BSBubbleView playPopSound];
                AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
                    [BSBubbleView playPopSound];
                    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
                });
            });
        }
        
        [bubble.game checkIfGameFinished];
    }
    else if([bubble isMine] && ![bubble isMarked]) {
        
        [bubble setPopped:YES];
        
        [BSBubbleView playPopSound];
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
        
        [bubble.game setGameOver:YES];
    }
    
    [[[self superview] subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setNeedsDisplay];
    }];
}

- (void) markTheBubble:(UILongPressGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        if(![bubble isPopped])
        {
            
            AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
            
            if([bubble isMarked])
                [bubble setMarked:NO];
            else
                [bubble setMarked:YES];
            
            [bubble.game checkIfGameFinished];
            
            [[[self superview] subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [obj setNeedsDisplay];
            }];
            
        }
    }
}

+ (void)playPopSound
{
    NSString *path = [NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], @"/pop.caf"];
    
    SystemSoundID soundID;
    
    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
    
    //Use audio sevices to create the sound
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    
    //Use audio services to play the sound
    
    AudioServicesPlaySystemSound(soundID);
}

@end
