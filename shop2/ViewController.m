//
//  ViewController.m
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
//
//
#import "ViewController.h"
#import "TelescopeShoppingCell.h"
#import "TelescopeShoppingCartViewController.h"
#import "TelescopeShoppingItem.h"
#import "Masonry.h"
#import "TelescopeShoppingCart.h"

@interface ViewController ()<TelescopeShoppingCellDelegate>

//Корзина
@property (strong, nonatomic) UIButton *shoppingCartBtn;
//Количество товаров
@property (nonatomic,strong) UIButton *bubble;
//Каталог
@property (nonatomic,strong) TelescopeShoppingCart *shoppingCart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addSubviews];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.shoppingCart.listAllItems.count) {
        self.bubble.hidden = YES;
    }else{
        [self.bubble setTitle:[NSString stringWithFormat:@"%ld",self.shoppingCart.listAllItems.count] forState:UIControlStateNormal];
    }
}

#pragma mark - Детский контроль

- (void)addSubviews
{
    [self addCart];
    [self addBubble];
}

- (void)addCart
{
    //Кнопка загрузки корзины
    
    self.shoppingCartBtn = [[UIButton alloc] init];
    [self.shoppingCartBtn setImage:[UIImage imageNamed:@"shoppingCart"] forState:UIControlStateNormal];
    [self.shoppingCartBtn addTarget:self action:@selector(cartClick:) forControlEvents:UIControlEventTouchUpInside];
    self.shoppingCartBtn.contentMode = UIViewContentModeScaleAspectFit;
    
    UIBarButtonItem *img = [[UIBarButtonItem alloc] initWithCustomView:self.shoppingCartBtn];
    self.navigationItem.rightBarButtonItem = img;
    
    [self.shoppingCartBtn sizeToFit];
}
 
- (void)addBubble
{
    //Добавить пузыри
    
    [self.bubble setBackgroundImage:[UIImage imageNamed:@"bubble"] forState:UIControlStateNormal];
    [self.bubble setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.bubble.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.shoppingCartBtn addSubview:self.bubble];
    self.bubble.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    self.bubble.center = CGPointMake(0, 0);
    [self.bubble sizeToFit];
    self.bubble.hidden = YES;
    self.bubble.layer.anchorPoint = CGPointMake(1, 1);
    self.bubble.userInteractionEnabled = NO;
}

#pragma mark - Реагировать на события

//Перейти к интерфейсу просмотра корзины покупок
- (void)cartClick:(id)sender {
    [self.navigationController pushViewController:[[TelescopeShoppingCartViewController alloc] init] animated:YES];
}


/**
 * Анимация кнопок
 */
- (void)cartAniamtion{
    
    CAKeyframeAnimation *anim = [[CAKeyframeAnimation alloc] init];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(0),@(M_PI_4 * 0.25),@(0),@(-M_PI_4 * 0.25),@(0)];
    anim.duration = 0.25;
    
    [self.shoppingCartBtn.imageView.layer addAnimation:anim forKey:nil];
}

/**
 * Пузырьковая анимация
 */
- (void)bubbleAnimation{
    CASpringAnimation *anim = [[CASpringAnimation alloc] init];
    anim.keyPath = @"transform.scale";
    anim.fromValue = @(0.01);
    anim.toValue = @(1);
    anim.duration = 0.5;
    [self.bubble.layer addAnimation:anim forKey:nil];
}


#pragma mark - tableView Delegate

/**
 * Отключить эффект выбора ячеек
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TelescopeShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingCell"];
    
    cell.label.text = [NSString stringWithFormat:@"Apple%generation",indexPath.row];
    cell.delegate = self;
    
    return cell;
}

/**
 *действующая ячейка
 */
- (void)shoppingCellBuyClick:(TelescopeShoppingCell *)cell
{
    //анимация
    [self cartAniamtion];
    
    if (self.shoppingCart.cart[cell.label.text] != nil) {
        [self.shoppingCart.cart[cell.label.text] addItem];
        return;
    }
    
    //Если отсутствует, создайте новый продукт и добавьте его в список
    TelescopeShoppingItem *item = [TelescopeShoppingItem itemWithName:cell.label.text];
    [self.shoppingCart.cart setValue:item forKey:cell.label.text];
    
    [self.bubble setTitle:[NSString stringWithFormat:@"%ld",self.shoppingCart.listAllItems.count] forState:UIControlStateNormal];
    self.bubble.hidden = NO;
    [self.bubble sizeToFit];
    [self bubbleAnimation];
}
#pragma mark - загрузка
-(TelescopeShoppingCart *)shoppingCart
{
    if (_shoppingCart == nil) {
        _shoppingCart = [TelescopeShoppingCart sharedShoppingCart];
    }
    return _shoppingCart;
}

- (UIButton *)bubble
{
    if (_bubble == nil) {
        _bubble = [[UIButton alloc] init];
    }
    return _bubble;
}

@end
