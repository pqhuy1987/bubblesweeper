//
//  BSWrapView.h
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 18-12-12.
//  Copyright (c) 2012 Thijs Scheepers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSGame.h"

@interface BSGameView : UIView
{
    NSMutableArray* bubbles;
    BSGame* game;
}

- (id)initWithGame:(BSGame*)game andFrame:(CGRect)frame;

@end
