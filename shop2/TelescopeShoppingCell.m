//
//  TelescopeShoppingCell.m
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
//

#import "TelescopeShoppingCell.h"


@interface TelescopeShoppingCell ()

@end

@implementation TelescopeShoppingCell

- (void)awakeFromNib {
    // Инициализация кода
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Настроить представление для выбранного состояния
}


- (IBAction)buyClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(shoppingCellBuyClick:)]) {
        [self.delegate shoppingCellBuyClick:self];
    }
}

@end
