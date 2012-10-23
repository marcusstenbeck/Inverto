//
//  Obstacle.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Obstacle.h"


@implementation Obstacle

@synthesize level = _level;

@synthesize graphicsComponent = _graphicsComponent;
@synthesize physicsComponent = _physicsComponent;

-(id)initWithLevel:(HelloWorldLayer *)level
{
    NSLog(@"Initialized Player class");
    
    self.level = level;
    
    self.graphicsComponent = [[GraphicsComponent alloc] initWithGameObject:self];
    self.physicsComponent = [[PhysicsComponent alloc] initWithGameObject:self];
    
    // Use rock as image
    self.graphicsComponent.sprite = [CCSprite spriteWithFile:@"block.png"];
    
    return self;
}

-(void) update:(ccTime)dt
{
    //NSLog(@"Obstacle update");
    
    [self.physicsComponent update:dt];
    [self.graphicsComponent update:dt];
}

-(void) send:(NSString *)message from:(id)sender
{
    //NSLog(@"Obstacle sent message: %@", message);
    
    // Send message to
    [self.graphicsComponent receive:message from:sender];
    [self.physicsComponent receive:message from:sender];
}

@end
