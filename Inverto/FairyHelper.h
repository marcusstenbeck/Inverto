//
//  FairyHelper.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphicsComponent.h"
#import "InputComponent.h"
#import "FairyMover.h"

@interface FairyHelper : CCNode<GameObject>

@property (assign) GraphicsComponent* graphicsComponent;
@property (assign) InputComponent* inputComponent;
@property (assign) FairyMover* moverComponent;

@end
