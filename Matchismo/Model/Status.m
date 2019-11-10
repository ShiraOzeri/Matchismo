//
//  Status.m
//  Matchismo
//
//  Created by Shira Ozeri on 10/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "Status.h"

@implementation Status

- (instancetype)initWithCards:(NSArray *)chosenCards numberOfPoint:(NSInteger)points isMatch:(BOOL)match selectedCard:(Card *)card{
    if(self=[super init]){
        self.chosenCards=chosenCards;
        self.match=match;
        self.points=points;
        self.selectedCard=card;
    }
    return self;
}




@end
