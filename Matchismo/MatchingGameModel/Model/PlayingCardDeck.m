//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Shira Ozeri on 29/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "MatchingPlayingCard.h"

@implementation PlayingCardDeck

-(instancetype)init{
    self=[super init];
    if(self){
        for(NSString *suit in [MatchingPlayingCard validSuits ]){
            for(NSUInteger rank=1; rank<=[MatchingPlayingCard maxRank];rank++){
                MatchingPlayingCard *card=[[MatchingPlayingCard alloc]init];
                card.rank=rank;
                card.suit=suit;
                [self addCard:card];
            }
        }
    }
    return self;
    
}

@end
