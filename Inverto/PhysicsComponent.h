//
//  PhysicsComponent.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameComponent.h"
#import "Box2D.h"

@interface PhysicsComponent : CCNode<GameComponent>
{
    b2Body* _pBody;
}

-(void) setPhysicsBody:(b2Body*)body;

@end
