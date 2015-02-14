//
//  PhysicsSmallWedge.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-24.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PhysicsSmallWedge.h"

// Need PTM_RATIO
#import "LevelLayer.h"

@implementation PhysicsSmallWedge

-(id)initWithGameObject:(CCNode<GameObject> *)go
{
    self.go = go;
    
    b2World* pWorld = ((LevelLayer*)self.go.level).pWorld;
    
    
    // Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
	bodyDef.type = b2_staticBody;
	bodyDef.position.Set(self.go.position.x / PTM_RATIO,
                         self.go.position.y / PTM_RATIO);
    bodyDef.angle = -self.go.rotation * M_PI / 180.f;
    bodyDef.fixedRotation = YES;
	b2Body *body = pWorld->CreateBody(&bodyDef);
	
	// Define another box shape for our dynamic body.
	b2PolygonShape shape;
    b2Vec2 smallWedge[3];
    
    double scaleX = self.go.scaleX;
    
    if(scaleX >= 0.0)
    {
        smallWedge[0].Set(-.25f * scaleX, -.25f);
        smallWedge[1].Set(.25f * scaleX, -.25f);
        smallWedge[2].Set(.25f * scaleX, .25f);
    }
    else
    {
        smallWedge[0].Set(-.25f * scaleX, -.25f);
        smallWedge[2].Set(.25f * scaleX, -.25f);
        smallWedge[1].Set(.25f * scaleX, .25f);
    }
    
    shape.Set(smallWedge, 3);
	
	// Define the dynamic body fixture.
    b2FixtureDef fixtureDef;
	fixtureDef.shape = &shape;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 1.f;
	body->CreateFixture(&fixtureDef);
    
    // Set physics body in player mover component
    [self setPhysicsBody:body];
    
    return self;
}

@end
