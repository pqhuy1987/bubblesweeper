//
//  BSGameDelegate.h
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 16-01-13.
//  Copyright (c) 2013 Thijs Scheepers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSGame;

@protocol BSGameDelegate <NSObject>

- (void)game:(BSGame*)game didFinishedWithStatus:(BOOL)hasWon;

@end
