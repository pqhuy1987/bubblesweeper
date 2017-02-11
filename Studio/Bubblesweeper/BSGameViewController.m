//
//  BSViewController.m
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 18-12-12.
//  Copyright (c) 2012 Thijs Scheepers. All rights reserved.
//

#import "BSGameViewController.h"
#import "BSGameView.h"
#import "BSGame.h"
#import "BSBubble.h"

@interface BSGameViewController ()

@end

@implementation BSGameViewController

- (id) initWithGame:(BSGame*)aGame {
    if(self = [super init])
    {
        game = aGame;
        
        game.delegate = self;
        
        self.view = [[BSGameView alloc] initWithGame:game andFrame:CGRectMake(0, 0, 320, 480)];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)game:(BSGame*)game didFinishedWithStatus:(BOOL)hasWon
{
    
    if(hasWon)
    {
        gameFinishedAlertView = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"You have finished the game!" delegate:self cancelButtonTitle:@"Go back" otherButtonTitles: nil];
        [gameFinishedAlertView show];
    }
    else
    {
        [[game bubbles] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BSBubble* bubble = (BSBubble*)obj;
            if([bubble isMine])
                [bubble setPopped:YES];
        }];
        
        gameFinishedAlertView = [[UIAlertView alloc] initWithTitle:@"BOOM!" message:@"You've popped the boom bubble!" delegate:self cancelButtonTitle:@"Go back" otherButtonTitles: nil];
        [gameFinishedAlertView show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
