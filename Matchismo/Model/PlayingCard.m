//
//  PlayingCard.m
//  Matchismo
//
//  Created by Shira Ozeri on 29/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit=_suit;

-(NSString *)contents{
    return [NSString stringWithFormat:@"%@ %@", [[PlayingCard rankStrings] objectAtIndex:self.rank], self.suit];
}

+(NSArray *)validSuits{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+(NSArray *)rankStrings{
    return @[@"?",@"A", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSInteger)maxRank{
    return [[PlayingCard rankStrings] count]-1;
}


-(NSString *)suit{
    return _suit ? _suit : @"?";
}

-(void)setSuit:(NSString *)suit{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit=suit;
    }
}

-(void)setRank:(NSUInteger)rank{
    if(rank<= [PlayingCard maxRank]){
        _rank=rank;
    }
}

-(int)match:(NSMutableArray *)otherCards
{
    int score=0;
    [otherCards addObject:self];

    for (int i=0; i<otherCards.count; i++) {
        for (int j=i+1; j<otherCards.count; j++) {
            if([[otherCards objectAtIndex:i] rank]==[[otherCards objectAtIndex:j] rank])
                score+=4;
            if([[otherCards objectAtIndex:i] suit]==[[otherCards objectAtIndex:j] suit]){
                score+=1;
            }
        }
        
        
        
    }
    [otherCards removeObject:self];
    return score;
}

@end


