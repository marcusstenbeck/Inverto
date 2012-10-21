//
//  CourierComponent.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-21.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CourierComponent.h"


@implementation CourierComponent

@synthesize go = _go;
@synthesize listeners = _listeners;

-(void)addListener:(CCNode<GameComponent> *)listener
{
    // Add a listener to the list of listeners
    self.listeners = [self.listeners arrayByAddingObject:listener];
}

// TODO: Maybe we don't want to give external components access to internal state
-(void)notifyListeners:(NSString *)message from:(CCNode<GameComponent> *)sender
{
    // Send the message to all registered listeners
    for (CCNode<GameComponent>* gc in self.listeners)
    {
        //NSLog(@"(%@): Notifying %@ with \"%@\" from %@", self, gc, message, sender);
        [gc receive:message from:sender];
    }
}

-(id)init
{
    self.listeners = [[NSArray alloc] init];
    
    return self;
}

-(id)initWithGameObject:(CCNode<GameObject> *)go
{
    [self init];
    
    self.go = go;
    
    return self;
}

-(void)receive:(NSString *)message from:(id)sender
{
    [self notifyListeners:message from:sender];
}

-(void)update:(ccTime)dt
{
    //NSLog(@"CourierComponent update");
}

@end
