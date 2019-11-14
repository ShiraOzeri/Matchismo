//
//  Card.m
//  Matchismo
//
//  Created by Shira Ozeri on 28/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "Card.h"

@implementation Card

- (instancetype)initWithCard:(Card *)otherCard {
    if (self = [super init]) {
        _contents=otherCard.contents;
        _matched=otherCard.matched;
        _chosen=otherCard.chosen;
    }
    return self;
}

- (NSInteger)match:(NSMutableArray *)otherCards {
    int score = 0;
    for (Card *card in otherCards) {
        if ([self.contents isEqualToString:card.contents]) {
            score=1;
        }
    }
    return score;
}

@end
