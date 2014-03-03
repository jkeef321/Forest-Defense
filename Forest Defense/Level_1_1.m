//
//  Level_1_1.m
//  Forest Defense
//
//  Created by Justin Keefer on 2/7/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "Level_1_1.h"
#import "Tower.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - Level_1_1

@implementation Level_1_1

//we synthesize the property so we can access it via setters and getters
@synthesize towers_in_game;

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
    
    //intialize the array with a capacity of 4
    towerLocations = [[NSMutableArray alloc] initWithCapacity:4];
    
    [self loadTowerPositions];
	return self;
}

-(void) loadTowerPositions
{

    CCSprite * tower_base_1 = [CCSprite spriteWithFile:@"tower_construction.png"];
    //add a tag number so they can be deleted later
    tower_base_1.tag = 1;
    [self addChild:tower_base_1];
    [tower_base_1 setPosition:ccp(160,20)];
    
    //we are adding these objects to the array so we can check positions when the game starts
    [towerLocations addObject:tower_base_1];
    
    CCSprite * tower_base_2 = [CCSprite spriteWithFile:@"tower_construction.png"];
    tower_base_2.tag = 2;
    [self addChild:tower_base_2];
    [tower_base_2 setPosition:ccp(60,150)];
    [towerLocations addObject:tower_base_2];
    
    CCSprite * tower_base_3 = [CCSprite spriteWithFile:@"tower_construction.png"];
    tower_base_3.tag = 3;
    [self addChild:tower_base_3];
    [tower_base_3 setPosition:ccp(220,130)];
    [towerLocations addObject:tower_base_3];
    
    CCSprite * tower_base_4 = [CCSprite spriteWithFile:@"tower_construction.png"];
    tower_base_4.tag = 4;
    [self addChild:tower_base_4];
    [tower_base_4 setPosition:ccp(300,240)];
    [towerLocations addObject:tower_base_4];
    
    
    
}

//This method will be called everytime a person "touches" the screen
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    for( UITouch *touch in touches)
    {
        CGPoint location = [touch locationInView: [touch view]];
        
        location = [[CCDirector sharedDirector] convertToGL:location];
        
        //check the location against each towerlocation to see if the user is selecting a tower
        
       
        for( CCSprite * tower_loc in towerLocations)
        {
            
            if( CGRectContainsPoint([tower_loc boundingBox], location) && !tower_loc.userData)
            {
                NSLog(@"Tower Location was HIT");
                
                //create a new tower at the location
                Tower * new_tower = [Tower nodeWithTheGame:self location:location];
                
                //add the tower to the in memory array of towers
                [towers_in_game addObject:new_tower];
                
                //userData in the CCSprite is a place to put a customer pointer
                //We are assigning (via the __bridge command, this is a way to have the automatic reference counter (to avoid mem leaks) track the pointer assignment) the new_tower to the userData field and then checking that value above to make sure you can only build "one" tower over a spot.
                tower_loc.userData = (__bridge void *)(new_tower);
                
                int tag = tower_loc.tag;
                
                //remove the "building" image
                [self removeChildByTag:tag cleanup:YES];
                                
            }
        }
        
        
    }
    
    
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
