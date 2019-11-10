//
//  Card.h
//  Matchismo
//
//  Created by Shira Ozeri on 28/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

-(NSInteger)match:(NSArray *)otherCard;

@end

NS_ASSUME_NONNULL_END
