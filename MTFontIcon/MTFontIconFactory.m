//
//  MTFontIconFactory.m
//  
//
//  Created by Gio on 14/08/2013.
//
//

#import "MTFontIconFactory.h"
#import "MTFontIconParser.h"
#import "NSString+Unicode.h"


@interface MTFontIconView ()
- (id)initWithFrame:(CGRect)frame fontName:(NSString *)fontName iconString:(NSString *)iconString;
@end


@interface MTFontIconFactory ()
@property (nonatomic, strong) NSDictionary *icons;
@property (nonatomic, strong) UIFont *font;
@end


@implementation MTFontIconFactory

- (id)init
{
    self = [super init];
    if (self) {
        [self setupIcons];
    }
    return self;
}

- (void)setupIcons
{
    self.icons = [MTFontIconParser parseFontIcons];
}

- (NSString *)charForIcon:(NSString *)icon
{
    return self.icons[icon];
}

- (UIFont *)iconFontOfSize:(CGFloat)size
{
    // TODO - fix the fontname!
    return [UIFont fontWithName:@"icomoon" size:size];
}

- (MTFontIconView *)iconViewForIconNamed:(NSString *)iconName withSide:(CGFloat)side
{
    NSString *hexString = [self charForIcon:iconName];
    NSString *iconString = [NSString stringWithUnicodeDecimalValue:[hexString hexStringToInteger]];
    
    return [[MTFontIconView alloc] initWithFrame:CGRectMake(0, 0, side, side)
                                        fontName:@"icomoon"
                                      iconString:iconString];
}

@end


@implementation MTFontIconView

- (id)initWithFrame:(CGRect)frame fontName:(NSString *)fontName iconString:(NSString *)iconString
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:@"icomoon" size:self.frame.size.height];
        label.text = iconString;
        
        [self addSubview:label];
    }
    return self;
}

@end