//
//  TelescopeShoppingCell.h
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
// 

#import <UIKit/UIKit.h>
@class TelescopeShoppingCell;

@protocol TelescopeShoppingCellDelegate <NSObject>

- (void)shoppingCellBuyClick:(TelescopeShoppingCell *)cell;

@end


@interface TelescopeShoppingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic,weak) id<TelescopeShoppingCellDelegate> delegate;

@end
