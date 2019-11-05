//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Shira Ozeri on 30/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index; //gamePlayMode:(NSUInteger)mode;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger gamePlayMode;
@property (nonatomic) NSString *state;



@end

NS_ASSUME_NONNULL_END
