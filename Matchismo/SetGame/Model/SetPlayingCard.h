//
//  SetPlayingCard.h
//  Matchismo
//
//  Created by Shira Ozeri on 06/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetPlayingCard : Card

- (instancetype)initWithNumber:(NSInteger )number
                         shape:(NSString *)shape
                       shading:(NSString *)shading
                         color:(NSString *)color;

+ (NSArray<NSString *> *)validShape;
+ (NSArray<NSNumber *> *)validNumberOfShape;
+ (NSArray<NSString *> *)validShading;
+ (NSArray<NSString *> *)validColor;

@property (nonatomic) NSInteger numberOfShape;
@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;

@end

NS_ASSUME_NONNULL_END
