//
//  LevelBuilder.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelBuilder.h"
#import "XMLReader/XMLReader.h"

// Import a bunch of GameObjects
#import "Player.h"
#import "Fairy.h"
#import "FairyHelper.h"
#import "Obstacle.h"
#import "ShortRamp.h"
#import "MediumRamp.h"
#import "LongRamp.h"
#import "Crystal.h"

// TODO: Use NSXMLParser to load level from data file!

@implementation LevelBuilder

+(LevelLayer*) createLevel:(NSString*)levelName
{
    LevelLayer *level = [[LevelLayer alloc] init];
    
    Player* _player;
    Fairy* _fairy;
    FairyHelper* _fairyHelper;
    Fairy* _cameraTarget;
    
    // TODO: Better background-code
    CCSprite *bg = [CCSprite spriteWithFile:@"background-cave-1.png"];
    [level addChild:bg];
    [bg runAction:[CCFollow actionWithTarget:level]];
    
    
    NSLog(@"CameraTarget creation start...");
    // Little bit of player code
    _cameraTarget = [[Fairy alloc] initWithLevel:level];
    NSLog(@"... add CameraTarget sprite to layer...");
    _cameraTarget.graphicsComponent.sprite.opacity = 0;
    [level addChild:_cameraTarget.graphicsComponent.sprite];
    NSLog(@"... CameraTarget code end.");
    [level runAction:[CCFollow actionWithTarget:_cameraTarget.graphicsComponent.sprite]];
    
    
    NSLog(@"FairyHelper creation start...");
    // Little bit of player code
    _fairyHelper = [[FairyHelper alloc] initWithLevel:level];
    NSLog(@"... add FairyHelper sprite to layer...");
    [level addChild:_fairyHelper.graphicsComponent.sprite];
    NSLog(@"... FairyHelper code end.");
    
    
    
    NSLog(@"Fairy creation start...");
    // Little bit of player code
    _fairy = [[Fairy alloc] initWithLevel:level];
    NSLog(@"... add FollowerMover target...");
    _fairy.moverComponent.targetGo = _fairyHelper;
    NSLog(@"... add Fairy sprite to layer...");
    _fairy.graphicsComponent.sprite = [CCSprite spriteWithFile:@"star.png"];
    [level addChild:_fairy.graphicsComponent.sprite];
    NSLog(@"... Fairy code end.");

    
    
    
    // Load XML
    NSDictionary *levelDictionary = [self loadFromXML:@"Level_Level1"];
    
    // Get sprites from dictionary
    NSArray *spriteDictionary = [[[levelDictionary objectForKey:@"level"] objectForKey:@"layer"] objectForKey:@"sprite"];
    
    
    // Check the classes!
    for(NSDictionary *element in spriteDictionary)
    {
        NSLog(@"%@", element);
        
        NSString *name = [element objectForKey:@"name"];
        NSString *x = [element objectForKey:@"x"];
        NSString *y = [element objectForKey:@"y"];
        
        NSString *scaleX = @"1.0";
        if ([[element objectForKey:@"flip"] isEqualToString:@"true"]) {
             scaleX = @"-1.0";
        }

        NSString *rotation = [element objectForKey:@"angle"];

        x = (x == nil) ? @"0" : x;
        y = (y == nil) ? @"0" : y;
        scaleX = (scaleX == nil) ? @"1.0" : scaleX;
        rotation = (rotation == nil) ? @"0.0" : rotation;
        
        if([name isEqualToString:@"LongWedge"])
        {
            LongRamp *o = [LongRamp alloc];
            o.position = ccp([x intValue] / 2, -[y intValue] / 2);
            o.rotation = [rotation floatValue];
            o.scaleX = [scaleX floatValue];
            [o initWithLevel:level];
            [level addChild:o.graphicsComponent.sprite];
            
            level.gameObjects = [level.gameObjects arrayByAddingObject:o];
        }
        else if([name isEqualToString:@"MediumWedge"])
        {
            MediumRamp *o = [MediumRamp alloc];
            o.position = ccp([x intValue] / 2, -[y intValue] / 2);
            o.rotation = [rotation floatValue];
            o.scaleX = [scaleX floatValue];
            [o initWithLevel:level];
            [level addChild:o.graphicsComponent.sprite];
            
            level.gameObjects = [level.gameObjects arrayByAddingObject:o];
        }
        else if([name isEqualToString:@"ShortWedge"])
        {
            ShortRamp *o = [ShortRamp alloc];
            o.position = ccp([x intValue] / 2, -[y intValue] / 2);
            o.rotation = [rotation floatValue];
            o.scaleX = [scaleX floatValue];
            [o initWithLevel:level];
            [level addChild:o.graphicsComponent.sprite];
            
            level.gameObjects = [level.gameObjects arrayByAddingObject:o];
        }
        else if([name isEqualToString:@"Block"])
        {
            Obstacle *o = [Obstacle alloc];
            o.position = ccp([x intValue] / 2, -[y intValue] / 2);
            o.rotation = [rotation floatValue];
            o.scaleX = [scaleX floatValue];
            [o initWithLevel:level];
            [level addChild:o.graphicsComponent.sprite];
            
            level.gameObjects = [level.gameObjects arrayByAddingObject:o];
        }
        else if([name isEqualToString:@"Player"])
        {
            NSLog(@"Player creation start...");
            // Little bit of player code
            _player = [Player alloc];
            _player.position = ccp([x intValue] / 2, -[y intValue] / 2);
            _player.rotation = [rotation floatValue];
            _player.scaleX = [scaleX floatValue];
            [_player initWithLevel:level];
            NSLog(@"... add Player sprite to layer...");
            [level addChild:_player.graphicsComponent.sprite];
            NSLog(@"... Player code end.");
        }
        else if([name isEqualToString:@"Crystal"])
        {
            Crystal *o = [Crystal alloc];
            o.position = ccp([x intValue] / 2, -[y intValue] / 2);
            o.rotation = [rotation floatValue];
            o.scaleX = [scaleX floatValue];
            [o initWithLevel:level];
            [level addChild:o.graphicsComponent.sprite];
            
            level.gameObjects = [level.gameObjects arrayByAddingObject:o];
        }
        
        
        
        // x, y, scaleX, image, rotation
        NSLog(@"Sprite: %@, %@, %@, %@, %@", name, x, y, scaleX, rotation);
    }

    
    if(_player == nil)
    {
        NSLog(@"Player creation start...");
        // Little bit of player code
        _player = [[Player alloc] initWithLevel:level];
        NSLog(@"... add Player sprite to layer...");
        [level addChild:_player.graphicsComponent.sprite];
        NSLog(@"... Player code end.");
    }
    
    
    NSLog(@"... add FollowerMover target...");
    _cameraTarget.moverComponent.targetGo = _player;
    NSLog(@"... add Player's PlayerPhysicsMover as listener...");
    [_fairy.courierComponent addListener:_player.moverComponent];
    NSLog(@"... add FairyHelper's MoverComponent as listener...");
    [_player.courierComponent addListener:_fairyHelper.moverComponent];


    // Attach all objects to the level's array of objects    
    level.gameObjects = [level.gameObjects arrayByAddingObject:_player];
    level.gameObjects = [level.gameObjects arrayByAddingObject:_fairyHelper];
    level.gameObjects = [level.gameObjects arrayByAddingObject:_fairy];
    level.gameObjects = [level.gameObjects arrayByAddingObject:_cameraTarget];
    
    return level;
}

+(NSDictionary*) loadFromXML:(NSString*)fileName
{
    NSDictionary *dictionary = nil;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    if(!data)
        NSLog(@"[loadFromXML:@\"%@.xml\"]: No data.", fileName);
    else
    {
        NSString *xmlString = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSUTF8StringEncoding];
        
        // Parse the XML into a dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:xmlString error:&parseError];
        
        dictionary = xmlDictionary;
    }
    
    return dictionary;
}

+(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"<%@>", elementName);
}

+(void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"Started parsing");
}

+(void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"Ended parsing");
}

+ (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"ERROR:%@", [parseError localizedDescription]);
}

+ (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"</%@>", elementName);
}

+ (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"%@", string);
}

@end
