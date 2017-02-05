//
//  AVAudioPlayer+soundNamed.m
//  Bubblesweeper
//
//  Created by Thijs Scheepers on 14-01-13.
//  Copyright (c) 2013 Thijs Scheepers. All rights reserved.
//

#import "AVAudioPlayer+soundNamed.h"

@implementation AVAudioPlayer (soundNamed)

+ (AVAudioPlayer *) soundNamed:(NSString *)name {
    NSString * path;
    AVAudioPlayer * snd;
    NSError * err;
    
    path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSURL * url = [NSURL fileURLWithPath:path];
        snd = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                      error:&err];
        if (! snd) {
            NSLog(@"Sound named '%@' had error %@", name, [err localizedDescription]);
        } else {
            [snd prepareToPlay];
        }
    } else {
        NSLog(@"Sound file '%@' doesn't exist at '%@'", name, path);
    }
    
    return snd;
}

@end
