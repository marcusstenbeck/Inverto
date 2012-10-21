//
//  CourierComponent.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-21.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameComponent.h"


@interface CourierComponent : CCNode<GameComponent>

@property (strong) NSArray *listeners;


-(void)addListener:(CCNode<GameComponent>*)listener;

-(void)notifyListeners:(NSString*)message from:(CCNode<GameComponent>*)sender;

@end
