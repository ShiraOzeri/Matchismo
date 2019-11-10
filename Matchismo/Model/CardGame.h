//
//  CardGame.h
//  Matchismo
//
//  Created by Shira Ozeri on 06/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"
#import "Status.h"


NS_ASSUME_NONNULL_BEGIN

@interface CardGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) NSInteger score;
//@property (nonatomic) NSString *state;
@property (nonatomic,strong) Status *status;

@end

NS_ASSUME_NONNULL_END
