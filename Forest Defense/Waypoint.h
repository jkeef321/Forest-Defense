//
//  Waypoint.h
//  Forest Defense
//
//  Created by Justin Keefer on 3/22/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "cocos2d.h"
#import "Level_1_1.h"

@interface Waypoint : CCNode{
    Level_1_1 *level;
}

//this variable will hold the position that represents the waypoint
@property (nonatomic, readwrite) CGPoint position;

//this will point to the next waypoint, this is the linked list
@property (nonatomic, assign) Waypoint *nextWay;

+(id)nodeWithTheGame:(Level_1_1*)_game location:(CGPoint)location;
-(id)initWithTheGame:(Level_1_1*)_game location:(CGPoint)location;



@end
