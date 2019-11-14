//
//  CardGame.m
//  Matchismo
//
//  Created by Shira Ozeri on 06/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "CardGame.h"

@interface CardGame()

@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic,readwrite) NSInteger score;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) NSArray<Card *> *chosenCards;

@end

@implementation CardGame

static const NSInteger kMatchBonus = 4;
static const NSInteger kCostToChoose = 1;
static const NSInteger kMismatchPenalty = 2;

- (NSMutableArray *)cards {
  if(!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
  self.deck = deck;
  if (self = [super init]) {
    for (int i = 0; i < count; i++) {
      Card *card = [self.deck drawRandomCard];
      if(card) {
        self.cards[i]=card;
      } else {
        self = nil;
        break;
      }
    }
  }
  return self;
}

- (Card *)addCard {
  Card *card = [self.deck drawRandomCard];
  if (card) {
    self.cards[[self.cards count]] = card;
  } else {
    return nil;
  }
  return card;
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index < self.cards.count) ? self.cards[index] : nil;
}

//create array of the choosen cards
- (NSMutableArray *)getChosenCards {
  NSMutableArray *chosen = [[NSMutableArray alloc] init];
  for (Card *otherCard in self.cards) {
    if (otherCard.chosen && !otherCard.matched) {
      [chosen addObject : otherCard];
    }
  }
  return chosen;
}

- (NSInteger)indexOfCard:(Card *)card {
  return [self.cards indexOfObject:card];
}

- (void)chooseCardAtIndex:(NSUInteger)index {
  Card *card = [self cardAtIndex:index];
  [self chooseCard:card];
}

- (BOOL)chooseCard:(Card *)card {
  NSMutableArray *chosenCards;
  if (card.isMatched){
    return NO;
  }
  if (card.isChosen) {
    card.chosen=NO;
    return NO;
  } else {
    chosenCards = [self getChosenCards];
    NSMutableArray *allChosenCards = [[NSMutableArray alloc] initWithArray:chosenCards];
    [allChosenCards addObject:card];
    NSInteger matchScore = [card match:allChosenCards];
    if (allChosenCards.count == [self numberOfValidMatch]) {
      if (matchScore > 0) {
        self.score += matchScore*kMatchBonus;
        [self changeCardToMatch:allChosenCards];
        card.chosen=YES;
        self.score -= kCostToChoose;
        return YES;
      } else {
        [self changeCardToNoChosen : chosenCards];
        self.score -= kMismatchPenalty;
        card.chosen=YES;
      }
    } else {
      card.chosen = YES;
    }
    self.score -= kCostToChoose;
  }
  return NO;
}

- (NSInteger)numberOfValidMatch {
  return 0;
}

- (void)changeCardToMatch:(NSMutableArray *)chosenCards {
  for (Card *otherCard in chosenCards) {
    otherCard.matched = YES;
  }
}

- (void)changeCardToNoChosen:(NSMutableArray *)chosenCards {
  for (Card *otherCard in chosenCards) {
    otherCard.chosen = NO;
  }
}

@end
