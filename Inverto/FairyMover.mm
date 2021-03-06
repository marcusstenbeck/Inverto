//
//  FairyMover.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

// TODO: This class translates rotation rate to input suitable for controls

#import "FairyMover.h"
#import "InputComponent.h"


// Needed for level representation
// TODO: Don't depend on HelloWorldLayer!
#import "LevelLayer.h"


@implementation FairyMover

@synthesize go = _go;

-(id)initWithGameObject:(CCNode<GameObject> *)go
{
    [self init];
    
    self.go = go;
    
    CGSize s = [CCDirector sharedDirector].winSize;
    
    _centerPoint = ccp(s.width/2, s.height/2);
    
    self.go.position = _centerPoint;
    
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
            
            
            /*
            double amplification = 10.0;
            double xRate = -ic.deviceMotion.rotationRate.x * amplification;
            double yRate = -ic.deviceMotion.rotationRate.y * amplification;
            
            CGPoint point = self.go.position;
            
            double maxDistanceFromCenter = 100;
            
            double xDist = point.x - _centerPoint.x;
            double yDist = point.y - _centerPoint.y;
            
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
            */
            
            
            CGPoint point = self.go.position;
            
            double angle = (ic.deviceMotion.attitude.pitch * 180.0) / M_PI;
            double maxAngle = 7.0;
            //NSLog(@"angle: %f", angle);
            // Map value between [0, 1]
            double angleSign = angle > 0.0 ? 1.0 : (angle < 0.0 ? -1.0 : 0.0);
            angle = angle*angleSign < maxAngle ? angle / maxAngle : 1.0 * angleSign;
            
            //NSLog(@"angle: %f, angleSign: %f", angle, angleSign);
            point.x = _centerPoint.x -96*angle;
            
            
            
            self.go.position = point;
        }
    }
    

    if( [message isEqualToString:@"player_update_position"] )
    {
        //NSLog(@"(%@) received \"%@\" from %@(%@)", self.go, message, sender, ((CCNode<GameComponent>*)sender).go);
        
        if( [sender conformsToProtocol:@protocol(GameComponent)] )
        {
            CCNode<GameComponent> *gc = (CCNode<GameComponent>*)sender;
            
            CGPoint delta = ccp(gc.go.position.x - _centerPoint.x, gc.go.position.y - _centerPoint.y);
            
            self.go.position = ccp(self.go.position.x + delta.x, self.go.position.y + delta.y);
            
            _centerPoint = gc.go.position;
        }
        
    }
}

-(CGPoint)relativePosition
{
    CGPoint p;
    
    p.x = self.go.position.x - _centerPoint.x;
    p.y = self.go.position.y - _centerPoint.y;
    
    return p;
}

-(void)jump
{
    NSLog(@"FairyMover: Jump!");
}

@end
