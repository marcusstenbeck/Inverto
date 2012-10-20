//
//  FairyMover.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FairyMover.h"
#import "InputComponent.h"

@implementation FairyMover

@synthesize go = _go;

-(id)initWithGameObject:(CCNode<GameObject> *)go
{
    [self init];
    
    self.go = go;
    
    CGSize s = [CCDirector sharedDirector].winSize;
    
    CGPoint centerOfScreen = ccp(s.width/2, s.height/2);
    
    self.go.position = centerOfScreen;
    
    return self;
}

-(void)update:(ccTime)dt
{
    //NSLog(@"FairyMover: update not implemented");
}

-(void)receive:(NSString *)message from:(id)sender
{
    //NSLog(@"FairyMover: received message: %@", message);
    
    // TODO: Figure out if controls can be interpreted better
    if( [message isEqualToString:@"device_motion_update"] )
    {
        if([sender isKindOfClass:[InputComponent class]])
        {
            InputComponent* ic = (InputComponent*)sender;
            
            double amplification = 10.0;
            double xRate = -ic.deviceMotion.rotationRate.x * amplification;
            double yRate = -ic.deviceMotion.rotationRate.y * amplification;
            
            CGPoint point = self.go.position;
            
            CGSize s = [CCDirector sharedDirector].winSize;
            CGPoint centerOfScreen = ccp(s.width/2, s.height/2);
            
            double maxDistanceFromCenter = 50;
            
            double xDist = point.x - centerOfScreen.x;
            double yDist = point.y - centerOfScreen.y;
            
            if(abs(xDist) > maxDistanceFromCenter)
            {
                if(abs(xDist + xRate) < abs(xDist))
                    point.x = point.x + xRate;
            }
            else point.x = point.x + xRate;
            
            if(abs(yDist) > maxDistanceFromCenter)
            {
                if(abs(yDist + yRate) < abs(yDist))
                    point.y = point.y + yRate;
            }
            else point.y = point.y + yRate;
            
            self.go.position = point;
        }
    }
}

-(void)jump
{
    NSLog(@"FairyMover: Jump!");
}

@end
