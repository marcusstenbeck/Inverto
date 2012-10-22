//
//  PlayerPhysicsMover.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerPhysicsMover.h"

// Needed for level representation
// TODO: Don't depend on HelloWorldLayer!
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
//    bodyDef.linearDamping = .5f;
    bodyDef.angularDamping = 1.f;
//    bodyDef.fixedRotation = YES;
	b2Body *body = pWorld->CreateBody(&bodyDef);
	
	// Define another box shape for our dynamic body.
	b2CircleShape dynamicCircle;
	dynamicCircle.m_radius = 0.5;
	
	// Define the dynamic body fixture.
    b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicCircle;
	fixtureDef.density = 1.f;
	fixtureDef.friction = 10.f;
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
        self.go.rotation = -1 * CC_RADIANS_TO_DEGREES(_pBody->GetAngle());
        
        [self.go send:@"player_update_position" from:self];
    }
}

-(void)receive:(NSString *)message from:(id)sender
{
    //NSLog(@"MoverComponent: received message: %@", message);
    
    if( [message isEqualToString:@"player_jump"] )
    {
        [self jump];
    }
    
    // TODO: Program to interface instead
    if( [message isEqualToString:@"update_position"] )
    {
        //NSLog(@"PlayerPhysicsMover(%@) received \"%@\" from %@(%@)", self.go, message, sender, ((CCNode<GameComponent>*)sender).go);
        
        if( [sender conformsToProtocol:@protocol(GameComponent)] )
        {
            CCNode<GameComponent> *gc = (CCNode<GameComponent>*)sender;
            
            

            //NSLog(@"(%@): xImpulse = (%f, %f)", self, gc.go.position.x, gc.go.position.y);
            b2Vec2 linearVelocity = _pBody->GetLinearVelocity();
            double angularVelocity = _pBody->GetAngularVelocity();
            
            // TODO: Move damping value to a better place
            double arbVal = (gc.go.position.x - self.go.position.x) / 8.0;
            arbVal = arbVal*arbVal < 1.f ? linearVelocity.x /1.2f : arbVal;
            
            _pBody->SetLinearVelocity(b2Vec2(arbVal, linearVelocity.y));
            
            /*
            if(sqrt(angularVelocity * angularVelocity) < 8.0 || (angularVelocity * -torque) < 0.0)
                _pBody->ApplyTorque(-torque);
             */
        }
        
    }
}

-(void)jump
{
    _pBody->ApplyLinearImpulse(b2Vec2(0, 7.0), _pBody->GetPosition());
}

@end
