//
//  Player.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"
#import "GraphicsComponent.h"
#import "InputComponent.h"
#import "PlayerPhysicsMover.h"

@interface Player : CCNode<GameObject>

@property (assign) GraphicsComponent* graphicsComponent;
@property (assign) InputComponent* inputComponent;
@property (assign) PlayerPhysicsMover* moverComponent;

@end
