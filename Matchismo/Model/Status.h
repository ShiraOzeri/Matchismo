//
//  Status.h
//  Matchismo
//
//  Created by Shira Ozeri on 10/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
NS_ASSUME_NONNULL_BEGIN

@interface Status : NSObject

@property (strong,nonatomic) NSArray *chosenCards;
@property (nonatomic) NSInteger points;
@property (nonatomic) BOOL match;
@property (nonatomic,strong) Card *selectedCard;

- (instancetype)initWithCards:(NSArray *)chosenCards numberOfPoint:(NSInteger)points isMatch:(BOOL)match selectedCard:(Card *)card;


@end

NS_ASSUME_NONNULL_END
