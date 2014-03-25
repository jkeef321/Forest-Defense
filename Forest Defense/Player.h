//
//  Player.h
//  Forest Defense
//
//  Created by Justin Keefer on 3/25/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "cocos2d.h"

@class Level_1_1;

@interface Player : CCNode


@property (nonatomic) Level_1_1 *game;
@property (nonatomic) int currentLives;

-(id)initWithTheGame:(Level_1_1*)_game;

@end
