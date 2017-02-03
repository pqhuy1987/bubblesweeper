//
//  AVAudioPlayer+soundNamed.h
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 14-01-13.
//  Copyright (c) 2013 Thijs Scheepers. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVAudioPlayer (soundNamed)

+ (AVAudioPlayer *) soundNamed:(NSString *)name;

@end
