//
//  Level_1_1.m
//  Forest Defense
//
//  Created by Justin Keefer on 2/7/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "Level_1_1.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - Level_1_1

@implementation Level_1_1

// Helper class method that creates a Scene with the Level_1_1 as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Level_1_1 *layer = [Level_1_1 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
		// ask director for the window size
		self.touchEnabled = YES;
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite * background_image = [CCSprite spriteWithFile:@"background_map.png"];
        [self addChild:background_image];
        [background_image setPosition:ccp(size.width/2,size.height/2)];
        
		
        
	}
	return self;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}



@end
