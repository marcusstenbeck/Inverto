//
//  Obstacle.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"
#import "GraphicsComponent.h"
#import "PhysicsComponent.h"


@interface Obstacle : CCNode<GameObject>

@property (assign) GraphicsComponent* graphicsComponent;
@property (assign) PhysicsComponent* physicsComponent;

@end
