//
//  Tower.h
//  Forest Defense
//
//  Created by Justin Keefer on 3/2/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level_1_1.h"
#import "cocos2d.h"

//it needs to be a subclass of CCNode beacuse of the Cocos2d framework (you can't add it to a scene then
@interface Tower : CCNode
{
    
    int range;
    int damage;
    int fire_rate;
    int cost;
    
}

//we need a reference to the scene so we can add the new image to replace the tower location image
@property (nonatomic, strong) Level_1_1 * scene;

//this will hold a reference to the new image
@property (nonatomic, strong) CCSprite * tower_sprite;

//if you want to call the constrcutor from your code you need to make another method with a "+"
+(id)nodeWithTheGame:(Level_1_1*)_scene location:(CGPoint)location;

//this is the constructor for objective c, this only happens when the class is init.... it needs to start with "init" and a "-".... weird language
-(id)initWithTheGame:(Level_1_1 *)_scene location:(CGPoint)location;


@end
