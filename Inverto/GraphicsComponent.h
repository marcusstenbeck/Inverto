//
//  GraphicsComponent.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameComponent.h"
#import "GameObject.h"
#import "cocos2d.h"

@interface GraphicsComponent : CCNode<GameComponent>

@property (strong) CCSprite *sprite;

-(void)update:(ccTime)dt;

@end
