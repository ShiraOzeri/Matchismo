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

@property (nonatomic) NSInteger numberOfShape;
@property (strong, nonatomic) NSString *shape;
@property (nonatomic) float shading;
@property (strong, nonatomic) NSString *color;


- (instancetype)initWithNumber:(NSInteger )number
                        shape:(NSString *)shape shading:(float)shading color:(NSString *)color;

+ (NSArray *)validShape;
+ (NSArray *)validNumberOfShape;
+ (NSArray *)validShading;
+ (NSArray *)validColor;




@end

NS_ASSUME_NONNULL_END
