//
//  TWHVTableView.m
//  HVTableViewDemo
//
//  Created by Towey on 2017/10/24.
//  Copyright © 2017年 tw. All rights reserved.
//

#import "TWHVTableView.h"

@interface TWHVTableView () <UITableViewDataSource, UITableViewDelegate>

//左边头部view
@property (nonatomic, weak) UIView *leftHeadView;

//右边头部view
@property (nonatomic, weak) UIView *rightHeadView;

//列表左边tableview
@property (nonatomic, weak) UITableView *leftTableView;

//列表右边tableview
@property (nonatomic, weak) UITableView *rightTabelView;

//列表右边作为横向滑动的scrollview
@property (nonatomic, weak) UIScrollView *rightScrollView;

//列表左边区域（固定区域）宽度
@property (nonatomic, assign) CGFloat leftWidth;

//列表右边区域（可横向滑动区域）总宽度
@property (nonatomic, assign) CGFloat rightWidth;

//头部的高度
@property (nonatomic, assign) CGFloat headHeight;

@end

@implementation TWHVTableView

- (instancetype)init {
    if (self = [super init]) {
        
        [self setupContentView];
    }
    return self;
}

#pragma mark - 设置横竖滑动列表的头部
- (void)setupHeadView {
    
//    防止主动刷新等导致左边头部、右边头部重复添加
    if (self.leftHeadView) {
        [self.leftHeadView removeFromSuperview];
    }
    
    if (self.rightHeadView) {
        [self.rightHeadView removeFromSuperview];
    }
    
    
    if ([self.dataSource respondsToSelector:@selector(leftHeadView)]) {
//        获取左边头部view
        UIView *leftHeadView = [self.dataSource leftHeadView];
        
        [self addSubview:leftHeadView];
        self.leftHeadView = leftHeadView;
        
    }
    
    if ([self.dataSource respondsToSelector:@selector(rightHeadView)]) {
//        获取右边头部view
        UIView *rightHeadView = [self.dataSource rightHeadView];
        
        [self.rightScrollView addSubview:rightHeadView];
        self.rightHeadView = rightHeadView;
        
    }
}

#pragma mark - 设置横竖滑动列表内容
- (void)setupContentView {
    //    设置左边的tableview
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    leftTableView.dataSource = self;
    leftTableView.delegate = self;
    leftTableView.showsVerticalScrollIndicator = NO;
    leftTableView.showsHorizontalScrollIndicator = NO;
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:leftTableView];
    self.leftTableView = leftTableView;
    
//    设置右边可横向滑动的scrollview
    UIScrollView *rightScrollView = [[UIScrollView alloc] init];
    rightScrollView.delegate = self;
    rightScrollView.showsVerticalScrollIndicator = NO;
    rightScrollView.showsHorizontalScrollIndicator = NO;
    rightScrollView.bounces = NO;
    
    [self addSubview:rightScrollView];
    self.rightScrollView = rightScrollView;

//    设置右边的tableview
    UITableView *rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    rightTableView.dataSource = self;
    rightTableView.delegate = self;
    rightTableView.showsVerticalScrollIndicator = NO;
    rightTableView.showsHorizontalScrollIndicator = NO;
    rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [rightScrollView addSubview:rightTableView];
    self.rightTabelView = rightTableView;
    
}

//布局相关view
- (void)layoutSubviews {
    [super layoutSubviews];
    
//    添加头部，头部是通过数据源获取的，需要在设置数据源之后添加，并作重复添加处理
    [self setupHeadView];

    
//    获取头部view的高度，默认为20
    self.headHeight = 20;
    if ([self.delegate respondsToSelector:@selector(heightForHeadView)]) {
        self.headHeight = [self.delegate heightForHeadView];
    }
    
//    获取列表左边区域（左边固定区域）的宽度，默认为100
    self.leftWidth = 100;
    if ([self.delegate respondsToSelector:@selector(widthForLeftView)]) {
        self.leftWidth = [self.delegate widthForLeftView];
    }
    
//    设置左边头部的frame
    CGFloat leftHeadX = 0;
    CGFloat leftHeadY = 0;
    CGFloat leftHeadW = self.leftWidth;
    CGFloat leftHeadH = self.headHeight;
    self.leftHeadView.frame = CGRectMake(leftHeadX, leftHeadY, leftHeadW, leftHeadH);
    
//    获取列表右边可横向滑动区域的总宽度，默认为100 && 设置右边头部的frame
    self.rightWidth = 100;
    if([self.delegate respondsToSelector:@selector(widthForRightView)]) {
        self.rightWidth = [self.delegate widthForRightView];
    }
    
//    设置左边可横向滑动scrollview的frame和contentSize
    self.rightScrollView.frame = CGRectMake(self.leftWidth, 0, self.frame.size.width - self.leftWidth, self.frame.size.height);
    self.rightScrollView.contentSize = CGSizeMake(self.rightWidth, self.frame.size.height);
    
    CGFloat rightHeadX = 0;
    CGFloat rightHeadY = 0;
    CGFloat rightHeadW = self.rightWidth;
    CGFloat rightHeadH = self.headHeight;
    self.rightHeadView.frame = CGRectMake(rightHeadX, rightHeadY, rightHeadW, rightHeadH);
    
    
//    设置左边tableview的frame
    self.leftTableView.frame = CGRectMake(0, self.headHeight, self.leftWidth, self.frame.size.height - self.headHeight);
    
//    设置右边tableview的frame
    self.rightTabelView.frame = CGRectMake(0, rightHeadH, self.rightWidth, self.rightScrollView.frame.size.height - self.headHeight);
}

#pragma mark - tableview 相关数据源&代理等
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger count = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTWHVTableView:)]) {
        count = [self.dataSource numberOfSectionsInTWHVTableView:self];
    }
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = 0;
    if ([self.dataSource respondsToSelector:@selector(hvTableView:numberOfRowsInSection:)]) {
        count = [self.dataSource hvTableView:self numberOfRowsInSection:section];
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        
        if ([self.dataSource respondsToSelector:@selector(hvTableViewLeftTableView:CellForRowAtIndexPath:)]) {
            UITableViewCell *cell = [self.dataSource hvTableViewLeftTableView:tableView CellForRowAtIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        return [[UITableViewCell alloc] init];
    } else {
        
        if ([self.dataSource respondsToSelector:@selector(hvTableViewRightTableView:CellForRowAtIndexPath:)]) {
            UITableViewCell *cell = [self.dataSource hvTableViewRightTableView:tableView CellForRowAtIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
        return [[UITableViewCell alloc] init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 40;
    if ([self.delegate respondsToSelector:@selector(hvTableView:heightForRowAtIndexPath:)]) {
        height = [self.delegate hvTableView:self heightForRowAtIndexPath:indexPath];
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(hvTableView:didSelectRowAtIndexPath:)]) {
        [self.delegate hvTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.leftTableView) {
        [self.rightTabelView setContentOffset:CGPointMake(self.rightTabelView.contentOffset.x, self.leftTableView.contentOffset.y)];
    }
    if (scrollView == self.rightTabelView) {
        [self.leftTableView setContentOffset:CGPointMake(0, self.rightTabelView.contentOffset.y)];
    }
}


@end
