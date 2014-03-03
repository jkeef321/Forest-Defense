//
//  Level_1_1.h
//  Forest Defense
//
//  Created by Justin Keefer on 2/7/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// Level_1_1
@interface Level_1_1 : CCLayer
{
    NSMutableArray *towerLocations;
}

//create an array to track towers that are built in the game
@property (nonatomic, strong) NSMutableArray * towers_in_game;

// returns a CCScene that contains the Level_1_1 as the only child
+(CCScene *) scene;

@end
