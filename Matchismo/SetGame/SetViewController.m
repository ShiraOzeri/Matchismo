//
//  SetViewController.m
//  Matchismo
//
//  Created by Shira Ozeri on 07/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "SetViewController.h"
#import "PlayingSetDeck.h"
#import "SetGame.h"
#import "SetViewCard.h"

@implementation SetViewController

- (Deck *)createDeck {
  return [[PlayingSetDeck alloc] init];
}

- (CardGame *)createGame:(Deck *)deck count:(NSInteger) count {
  return [[SetGame alloc] initWithCardCount:count usingDeck:deck];
}

- (ViewCard *) createViewCard:(Card *)card atRect:(CGRect )rect {
  SetViewCard *setViewCard=[[SetViewCard alloc] initWithFrame:rect];
  [setViewCard setCard:card];
  return setViewCard;
}

//override
- (NSUInteger) initWithNumberOfCard {
  return 12;
}

- (NSInteger) numOfMoreCards {
  return 3;
}

@end
