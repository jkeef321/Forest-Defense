//
//  Level_1_1.m
//  Forest Defense
//
//  Created by Justin Keefer on 2/7/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "Level_1_1.h"
#import "Tower.h"
#import "Waypoint.h"
#import "Enemy.h"
#import "GameOverLayer.h"
#import "GameOverWINLayer.h"
#import "Player.h"

#import "ArcherTower.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - Level_1_1

@implementation Level_1_1

//we synthesize the property so we can access it via setters and getters
@synthesize towers_in_game;
@synthesize waypoints;
@synthesize enemies;

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
    
    //CGSize size = [[CCDirector sharedDirector] winSize];
    
    //intialize the array with a capacity of 4
    towerLocations = [[NSMutableArray alloc] initWithCapacity:4];
    
    [self loadTowerPositions];
    [self addWaypoints];
    
    enemies = [[NSMutableArray alloc] init];
    [self loadWave];
    
    
    //ui_wave_label = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"WAVE: %d", wave] fntFile:@"Marker Felt" ];
    
    //[ui_wave_label setPosition:ccp(400, size.height-12)];
    //[ui_wave_label setAnchorPoint:ccp(0,0.5)];
    
    //I have no idea why the game crashes when the label is added to the scene
    //[self addChild:ui_wave_label z:10];
    
    //playerHp = 5;
    
    //ui_hp_label = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"HP: %d", _currentPlayer.currentLives ] fntFile:@"Marker Felt"];
    
    //[ui_hp_label setPosition:ccp(35, size.height-12)];
    //same problem as above
    //[self addChild:ui_hp_label z:10];
    
	return self;
}

-(void) loadTowerPositions
{
    
    CCSprite * tower_base_1 = [CCSprite spriteWithFile:@"tower_construction.png"];
    //add a tag number so they can be deleted later
    tower_base_1.tag = 1;
    [self addChild:tower_base_1];
    [tower_base_1 setPosition:ccp(180,20)];
    
    //we are adding these objects to the array so we can check positions when the game starts
    [towerLocations addObject:tower_base_1];
    
    CCSprite * tower_base_2 = [CCSprite spriteWithFile:@"tower_construction.png"];
    tower_base_2.tag = 2;
    [self addChild:tower_base_2];
    [tower_base_2 setPosition:ccp(80,150)];
    [towerLocations addObject:tower_base_2];
    
    CCSprite * tower_base_3 = [CCSprite spriteWithFile:@"tower_construction.png"];
    tower_base_3.tag = 3;
    [self addChild:tower_base_3];
    [tower_base_3 setPosition:ccp(220,130)];
    [towerLocations addObject:tower_base_3];
    
    CCSprite * tower_base_4 = [CCSprite spriteWithFile:@"tower_construction.png"];
    tower_base_4.tag = 4;
    [self addChild:tower_base_4];
    [tower_base_4 setPosition:ccp(300,200)];
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
                ArcherTower * new_tower = [ArcherTower nodeWithTheGame:self location:location];
                
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

//this method will add the waypoints to the array to create the enemy path
-(void)addWaypoints
{
    //allocate a new array for waypoints
    waypoints = [[NSMutableArray alloc] init];
    
    //create the last waypoint with a location then add it to the waypoints array
    //the next set of 6 waypoints will determine the enemy path
    Waypoint * wp6 = [Waypoint nodeWithTheGame:self location:ccp(550,20)];
    [waypoints addObject:wp6];
    
    Waypoint * wp5 = [Waypoint nodeWithTheGame:self location:ccp(450,20)];
    [waypoints addObject:wp5];
    wp5.nextWay = wp6;
    
    Waypoint * wp4 = [Waypoint nodeWithTheGame:self location:ccp(450,160)];
    [waypoints addObject:wp4];
    wp4.nextWay = wp5;
    
    Waypoint * wp3 = [Waypoint nodeWithTheGame:self location:ccp(140,160)];
    [waypoints addObject:wp3];
    wp3.nextWay = wp4;
    
    Waypoint * wp2 = [Waypoint nodeWithTheGame:self location:ccp(140,20)];
    [waypoints addObject:wp2];
    wp2.nextWay = wp3;
    
    Waypoint * wp1 = [Waypoint nodeWithTheGame:self location:ccp(0,20)];
    [waypoints addObject:wp1];
    wp1.nextWay = wp2;
    
    
    
}

//this method will determine if the two circles are colliding with one another
//it is used for collision detection
-(BOOL)circle:(CGPoint)circlePoint withRadius:(float)radius collisionWithCircle:(CGPoint)circlePointTwo collisionCircleRadius:(float)radiusTwo
{
    float xdif = circlePoint.x - circlePointTwo.x;
    float ydif = circlePoint.y - circlePointTwo.y;
    
    float distance = sqrt(xdif*xdif + ydif*ydif);
    
    if( distance <= radius+radiusTwo)
        return YES;
    
    return NO;
    
    
}

//this function will load a wave definition from a property list
-(BOOL)loadWave
{
    //load wave data from plist file
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"Waves" ofType:@"plist"];
    NSArray * waveData = [NSArray arrayWithContentsOfFile:plistPath];
    
    //if wave doesn't exist, return no
    if( wave >= [waveData count])
    {
        return NO;
    }
    
    //get currentwave data from plist
    NSArray * currentWaveData = [NSArray arrayWithArray:[waveData objectAtIndex:wave]];
    
    //for each create an enemy each entry in wave data
    for(NSDictionary * enemyData in currentWaveData)
    {
        Enemy * enemy = [Enemy nodeWithTheGame:self];
        [enemies addObject:enemy];
        [enemy schedule:@selector(doActivate)
               interval:[[enemyData objectForKey:@"spawnTime"]floatValue]];
    }
    
    //increment wave counter
    wave++;
    //set label to current wave
    //[ui_wave_label setString:[NSString stringWithFormat:@"WAVE: %d",wave]];
    
    return YES;
    
}

//if an enemy got killed, then....
-(void)enemyGotKilled {
    
    if ([enemies count]<=0) //If there are no more enemies.
    {
        if(![self loadWave])
        {
            NSLog(@"You win!");
            [[CCDirector sharedDirector] replaceScene:[CCTransitionSplitCols
                                                       transitionWithDuration:1
                                                       scene:[GameOverWINLayer scene]]];
        }
    }
}


-(void)getHpDamage {
    
    //playerHp--;
    _currentPlayer.currentLives--;
    //[ui_hp_label setString:[NSString stringWithFormat:@"HP: %d",_currentPlayer.currentLives]];
    if (_currentPlayer.currentLives <=0) {
        [self doGameOver];
    }
}

-(void)doGameOver {
    if (!gameOver) {
        gameOver = YES;
        [[CCDirector sharedDirector]
         replaceScene:[CCTransitionRotoZoom transitionWithDuration:1
                                                             scene:[GameOverLayer scene]]];
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
