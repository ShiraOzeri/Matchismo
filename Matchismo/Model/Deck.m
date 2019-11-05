//
//  Deck.m
//  Matchismo
//
//  Created by Shira Ozeri on 29/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

-(NSMutableArray *)cards{
    if(!_cards) _cards=[[NSMutableArray alloc]init];
    return _cards;
}

-(void)addCard:(Card *)card{
    [self addCard:card atTop:NO];
    
}
-(void)addCard:(Card *)card atTop:(BOOL)atTop{
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    }
    else{
        [self.cards addObject:card];
    }
}


-(Card *)drawRandomCard{
    Card *randCard=nil;
    //if(!self.cards){
    if([self.cards count]){
        unsigned index=arc4random() % [self.cards count];
        randCard=self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randCard;
    
}

-(NSUInteger)countCard{
    return self.cards.count;
}


@end
