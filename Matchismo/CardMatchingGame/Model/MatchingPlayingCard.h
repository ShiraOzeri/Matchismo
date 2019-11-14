//
//  PlayingCard.h
//  Matchismo
//
//  Created by Shira Ozeri on 29/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatchingPlayingCard : Card

+ (NSArray<NSString *> *)validSuits;
+ (NSInteger)maxRank;

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

@end

NS_ASSUME_NONNULL_END

