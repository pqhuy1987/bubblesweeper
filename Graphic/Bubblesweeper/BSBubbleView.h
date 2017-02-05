//
//  BSBubbleView.h
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 18-12-12.
//  Copyright (c) 2012 Thijs Scheepers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSBubble.h"

@interface BSBubbleView : UIView {
    BSBubble* bubble;
}

- (id) initWithBubble:(BSBubble*)aBubble andFrame:(CGRect)frame;

@end
