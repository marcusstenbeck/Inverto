//
//  PlayerPhysicsMover.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerPhysicsMover.h"

// Needed for level representation
#import "HelloWorldLayer.h"

// TODO: Get PTM_RATIO elsewhere
//#define PTM_RATIO 32.0

@implementation PlayerPhysicsMover

-(id)initWithGameObject:(CCNode<GameObject> *)go
{
    self.go = go;
    
    b2World* pWorld = ((HelloWorldLayer*)self.go.level).pWorld;
    
    CGSize s = [CCDirector sharedDirector].winSize;
    
    NSLog(@"Box placed at (%f, %f)", s.width / (2*PTM_RATIO), 2*s.height / (3*PTM_RATIO));
    
    // Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position.Set(s.width / (2*PTM_RATIO), s.height / (2*PTM_RATIO));
	b2Body *body = pWorld->CreateBody(&bodyDef);
	
	// Define another box shape for our dynamic body.
	b2PolygonShape dynamicBox;
	dynamicBox.SetAsBox(.5f, .5f);//These are mid points for our 1m box
	
	// Define the dynamic body fixture.
    b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
	body->CreateFixture(&fixtureDef);
    
    // Set physics body in player mover component
    [self setPhysicsBody:body];
    
    return self;
}

-(void)setPhysicsBody:(b2Body *)body
{
    _pBody = body;
}

-(void)update:(ccTime)dt
{
    // TODO: Maybe a super update?
    
    if(_pBody != NULL)
    {
        b2Vec2 pos = _pBody->GetPosition();
    
        // TODO: Get PTM_RATIO
        pos.x = pos.x * 32.0;
        pos.y = pos.y * 32.0;
        
        // Update position in game object
        self.go.position = ccp(pos.x, pos.y);
        self.go.rotation = -1 * CC_RADIANS_TO_DEGREES(_pBody->GetAngle());;
    }
}

-(void)receive:(NSString *)message
{
    //NSLog(@"MoverComponent: received message: %@", message);
    
    if( [message isEqualToString:@"player_jump"] )
    {
        [self jump];
    }
}

-(void)jump
{
    _pBody->ApplyLinearImpulse(b2Vec2(0, 1.0), _pBody->GetPosition());
}

@end
