//
//  ShortRamp.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-24.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ShortRamp.h"


@implementation ShortRamp

@synthesize level = _level;

@synthesize graphicsComponent = _graphicsComponent;
@synthesize physicsComponent = _physicsComponent;

-(id)initWithLevel:(LevelLayer *)level
{
    NSLog(@"Initialized Obstacle class");
    
    self.level = level;
    
    self.graphicsComponent = [[GraphicsComponent alloc] initWithGameObject:self];
    self.physicsComponent = [[PhysicsSmallWedge alloc] initWithGameObject:self];
    
    // Use rock as image
    if(self.rotation == 180 || self.rotation == -180)
        self.graphicsComponent.sprite = [CCSprite spriteWithFile:@"ramp-short-3.png"];
    else
        self.graphicsComponent.sprite = [CCSprite spriteWithFile:@"ramp-short-1.png"];
    
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
