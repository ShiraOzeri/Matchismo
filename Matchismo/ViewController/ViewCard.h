//
//  ViewCard.h
//  Matchismo
//
//  Created by Shira Ozeri on 12/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewCard : UIView

- (CGFloat)cornerScaleFactor;
- (CGFloat)cornerRadius;
- (CGFloat)cornerOffset;
- (void)displayFaceCard;
- (void)displayBackCard;

@property (nonatomic, strong) Card *card;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) CGFloat faceCardScaleFactor;
@property (nonatomic) BOOL inBoard;

@end

NS_ASSUME_NONNULL_END
