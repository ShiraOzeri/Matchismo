//
//  SetPlayingCard.m
//  Matchismo
//
//  Created by Shira Ozeri on 06/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "SetPlayingCard.h"

@implementation SetPlayingCard

static const NSInteger kNumberOfChosenMatchCards = 3;

- (NSString *)contents {
  return [NSString stringWithFormat:@"[%ld, %@, %@, %@]",
          (long)self.numberOfShape, self.shape, self.shading, self.color];
}

- (instancetype)initWithNumber:(NSInteger )number
                         shape:(NSString *)shape shading:(NSString *)shading
                         color:(NSString *)color{
  if (self = [super init]) {
    if ([[SetPlayingCard validShape] containsObject:shape]) {
      self.shape = shape;
    } if ([[SetPlayingCard validShading] containsObject:shading]) {
      self.shading = shading;
    } if ([[SetPlayingCard validNumberOfShape] containsObject:@(number)]) {
      self.numberOfShape = number;
    } if([[SetPlayingCard validColor] containsObject:color]){
      self.color = color;
    }
  }
  return self;
}

- (instancetype)initWithCard:(Card *)otherCard {
  if ([otherCard isKindOfClass:[SetPlayingCard class]]) {
    SetPlayingCard *setCard = (SetPlayingCard *)otherCard;
    return [self initWithNumber:setCard.numberOfShape shape:setCard.shape
                        shading:setCard.shading color:setCard.color];
  }
  return self;
}

+ (NSArray<NSString *> *)validShape {
  return @[@"squiggle",@"diamond",@"oval"];
}

+ (NSArray<NSNumber *> *)validNumberOfShape {
  return @[@1,@2,@3];
}

+ (NSArray<NSString *> *)validShading {
  return @[@"solid", @"striped",@"unfilled"];
}

+ (NSArray<NSString *> *)validColor {
  return @[@"RED",@"GREEN",@"PURPLE"];
}

- (NSInteger)match:(NSMutableArray *)otherCards {
  NSInteger score=1;
  if (!(otherCards.count == kNumberOfChosenMatchCards)) {
    return -1;
  }
  if ( (![self matchByColor:otherCards]) || (![self matchByshape:otherCards]) ||
      (![self matchByShading:otherCards]) || (![self matchByNumber:otherCards])) {
    return 0;
  }
  return score;
}

- (BOOL)matchByColor:(NSArray<SetPlayingCard *> *)otherCards {
  NSSet *setOfColor = [NSSet setWithObjects:[otherCards[0] color],
                       [otherCards[1] color],[otherCards[2] color], nil];
  if (setOfColor.count ==2 ) {
    return NO;
  }
  return YES;
}

- (BOOL)matchByNumber:(NSArray<SetPlayingCard *> *)otherCards {
  NSSet *setOfNumber = [NSSet setWithObjects:@([otherCards[0] numberOfShape]),
                        @([otherCards[1] numberOfShape]), @([otherCards[2] numberOfShape]), nil];
  if (setOfNumber.count == 2) {
    return NO;
  }
  return YES;
  
}

- (BOOL)matchByshape:(NSArray<SetPlayingCard *> *)otherCards {
  NSSet *setOfshape = [NSSet setWithObjects:[otherCards[0] shape],
                       [otherCards[1] shape],[otherCards[2] shape], nil];
  if (setOfshape.count == 2) {
    return NO;
  }
  return YES;
  
}
- (BOOL)matchByShading:(NSArray<SetPlayingCard *> *)otherCards {
  NSSet *setOfshading = [NSSet setWithObjects:[otherCards[0] shading],
                         [otherCards[1] shading],[otherCards[2] shading], nil];
  if (setOfshading.count == 2) {
    return NO;
  }
  return YES;
  
}





@end
