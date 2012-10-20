//
//  GameComponent.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "GameObject.h"

// TODO: Recieve method for messages from a GameObject

@protocol GameComponent

@required
@property (assign) CCNode<GameObject>* go;

@required
-(id) initWithGameObject:(CCNode<GameObject>*)go;

-(void) update:(ccTime)dt;

@required
-(void) receive:(NSString *)message from:(id)sender;

@end
