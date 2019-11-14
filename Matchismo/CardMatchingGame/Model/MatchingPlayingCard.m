//
//  PlayingCard.m
//  Matchismo
//
//  Created by Shira Ozeri on 29/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "MatchingPlayingCard.h"

@implementation MatchingPlayingCard
@synthesize suit = _suit;
static const NSInteger kNumberOfChosenMatchCards = 2;

- (instancetype)initWithSuit:(NSString *)suit rank:(NSUInteger)rank {
  if (self = [super init]) {
    if ([[MatchingPlayingCard validSuits] containsObject:suit]) {
      _suit = suit;
    }
    if (rank <= [MatchingPlayingCard maxRank]) {
      _rank = rank;
    }
  }
  return self;
}

- (instancetype)initWithCard:(Card *)otherCard {
  if ([otherCard isKindOfClass:[MatchingPlayingCard class]]) {
    MatchingPlayingCard *matchCard = (MatchingPlayingCard *)otherCard;
    return [self initWithSuit:matchCard.suit rank:matchCard.rank];
  }
  return self;
}

- (NSString *)contents {
  return [NSString stringWithFormat:@"%@ %@",
          [[MatchingPlayingCard rankStrings] objectAtIndex:self.rank], self.suit];
}

+ (NSArray<NSString *> *)validSuits {
  return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray<NSString *> *)rankStrings {
  return @[@"?",@"A", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSInteger)maxRank {
  return [[MatchingPlayingCard rankStrings] count]-1;
}

- (NSString *)suit {
  return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit {
  if([[MatchingPlayingCard validSuits] containsObject:suit]){
    _suit = suit;
  }
}

- (void)setRank:(NSUInteger)rank {
  if (rank <= [MatchingPlayingCard maxRank]) {
    _rank = rank;
  }
}

- (NSInteger)match:(NSMutableArray *)otherCards{
  int score = 0;
  if (otherCards.count != kNumberOfChosenMatchCards) {
    return -1;
  }
  for (int i = 0; i < otherCards.count; i++) {
    for (int j = i + 1; j < otherCards.count; j++) {
      if ([[otherCards objectAtIndex:i] rank] == [[otherCards objectAtIndex:j] rank]) {
        score += 4;
      }
      if ([[otherCards objectAtIndex:i] suit] == [[otherCards objectAtIndex:j] suit]) {
        score += 1;
      }
    }
  }
  return score;
}

@end


