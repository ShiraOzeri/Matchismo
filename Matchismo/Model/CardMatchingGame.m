//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Shira Ozeri on 30/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,getter=isStateChange) BOOL stateChange;



@end

@implementation CardMatchingGame




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

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define COST_TO_CHOOSE 1;

-(Card *)cardAtIndex:(NSUInteger)index{
    return (index<self.cards.count)? self.cards[index]: nil;
}

-(void)chooseCardAtIndex:(NSUInteger)index{
    self.stateChange=NO;
    Card *card=[self cardAtIndex:index];
    NSMutableArray *chosenCards=[[NSMutableArray alloc]init];
    
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen=NO;
        }
        else{
            for (Card *otherCard in self.cards) {
                if(otherCard.chosen && !otherCard.matched){
                    [chosenCards addObject:otherCard];
                    
                }
            }
            if((self.gamePlayMode==2 && chosenCards.count==1) || (self.gamePlayMode==3 && chosenCards.count==2)){
                int matchScore=[card match:chosenCards];
                if(matchScore){
                    self.score+=matchScore*MATCH_BONUS;
                    card.matched=YES;
                    
                    for (Card *otherCard in chosenCards) {
                        otherCard.matched=YES;
                    }
                    self.state=[[NSString alloc] initWithFormat:@"Matched %@ for %d points ",([self stringOfChosenCards:chosenCards andChosenCard:card]),matchScore*MATCH_BONUS];
                    self.stateChange=YES;
                
                    
                }
                else{
                    for (Card *otherCard in chosenCards) {
                        otherCard.chosen=NO;
                    }
                    self.score-=MISMATCH_PENALTY;
                    self.state=[[NSString alloc] initWithFormat:@"%@ don't match! %d point penalty ",([self stringOfChosenCards:chosenCards andChosenCard:card]),MISMATCH_PENALTY];
                    self.stateChange=YES;
                }
            }
            card.chosen=YES;
            self.score-=COST_TO_CHOOSE;
            if(!self.isStateChange){
                self.state=[[NSString alloc] initWithFormat:@"%@ one point penalty",card.contents];
                self.stateChange=YES;

            }
        }
        
    }
    if(!self.isStateChange) self.state=@" ";
    
}

-(NSString *)stringOfChosenCards:(NSMutableArray *)chosenCards andChosenCard:(Card *)card{
    NSString *stateChosenCards=card.contents;//[[NSString alloc]init];
    for (Card *otherCard in chosenCards) {
        stateChosenCards=[stateChosenCards stringByAppendingString:(otherCard.contents)];
        
    }
    return stateChosenCards;
}

@end
