//
//  CustomTableViewCell.m
//  MVVMTwo
//
//  Created by 赵永闯 on 2018/4/13.
//  Copyright © 2018年 zhaoyongchuang. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WScreen, 50)];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.backgroundColor=[UIColor whiteColor];
        _titleLabel.font=[UIFont systemFontOfSize:14];
    }
    return self;
}

@end
