//
//  Card.m
//  Matchismo
//
//  Created by Shira Ozeri on 28/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "Card.h"


@interface Card()

@end

@implementation Card






-(int)match:(NSMutableArray *)otherCards
{
    int score=0;
    for(Card *card in otherCards){
        if([self.contents isEqualToString:card.contents]){
            score=1;
        }

    }
    return score;
}

@end
