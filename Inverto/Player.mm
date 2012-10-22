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
@synthesize courierComponent = _courierComponent;

-(id)initWithLevel:(HelloWorldLayer *)level
{
    NSLog(@"Initialized Player class");
    
    self.level = level;
    
    self.graphicsComponent = [[GraphicsComponent alloc] initWithGameObject:self];
    self.moverComponent = [[PlayerPhysicsMover alloc] initWithGameObject:self];
    self.inputComponent = [[InputComponent alloc] initWithGameObject:self];
    self.courierComponent = [[CourierComponent alloc] initWithGameObject:self];
    
    // Use Inverto dude as image!
    self.graphicsComponent.sprite = [CCSprite spriteWithFile:@"dude.png"];
    
    return self;
}

-(void) update:(ccTime)dt
{
    //NSLog(@"Player update");
    
    [self.inputComponent update:dt];
    [self.moverComponent update:dt];
    [self.graphicsComponent update:dt];
    [self.courierComponent update:dt];
}

-(void) send:(NSString *)message from:(id)sender
{
    //NSLog(@"Player sent message: %@", message);
    
    // Send message to 
    [self.graphicsComponent receive:message from:sender];
    [self.moverComponent receive:message from:sender];
    [self.inputComponent receive:message from:sender];
    [self.courierComponent receive:message from:sender];
}

@end
