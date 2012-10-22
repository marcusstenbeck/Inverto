//
//  InputComponent.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "InputComponent.h"

// Imported to send messages to HelloWorldLayer
#import "HelloWorldLayer.h"

@implementation InputComponent

@synthesize go = _go;
@synthesize motionManager = _motionManager;
@synthesize deviceMotion = _deviceMotion;

-(id)init
{
    // >>>>> SET UP ACCELEROMETER
    
    // Create the motion manager object
    self.motionManager = [[[CMMotionManager alloc] init] autorelease];
    
    // Set update interval
    self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
    
    // If the device supports Core Motion, let's get going!
    if(self.motionManager.isDeviceMotionAvailable)
        [self.motionManager startDeviceMotionUpdates];
    
    // <<<<< SET UP ACCELEROMETER
    
    return self;
}

-(id)initWithGameObject:(CCNode<GameObject> *)go
{
    [self init];
    
    self.go = go;
    
    return self;
}

-(void) update:(ccTime)dt
{
    //NSLog(@"InputComponent: update not implemented");
    
    // >>>>> GET ACCELEROMETER UPDATES
    
    // Get the current device motion
    self.deviceMotion = self.motionManager.deviceMotion;
    
    // Broadcast that an update has been made
    [self.go send:@"device_motion_update" from:self];
    
    // <<<<< GET ACCELEROMETER UPDATES
}

-(void) receive:(NSString *)message from:(id)sender
{
    //NSLog(@"InputComponent: recieve not implemented");
    
    // Debug to show attitude when screen is touched
    /*
    if( [message isEqualToString:@"touches_began"] )
    {
        NSLog(@"_currentAttitude: %@", self.attitude);
    }
     */
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"InputComponent: touchesBegan not implemented");
    
    [self.go send:@"touches_began" from:(id)self];
    [self.go send:@"player_jump" from:(id)self];
    
    // TODO: Ta bort FULKOD
    [self.go.level receive:@"player_invert" from:self];
}

@end
