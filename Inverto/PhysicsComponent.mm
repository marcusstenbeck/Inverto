//
//  PhysicsComponent.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PhysicsComponent.h"

// Needed for level representation
// TODO: Don't depend on HelloWorldLayer!
#import "HelloWorldLayer.h"

// TODO: Get PTM_RATIO elsewhere
//#define PTM_RATIO 32.0

@implementation PhysicsComponent

@synthesize go = _go;

-(id)initWithGameObject:(CCNode<GameObject> *)go
{
    self.go = go;
    
    b2World* pWorld = ((HelloWorldLayer*)self.go.level).pWorld;
    
    
    // Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
	bodyDef.type = b2_staticBody;
	bodyDef.position.Set(self.go.position.x / PTM_RATIO,
                         self.go.position.y / PTM_RATIO);
    bodyDef.fixedRotation = YES;
	b2Body *body = pWorld->CreateBody(&bodyDef);
	
	// Define another box shape for our dynamic body.
	b2PolygonShape boxShape;
    boxShape.SetAsBox(.25f, .25f);
	
	// Define the dynamic body fixture.
    b2FixtureDef fixtureDef;
	fixtureDef.shape = &boxShape;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 1.f;
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
    // This is unnecessary - this rarely changes
    _pBody->SetTransform(
                         b2Vec2(self.go.position.x / PTM_RATIO,
                                self.go.position.y / PTM_RATIO),
                         0);
}

-(void)receive:(NSString *)message from:(id)sender
{
    // 
}

@end
