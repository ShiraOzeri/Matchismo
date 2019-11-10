//
//  PlayingSetDeck.m
//  Matchismo
//
//  Created by Shira Ozeri on 06/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "PlayingSetDeck.h"
#import "SetPlayingCard.h"

@implementation PlayingSetDeck

-(instancetype)init{
    if([super init]){
        for(NSNumber *number in [SetPlayingCard validNumberOfShape]){
            for (NSString *shape in [SetPlayingCard validShape]) {
                for (NSNumber *shading in [SetPlayingCard validShading]) {
                    for (NSString *color in [SetPlayingCard validColor]) {
                        SetPlayingCard *card=[[SetPlayingCard alloc] initWithNumber:[number integerValue] shape:shape shading:[shading floatValue] color:color];
                        [self addCard:card];
                    }
                }
                
            }
            
            
        }
    }
    return self;
    
}

@end
