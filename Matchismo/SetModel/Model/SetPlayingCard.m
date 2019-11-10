//
//  SetPlayingCard.m
//  Matchismo
//
//  Created by Shira Ozeri on 06/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "SetPlayingCard.h"

@interface SetPlayingCard ()
# define NUM_OF_CHOSEN_MATCH_CARDS 3

@end

@implementation SetPlayingCard

-(NSString *)contents{
    
    return [NSString stringWithFormat:@"[%ld, %@, %f, %@]",(long)self.numberOfShape,self.shape,self.shading, self.color];
    
}


- (instancetype)initWithNumber:(NSInteger )number
                         shape:(NSString *)shape shading:(float)shading color:(NSString *)color{
    if([super init]){
        if([[SetPlayingCard validShape] containsObject:shape]){
            self.shape=shape;
        }if([[SetPlayingCard validNumberOfShape] containsObject:@(number)]){
            self.numberOfShape=number;
            
        }if([[SetPlayingCard validShading] containsObject:@(shading)]){
            self.shading=shading;
            
        }if([[SetPlayingCard validColor] containsObject:color]){
            self.color=color;
            
        }
        
        
    }
    return self;
}
+ (NSArray *)validShape{
    return @[@"▲",@"●",@"■"];
}

+ (NSArray *)validNumberOfShape{
    return @[@1,@2,@3];
}

+ (NSArray *)validShading{
    return @[@0.25, @0.5, @1];
}

+ (NSArray *)validColor{
    return @[@"RED",@"GREEN",@"PURPLE"];
}


- (NSInteger)match:(NSMutableArray *)otherCards{
    
    //NSMutableArray *cards=[[NSMutableArray alloc]initWithArray:otherCards copyItems:YES];
//    Card *card=[[Card alloc]init];
//    card.matched=self.
//    NSMutableArray *cards=[[NSMutableArray alloc]initWithArray:otherCards];
//    [cards addObject:self];
    NSInteger score=1;
    //[otherCards addObject:self];

    if(!(otherCards.count==NUM_OF_CHOSEN_MATCH_CARDS)){
        //[otherCards removeObject:self];
        return -1;
    }
    
    if(![self matchByColor:otherCards]){
       // [otherCards removeObject:self];
        return 0;
    }
    if(![self matchByshape:otherCards]){
        //[otherCards removeObject:self];
        return 0;
    }
    if(![self matchByShading:otherCards]){
       // [otherCards removeObject:self];
        return 0;
        
    }
    if(![self matchByNumber:otherCards]){
       // [otherCards removeObject:self];
        return 0;
    }
   // [otherCards removeObject:self];
    return score;
}

- (BOOL)matchByColor:(NSArray *)otherCards{
    NSSet *setOfColor=[NSSet setWithObjects:[otherCards[0] color],[otherCards[1] color],[otherCards[2] color], nil];
    if(setOfColor.count==2) return NO;
    return YES;
    
}

- (BOOL)matchByNumber:(NSArray *)otherCards{
    NSSet *setOfNumber=[NSSet setWithObjects:@([otherCards[0] numberOfShape]),@([otherCards[1] numberOfShape]),@([otherCards[2] numberOfShape]), nil];
    if(setOfNumber.count==2) return NO;
    return YES;
    
}
- (BOOL)matchByshape:(NSArray *)otherCards{
    NSSet *setOfshape=[NSSet setWithObjects:[otherCards[0] shape],[otherCards[1] shape],[otherCards[2] shape], nil];
    if(setOfshape.count==2) return NO;
    return YES;
    
}
- (BOOL)matchByShading:(NSArray *)otherCards{
    NSSet *setOfshading=[NSSet setWithObjects:@([otherCards[0] shading]),@([otherCards[1] shading]),@([otherCards[2] shading]), nil];
    if(setOfshading.count==2) return NO;
    return YES;
    
}





@end
