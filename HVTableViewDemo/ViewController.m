//
//  ViewController.m
//  HVTableViewDemo
//
//  Created by Towey on 2017/10/24.
//  Copyright © 2017年 tw. All rights reserved.
//

#import "ViewController.h"
#import "TWHVTableView.h"


@interface ViewController () <TWHVTableViewDataSource, TWHVTableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupView];
}

- (void)setupView {
    
//    添加TWHVTableView，并设置数据源和代理
    TWHVTableView *hvTableView = [[TWHVTableView alloc] init];
    CGFloat marginTop = 40;
    hvTableView.frame = CGRectMake(0, marginTop, self.view.frame.size.width, self.view.frame.size.height - marginTop);
    hvTableView.dataSource = self;
    hvTableView.delegate = self;
    [self.view addSubview:hvTableView];
}

#pragma mark - hvTableView 相关数据源和代理等
- (UIView *)leftHeadView {
    
    return [self loadViewFromloadNibName:@"TWLeftHeadView"];
}

- (UIView *)rightHeadView {
    
    return [self loadViewFromloadNibName:@"TWRightHeadView"];
}

- (CGFloat)heightForHeadView {
    
    return 40;
}

- (CGFloat)widthForLeftView {
    
    return 200;
}

- (CGFloat)widthForRightView {
    
    return 400;
}

- (NSInteger)numberOfSectionsInTWHVTableView:(TWHVTableView *)hvTableView {
    
    return 1;
}

- (NSInteger)hvTableView:(TWHVTableView *)hvTableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}

-(CGFloat)hvTableView:(TWHVTableView *)hvTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (UITableViewCell *)hvTableViewLeftTableView:(UITableView *)leftTableView CellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return (UITableViewCell *)[self loadViewFromloadNibName:@"TWLeftTableViewCell"];
}

- (UITableViewCell *)hvTableViewRightTableView:(UITableView *)rightTableView CellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (UITableViewCell *)[self loadViewFromloadNibName:@"TWRightTableViewCell"];
}

- (void)hvTableView:(TWHVTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选择了 %ld",indexPath.row);
}


#pragma mark - 根据名称加载xib文件
- (UIView *)loadViewFromloadNibName:(NSString *)name {
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
