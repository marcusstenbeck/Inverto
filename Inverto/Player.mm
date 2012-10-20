//
//  Player.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize level = _level;

@synthesize graphicsComponent = _graphicsComponent;
@synthesize inputComponent = _inputComponent;
@synthesize moverComponent = _moverComponent;

-(id)initWithLevel:(CCLayer *)level
{
    NSLog(@"Initialized Player class");
    
    self.level = level;
    
    _graphicsComponent = [[GraphicsComponent alloc] initWithGameObject:self];
    _moverComponent = [[PlayerPhysicsMover alloc] initWithGameObject:self];
    _inputComponent = [[InputComponent alloc] initWithGameObject:self];
    
    return self;
}

-(void) update:(ccTime)dt
{
    //NSLog(@"Player update");
    
    [_inputComponent update:dt];
    [_moverComponent update:dt];
    [_graphicsComponent update:dt];
}

-(void) send:(NSString *)message from:(id)sender
{
    //NSLog(@"Player sent message: %@", message);
    
    // Send message to 
    [_graphicsComponent receive:message from:sender];
    [_moverComponent receive:message from:sender];
    [_inputComponent receive:message from:sender];
    
}

@end
