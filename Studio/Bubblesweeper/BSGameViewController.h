//
//  BSViewController.h
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 18-12-12.
//  Copyright (c) 2012 Thijs Scheepers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSGame.h"
#import "BSGameDelegate.h"

@interface BSGameViewController : UIViewController <BSGameDelegate,UIAlertViewDelegate> {
    BSGame* game;
    
    UIAlertView* gameFinishedAlertView;
}

- (id) initWithGame:(BSGame*)aGame;

@end
