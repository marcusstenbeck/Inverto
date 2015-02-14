//
//  LevelLayer.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - LevelLayer

@implementation LevelLayer

@synthesize pWorld = _pWorld;
@synthesize gameObjects = _gameObjects;

-(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    [scene addChild:self];
    
    return scene;
}

-(void)receive:(NSString *)message from:(id)sender
{
    NSLog(@"(%@): Received message \"%@\" from %@", self, message, sender);
    
    /*
    if( [message isEqualToString:@"player_invert"] )
    {
        _inverted = _inverted ? NO : YES;
    }
    */
}

- (void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    //UITouch* touch = [touches anyObject];
    //in your touchesEnded event, you would want to see if you touched
    //down and then up inside the same place, and do your logic there.
    
    NSLog(@"Screen touches began");
    
    // Test the input component
    //[_player.inputComponent touchesBegan:touches withEvent:event];
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Screen touches ended");
}

-(void) draw
{
	//
	// IMPORTANT:
	// This is only for debug purposes
	// It is recommend to disable it
	//
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	self.pWorld->DrawDebugData();
	
	kmGLPopMatrix();
}

-(void) initPhysics
{
    self.pWorld = new b2World(b2Vec2(0, -10));
    
    m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	self.pWorld->SetDebugDraw(m_debugDraw);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
	//		flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
	//      flags += b2Draw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);
}

-(id) init
{
	if(self = [super init])
    {
        self.gameObjects = [[NSArray alloc] init];
        
        self.isTouchEnabled = YES;
        
        _inverted = NO;
        
        _invertedLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"_inverted: %d", _inverted] fontName:@"Marker Felt" fontSize:16];
        [self addChild:_invertedLabel];
        [_invertedLabel setColor:ccc3(127,127,127)];
        _invertedLabel.position = ccp(self.position.x, self.position.y);
        
		// Little bit of physics setup
        [self initPhysics];
        
        
        // Schedule update
        [self scheduleUpdate];
	}
	return self;
}

-(void) update:(ccTime)dt
{
    // COMMENT: Maybe this is the integration resolution
    self.pWorld->Step(dt, 10, 10);
    self.pWorld->DrawDebugData();
    
    // Update inverted label
    _invertedLabel.string = [NSString stringWithFormat:[NSString stringWithFormat:@"_inverted: %d", _inverted]];
    _invertedLabel.position = ccp(-self.position.x + 100, -self.position.y + 100);
    
    
    for(CCNode<GameObject>* go in self.gameObjects)
    {
        [go update:dt];
    }
    
}

-(void) dealloc
{
    // Now handled by synthesize?
    /*
     delete _world;
     _world = NULL;
     */
    
	delete m_debugDraw;
	m_debugDraw = NULL;
	
	[super dealloc];
}

@end
