//
//  SetViewCard.m
//  Matchismo
//
//  Created by Shira Ozeri on 12/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "SetViewCard.h"
#import "SetPlayingCard.h"

@interface SetViewCard()
@property (nonatomic, strong) SetPlayingCard *card;
@end

@implementation SetViewCard
@synthesize card=_card;

static const NSInteger kroundedRectRadius = 100;
static const float kShapeHeight = 0.2;
static const float kShapeWidth = 0.8;
static const float kStripedDistance = 0.1;

- (void)setCard:(Card *)card {
  _card = (SetPlayingCard *)card;
  [self setNeedsDisplay];
}

- (UIBezierPath *)drawDiamondAtPoint:(CGPoint)point {
  CGSize size = CGSizeMake(self.bounds.size.width * kShapeWidth,
                           self.bounds.size.height * kShapeHeight);
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(size.width/2, 0)];
  [path addLineToPoint:CGPointMake(size.width,size.height/2)];
  [path addLineToPoint:CGPointMake(size.width/2,size.height)];
  [path addLineToPoint:CGPointMake(0,size.height/2)];
  [path closePath];
  [path applyTransform:CGAffineTransformMakeTranslation(point.x - size.width/2 ,
                                                        point.y - size.height/2 )];
  return path;
}

- (UIBezierPath *)drawOvalAtPoint:(CGPoint)point {
  CGRect imageRect = CGRectMake(point.x-(self.bounds.size.width * kShapeWidth)/2,
                                point.y-(self.bounds.size.height * kShapeHeight)/2,
                                self.bounds.size.width * kShapeWidth,
                                self.bounds.size.height * kShapeHeight);
  UIBezierPath *rondedRect=[UIBezierPath bezierPathWithRoundedRect:imageRect
                                                      cornerRadius:kroundedRectRadius];
  return rondedRect;
}

- (UIBezierPath *)drawSquiggleAtPoint:(CGPoint)point {
  CGSize size = CGSizeMake(self.bounds.size.width * kShapeWidth,
                           self.bounds.size.height * kShapeHeight);
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(104, 15)];
  [path addCurveToPoint:CGPointMake(63, 54) controlPoint1:CGPointMake(112.4, 36.9)
          controlPoint2:CGPointMake(89.7, 60.8)];
  [path addCurveToPoint:CGPointMake(27, 53) controlPoint1:CGPointMake(52.3, 51.3)
          controlPoint2:CGPointMake(42.2, 42)];
  [path addCurveToPoint:CGPointMake(5, 40) controlPoint1:CGPointMake(9.6, 65.6)
          controlPoint2:CGPointMake(5.4, 58.3)];
  [path addCurveToPoint:CGPointMake(36, 12) controlPoint1:CGPointMake(4.6, 22)
          controlPoint2:CGPointMake(19.1, 9.7)];
  [path addCurveToPoint:CGPointMake(89, 14) controlPoint1:CGPointMake(59.2, 15.2)
          controlPoint2:CGPointMake(61.9, 31.5)];
  [path addCurveToPoint:CGPointMake(104, 15) controlPoint1:CGPointMake(95.3, 10)
          controlPoint2:CGPointMake(100.9, 6.9)];
  [path applyTransform:CGAffineTransformMakeScale(0.9524*size.width/100, 0.9524*size.height/50)];
  [path applyTransform:
   CGAffineTransformMakeTranslation(point.x - size.width/2 - 3 * size.width/100,
                                    point.y - size.height/2 - 8 * size.height/50)];
  return path;
}

- (UIBezierPath *)drawshapeAtPoint:(float)yPosition {
  UIBezierPath *shape;
  if([self.card.shape isEqualToString:@"oval"]) {
    return [self drawOvalAtPoint:CGPointMake(self.bounds.size.width*0.5,
                                             self.bounds.size.height*yPosition)];
  } else if ([self.card.shape isEqualToString:@"squiggle"]) {
    return [self drawSquiggleAtPoint:CGPointMake(self.bounds.size.width*0.5,
                                                 self.bounds.size.height*yPosition)];
  } else if ([self.card.shape isEqualToString:@"diamond"]) {
    return [self drawDiamondAtPoint:CGPointMake(self.bounds.size.width*0.5,
                                                self.bounds.size.height*yPosition)];
  }
  return shape;
}

- (UIColor *)colorOfShape {
  if ([self.card.color isEqualToString:@"RED"]) {
    return [UIColor redColor];
  } if ([self.card.color isEqualToString:@"GREEN"]) {
    return [UIColor greenColor];
  } if ([self.card.color isEqualToString:@"PURPLE"]) {
    return [UIColor purpleColor];
  }
  return [UIColor blackColor];
}

- (void) drawStriped:(UIBezierPath *)shape {
  CGRect bounds = shape.bounds;
  UIBezierPath *stripes = [UIBezierPath bezierPath];
  for ( int x = 0; x < bounds.size.width; x += kStripedDistance*bounds.size.width ) {
    [stripes moveToPoint:CGPointMake( bounds.origin.x + x, bounds.origin.y )];
    [stripes addLineToPoint:CGPointMake( bounds.origin.x + x, bounds.origin.y + bounds.size.height)];
  }
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState( context );
  [shape addClip];
  [stripes stroke];
  CGContextRestoreGState( context );
  [shape stroke];
}

- (void)displayFaceCard {
  [self displayCard];
}
- (void)displayBackCard {
  [self displayCard];
}

- (void)displayCard {
  NSMutableArray *shapes = [[NSMutableArray alloc] init];
  if (self.card.numberOfShape == 1) {
    [shapes addObject:[self drawshapeAtPoint:0.5]];
  } else if (self.card.numberOfShape == 2) {
    [shapes addObject:[self drawshapeAtPoint:0.5-kShapeHeight/1.5]];
    [shapes addObject:[self drawshapeAtPoint:0.5+kShapeHeight/1.5]];
  } else if (self.card.numberOfShape == 3) {
    [shapes addObject:[self drawshapeAtPoint:0.5-kShapeHeight*1.10]];
    [shapes addObject:[self drawshapeAtPoint:0.5]];
    [shapes addObject:[self drawshapeAtPoint:0.5+kShapeHeight*1.10]];
  }
  UIColor *color=[self colorOfShape];
  [color set];
  if ([self.card.shading isEqualToString:@"unfilled"]) {
    for (UIBezierPath *shape in shapes) {
      shape.lineWidth = shape.lineWidth*5;
      [shape stroke];
    }
  }
  if ([self.card.shading isEqualToString:@"solid"]) {
    for (UIBezierPath *shape in shapes) {
      [shape stroke];
      [shape fill];
    }
  }
  if ([self.card.shading isEqualToString:@"solid"]) {
    for (UIBezierPath *shape in shapes) {
      [shape stroke];
      [shape fill];
    }
  }
  if ([self.card.shading isEqualToString:@"striped"]) {
    for (UIBezierPath *shape in shapes) {
      [self drawStriped:shape];
    }
  }
}

- (void)drawRect:(CGRect)rect {
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         cornerRadius:[self cornerRadius]];
  [roundedRect addClip];
  if (self.faceUp) {
    [[UIColor separatorColor] setFill];
  } else{
    [[UIColor whiteColor] setFill];
  }
  UIRectFill(self.bounds);
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  [self displayCard];
}

@end
