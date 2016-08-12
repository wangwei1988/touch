//
//  myView.m
//  touch
//
//  Created by  王伟 on 16/8/10.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import "myView.h"
@interface myView ()
@property (nonatomic,strong)UIBezierPath *bezierPath;
@property (nonatomic,strong)NSMutableArray *buttonArray;
@property (nonatomic,strong)NSMutableArray *selectedButtonArray;

@property (nonatomic,assign)CGPoint movePoint;
@end
@implementation myView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bezierPath = [UIBezierPath bezierPath];
        for (int i = 0; i < 9; i++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((i % 3) * 80 + 100, (i / 3) * 80 + 100, 40, 40)];
            button.backgroundColor = [UIColor yellowColor];
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 20;
            button.tag = 1000 + i;
            button.userInteractionEnabled = NO;
            [self addSubview:button];
            [self.buttonArray addObject:button];
        }
    }
    return self;
}

-(NSMutableArray *)selectedButtonArray {
    if (!_selectedButtonArray) {
        _selectedButtonArray = [NSMutableArray array];
    }
    return _selectedButtonArray;
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point =  [touches.anyObject locationInView:self];
    
    for (UIButton *button in self.buttonArray) {
        if (button.selected) {
            continue;
        }
        if (CGRectContainsPoint(button.frame, point)) {
            button.backgroundColor = [UIColor redColor];
            button.selected = YES;
            [self.selectedButtonArray addObject:button];
        }
    }
    
    
    [self setNeedsDisplay];

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point =  [touches.anyObject locationInView:self];
    for (UIButton *button in self.buttonArray) {
        if (button.selected) {
            continue;
        }
        if (CGRectContainsPoint(button.frame, point)) {
            button.backgroundColor = [UIColor redColor];
            button.selected = YES;
            [self.selectedButtonArray addObject:button];
        } else {
            self.movePoint = point;
        }
    }

    [self setNeedsDisplay];

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.movePoint = CGPointZero;
    [self.selectedButtonArray removeAllObjects];
    for (UIButton *button in self.buttonArray) {
        button.selected = NO;
        button.backgroundColor = [UIColor yellowColor];
    }
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = 2;

    if (self.selectedButtonArray.count != 0) {
        
        for (int i = 0; i < self.selectedButtonArray.count; i++) {
            if (i == 0) {
                [bezierPath moveToPoint:[self.selectedButtonArray[0] center]];
            } else {
                [bezierPath addLineToPoint:[self.selectedButtonArray[i] center]];
            }
        }
        if (self.movePoint.x != 0) {
            [bezierPath addLineToPoint:self.movePoint];
        }
    }
    
    [[UIColor purpleColor] setStroke];
    [bezierPath stroke];

}


@end
