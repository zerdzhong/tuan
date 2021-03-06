//
//  DealDetailWebController.m
//  tuan
//
//  Created by zerd on 14-12-23.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DealDetailWebController.h"
#import "Common.h"

@interface DealDetailWebController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIView *cover;

@end

@implementation DealDetailWebController

-(void)loadView{
    _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.delegate = self;
    _webView.backgroundColor = kGlobalBgColor;
    _webView.scrollView.backgroundColor = kGlobalBgColor;
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kGlobalBgColor;
    [self loadWebContent];
}

- (void)setDeal:(DealModel *)deal{
    _deal = deal;
    [self loadWebContent];
}

- (void)loadWebContent{
    NSString *requestID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
    NSString *urlString = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@",requestID];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    if (_cover == nil) {
        _cover = [[UIView alloc]init];
        _cover.backgroundColor = kGlobalBgColor;
        _cover.frame = self.view.frame;
    }
    
    [self.view addSubview:_cover];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]init];
    indicator.center = CGPointMake(_cover.frame.size.width * 0.5, _cover.frame.size.height * 0.5);
    indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    indicator.color = [UIColor darkGrayColor];
    [indicator startAnimating];
    [_cover addSubview:indicator];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    webView.scrollView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
    
//    NSString *htmlString = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].innerHTML"];
//    MyLog(@"%@",htmlString);
    
    //拼接脚本
    NSMutableString *script = [NSMutableString string];
    //删除header
    [script appendString:@"var header = document.body.getElementsByTagName(\"header\")[0];"];
    [script appendString:@"document.body.removeChild(header);"];
    //删除购买条
    [script appendString:@"var cost_box = document.body.getElementsByTagName(\"div\")[0];"];
    [script appendString:@"document.body.removeChild(cost_box);"];
    //删除购买按钮
    [script appendString:@"var spans = document.body.getElementsByTagName(\"span\");"];
    [script appendString:@"var buy = spans[spans.length -1];"];
    [script appendString:@"if (document.body == buy.parentNode) {"];
    [script appendString:@"document.body.removeChild(buy);}"];
    [script appendString:@"var buyBtn = document.body.getElementsByTagName(\"a\")[0];"];
    [script appendString:@"if (buyBtn.parentNode = document.body) {"];
    [script appendString:@"document.body.removeChild(buyBtn);}"];
    //删除footer
    [script appendString:@"var footers = document.body.getElementsByTagName(\"footer\");"];
    [script appendString:@"for (var i = footers.length -1 ; i >= 0; i--) {"];
    [script appendString:@"var footer = footers[0];"];
    [script appendString:@"document.body.removeChild(footer);}"];
    //执行脚本
    [webView stringByEvaluatingJavaScriptFromString:script];
    
    [_cover removeFromSuperview];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
