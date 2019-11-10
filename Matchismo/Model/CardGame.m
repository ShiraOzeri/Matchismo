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
@property (nonatomic,getter=isFlagStateChange) BOOL flagStateChange;

@end

@implementation CardGame


static const NSInteger kMatchBonus = 4;
static const NSInteger kCostToChoose = 1;
static const NSInteger kMismatchPenalty = 2;



-(NSMutableArray *)cards{
    if(!_cards) _cards=[[NSMutableArray alloc]init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    //    self=[super init];
    if(self=[super init]){
        for(int i=0;i<count;i++){
            Card *card=deck.drawRandomCard;
            if(card)
                self.cards[i]=card;
            else{
                self=nil;
                break;
            }
        }
    }
    return self;
}


-(Card *)cardAtIndex:(NSUInteger)index{
    return (index<self.cards.count)? self.cards[index]: nil;
}

//create array of the choosen cards

- (NSMutableArray *)getChosenCards{
    NSMutableArray *chosen=[[NSMutableArray alloc] init];
    for (Card *otherCard in self.cards) {
        if(otherCard.chosen && !otherCard.matched){
            [chosen addObject:otherCard];
            
        }
    }
    return chosen;
    
}

-(void)chooseCardAtIndex:(NSUInteger)index{
    self.flagStateChange=NO;
    Card *card = [self cardAtIndex:index];
    NSMutableArray *chosenCards;
    self.status=[[Status alloc] initWithCards:chosenCards numberOfPoint:0 isMatch:NO selectedCard:card];
    if(!card.isMatched){
        if (card.isChosen) {
            card.chosen=NO;

        }
        else {
            chosenCards = [self getChosenCards];
            NSMutableArray *allChosenCards=[[NSMutableArray alloc] initWithArray:chosenCards];
            [allChosenCards addObject:card];
            NSInteger matchScore = [card match:allChosenCards];
            self.status.chosenCards=allChosenCards;

            if (allChosenCards.count == [self numberOfValidMatch]){
                //[allChosenCards addObject:card];
                
                if (matchScore > 0) {
                    self.score+=matchScore*kMatchBonus;
                    [self changeCardToMatch:allChosenCards];
                    self.status.match=YES;
                    self.status.points = (matchScore*(kMatchBonus));
                    card.chosen=YES;
                }
                else {
                    [self changeCardToNoChosen:chosenCards];
                    self.score-=kMismatchPenalty;
                    self.status.match = NO;
                    self.status.points = kMismatchPenalty;
                    self.flagStateChange=YES;
                    card.chosen=YES;
                }
            } else {
                card.chosen=YES;
                self.status.match = NO;
                self.status.points = kCostToChoose;
            }
            self.score-=kCostToChoose;
//
        }
    }
    
}

-(NSInteger)numberOfValidMatch{
    return 0;
}


- (void)changeCardToMatch:(NSMutableArray *)chosenCards{
    for (Card *otherCard in chosenCards) {
        otherCard.matched=YES;
    }
}

- (void)changeCardToNoChosen:(NSMutableArray *)chosenCards{
    for (Card *otherCard in chosenCards) {
        otherCard.chosen=NO;
    }
}

@end
