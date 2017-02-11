//
//  BSDashboardViewController.m
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 31-12-12.
//  Copyright (c) 2012 Thijs Scheepers. All rights reserved.
//

#import "BSDashboardViewController.h"
#import "BSGameViewController.h"

@interface BSDashboardViewController ()

@end

@implementation BSDashboardViewController

- (void)loadView
{
    [super loadView];
    
    self.title = @"Bubblesweeper";
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    startEasyGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [startEasyGameButton setTitle:@"Start easy game" forState:UIControlStateNormal];
    [startEasyGameButton addTarget:self
                            action:@selector(startGame:)
                  forControlEvents:UIControlEventTouchDown];
    startEasyGameButton.frame = CGRectMake(80.0, 140.0, 160.0, 40.0);
    startEasyGameButton.backgroundColor = [UIColor blackColor];
    startEasyGameButton.layer.cornerRadius = 5;
    [startEasyGameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[self view] addSubview:startEasyGameButton];
    
    startDifficultGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [startDifficultGameButton setTitle:@"Start difficult game" forState:UIControlStateNormal];
    [startDifficultGameButton addTarget:self
                            action:@selector(startGame:)
                  forControlEvents:UIControlEventTouchDown];
    startDifficultGameButton.frame = CGRectMake(80.0, 240.0, 160.0, 40.0);
    startDifficultGameButton.backgroundColor = [UIColor blackColor];
    startDifficultGameButton.layer.cornerRadius = 5;
    [startDifficultGameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[self view] addSubview:startDifficultGameButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)startGame:(id)sender
{
 
    BSGame* game = [BSGame new];
    
    if(sender == startDifficultGameButton)
    {
        [game setMines:30];
        [game setBubblesPerRow:12];
    }
    else if(sender == startEasyGameButton)
    {
        [game setMines:12];
        [game setBubblesPerRow:8];
    }
    
    [[self navigationController] pushViewController:[[BSGameViewController alloc] initWithGame:game] animated:YES];
}

@end
