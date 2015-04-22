//
//  HHLoginCell.m
//  HHNewsEast
//
//  Created by Luigi on 14-8-8.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "HHLoginCell.h"
#import "LoginItemModel.h"
@interface HHLoginCell ()<UITextFieldDelegate>
@property(nonatomic,strong)HHLable *titleLable;
@property(nonatomic,strong)HHTextField *valueTextField;

@end

@implementation HHLoginCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        [self onInitData];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)onInitData{
    _titleLable=[[HHLable alloc]  initWithFrame:CGRectMake(20, 5, 200, 20) fontSize:14 text:@"" textColor:[UIColor grayColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    _valueTextField=[[HHTextField alloc]  initWithFrame:CGRectMake(20, 25.0, 200, 30) fontSize:14 delegate:self borderStyle:UITextBorderStyleNone returnKeyType:UIReturnKeyDefault keyboardType:UIKeyboardTypeDefault placeholder:nil];
    HHLable *lineLable=[[HHLable alloc]  initWithFrame:CGRectMake(20, 55,CGRectGetWidth(self.bounds)-20*2, 1) fontSize:0 text:@"" textColor:nil textAlignment:NSTextAlignmentLeft numberOfLines:1];
    lineLable.backgroundColor=[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
    [self addSubview:lineLable];
    [self addSubview:_titleLable];
    [self addSubview:_valueTextField];
}
-(void)setItemModel:(LoginItemModel *)itemModel{
    _itemModel=itemModel;
    if (_itemModel.itemType==LoginItemTypeUserPwd) {
        _valueTextField.secureTextEntry=YES;
    }else if (_itemModel.itemType==LoginItemTypeUserName){
        _valueTextField.secureTextEntry=NO;

    }
    _titleLable.text=itemModel.itemTitle;
}
+(CGFloat)loginCellHeight{
    return 60;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    _itemModel.itemValue=textField.text;
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _itemModel.itemValue=textField.text;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    _itemModel.itemValue=textField.text;
    return YES;
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,1.0);
    CGContextSetRGBStrokeColor(context,214.0/255.0, 214.0/255.0, 214.0/255.0, 1.0);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context,
                         20, 45);
    CGContextAddLineToPoint(context,
                            CGRectGetWidth(rect)-20,45 );
    
    CGContextStrokePath(context);
}
@end
