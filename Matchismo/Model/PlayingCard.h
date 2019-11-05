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

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSInteger)maxRank;

@end



NS_ASSUME_NONNULL_END
