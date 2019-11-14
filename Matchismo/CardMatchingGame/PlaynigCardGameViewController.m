//
//  PlaynigCardGameViewController.m
//  Matchismo
//
//  Created by Shira Ozeri on 05/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "PlaynigCardGameViewController.h"
#import "Card.h"
#import "CardMatchingGame.h"
#import "MatchingViewCard.h"
#import "PlayingCardDeck.h"

@implementation PlaynigCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (CardGame *)createGame:(Deck *)deck count:(NSInteger)count {
    return [[CardMatchingGame alloc] initWithCardCount:count usingDeck:deck];
}

- (ViewCard *) createViewCard:(Card *)card atRect:(CGRect )rect {
    MatchingViewCard *cardMatchGame = [[MatchingViewCard alloc] initWithFrame:rect];
    [cardMatchGame setCard:card];
    return cardMatchGame;
}

//override
- (NSUInteger) initWithNumberOfCard{
    return 16;
}

- (NSInteger) numOfMoreCards{
    return 2;
}

@end
