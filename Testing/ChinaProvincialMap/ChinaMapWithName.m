//
//  ChinaMapWithName.m
//  TestWebView
//
//  Created by apple on 17/1/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChinaMapWithName.h"
/**
 *  固定宽高560*500
 */
#define backgColor [UIColor colorWithRed:(rand()%256)/256.0 green:(rand()%256)/256.0 blue:(rand()%256)/256.0 alpha:1]
#define defaultCololor [UIColor colorWithRed: 0.667 green: 0.835 blue: 1 alpha: 1]

@interface ChinaMapWithName ()
@property (nonatomic,strong) NSMutableArray <UIBezierPath *>*pathArr;//地图块贝塞尔曲线数组
@property (nonatomic,strong) NSMutableArray <UIColor *>*colorArr;//每块地图的颜色数组
@property (nonatomic,strong) NSMutableArray <NSDictionary *>*textArr;// 各个省级行政区名字及位置数组


@end

@implementation ChinaMapWithName

#pragma mark - init
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:CGRectMake(0, 0, 560, 480)]) {
        self.backgroundColor = [UIColor grayColor];
        
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        
        [self addGestureRecognizer:click];
        
//        [UIView animateWithDuration:1. animations:^{
            CGFloat scale = frame.size.width/560.;
            self.transform = CGAffineTransformMakeScale(scale, scale);//宽高伸缩比例
            self.center = CGPointMake(frame.size.width *0.5,frame.size.height *0.5);
//        }];
        
    }
    return self;
}

-(NSMutableArray<UIBezierPath *> *)pathArr{
    if (_pathArr == nil) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ChinaMapPaths" ofType:@"plist"];
        NSData *pathsData = [NSData dataWithContentsOfFile:sourcePath];
        _pathArr = [NSKeyedUnarchiver unarchiveObjectWithData:pathsData];
        
    }
    return _pathArr;
}

- (NSMutableArray *)colorArr{
    if (_colorArr == nil) {
        _colorArr = [NSMutableArray arrayWithCapacity:34];
        for (int i = 0; i <34; i++) {
            UIColor* fillColor = defaultCololor;
            [_colorArr addObject:fillColor];
        }
    }
    return _colorArr;
}

- (NSMutableArray *)textArr{
    if (_textArr != nil) {
        return _textArr;
    }

    return [self readFromDisk];
//    return [self readFromMemory];
}

- (NSMutableArray *)readFromDisk{
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ProvincialName" ofType:@"plist"];
    NSData *data = [NSData dataWithContentsOfFile:sourcePath];
    NSMutableArray *nameArr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return nameArr;
}

- (NSMutableArray *)readFromMemory{
    NSArray *rectArr = @[[NSValue valueWithCGRect:CGRectMake(99, 160, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(211, 228, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(99, 269, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(266, 300, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(253, 382, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(341, 393, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(283, 250, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(302, 220, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(325, 314, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(314, 351, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(361, 448, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(396, 385, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(393, 418, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(421, 409, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(484, 377, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(445, 351, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(377, 342, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(414, 335, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(458, 309, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(480, 283, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(369, 292, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(381, 256, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(423, 220, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(396, 202, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(366, 218, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(336, 254, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(401, 173, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(427, 189, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(466, 151, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(387, 130, 40, 16)],
                         [NSValue valueWithCGRect:CGRectMake(476, 63, 40, 16)],
                         [NSValue valueWithCGRect:CGRectMake(485, 113, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(428, 280, 30, 16)],
                         [NSValue valueWithCGRect:CGRectMake(448, 260, 30, 16)],
                         ];
    
    
    
    
    
    
    NSArray *nameArr = @[@"新疆",@"青海",@"西藏",@"四川",@"云南",@"广西",@"甘肃",@"宁夏",@"重庆", @"贵州",@"海南",@"广东",@"澳门",@"香港",@"台湾",@"福建", @"湖南",@"江西",@"浙江",@"上海", @"湖北",@"河南",@"山东",@"河北",@"山西",@"陕西",@"北京",@"天津",@"辽宁",@"内蒙古",@"黑龙江",@"吉林",@"安徽", @"江苏"];
    
    NSMutableArray *dicArr = [NSMutableArray arrayWithCapacity:34];
    
    [nameArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = @{@"name":nameArr[idx],
                              @"rect":rectArr[idx]};
        [dicArr addObject:dic];
    }];
    
    //写入
//    NSData *archiveCarPriceData = [NSKeyedArchiver archivedDataWithRootObject:dicArr];
//    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ProvincialName" ofType:@"plist"];
//    [archiveCarPriceData writeToFile:sourcePath atomically:YES];
    
    return  dicArr;
}


#pragma mark - draw
-(void)drawRect:(CGRect)rect{
    //画地图
    UIColor* strokeColor = [UIColor colorWithRed: 0.976 green: 0.988 blue: 0.996 alpha: 1];
    
    [self.pathArr enumerateObjectsUsingBlock:^(UIBezierPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.miterLimit = 4;
        
        obj.lineJoinStyle = kCGLineJoinRound;
        
        [self.colorArr[idx] setFill];
        [obj fill];
        [strokeColor setStroke];
        obj.lineWidth = 1;
        [obj stroke];
    }];
    
    // 绘制文字
    __weak typeof(self) weakSelf = self;
    [self.textArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *name = obj[@"name"];
        NSValue *rectValue = obj[@"rect"];
        
        [weakSelf drawText:name rect:rectValue];
    }];
    
}

- (void)drawText:(NSString *)name rect:(NSValue *)rect {
    CGRect  textRect = [rect CGRectValue];
    {
        NSString* textContent = name;
        CGContextRef context = UIGraphicsGetCurrentContext();
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 13], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withAttributes: textFontAttributes];
        CGContextRestoreGState(context);
    }
}


#pragma mark - action

- (void)click:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:sender.view];
    [self tap:point];
}

-(void)tap:(CGPoint )point{
    //遍历34个地图块.判断点击的是那一块
    for (int i = 0; i <34; i++) {
        UIBezierPath *path = self.pathArr[i];
        BOOL isInPath = [path containsPoint:point];
        if (isInPath) {
            //清除之前选中的颜色，fill当前选中的颜色
            self.colorArr[_seletedIdx]  = defaultCololor;
            _seletedIdx = i;
            self.colorArr[_seletedIdx]  = backgColor;
            [self setNeedsDisplay];
            
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _colorArr = nil;
    [self setNeedsDisplay];
}

@end
