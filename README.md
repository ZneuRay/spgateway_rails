# SpgatewayRails

Ruby on Rails的[智付通](https://www.spgateway.com/)信用卡定期定額扣款Gem，相關API文件請參考[信用卡定期定額API](https://www.spgateway.com/dw_files/info_api/spgateway_gateway_periodical_api_V1_0_6.pdf)

## 版本更新

*0.7.0*

* 更新藍新金流API串接網址

*0.6.0*

* 新增交易狀態查詢

*0.5.2*

* 修正`spgateway_periodical_form`與`spgateway_mpg_form`參數錯誤問題

*0.5.1*

* 新增平台商店修改

*0.5.0*

* 新增平台商店建立

*0.4.0*

* 因智付通定期定額付款日期無法自行判斷，造成當月不存在該日期時將無法自動扣款，例如設定每月31日自動扣款，則無31日的月份將不會進行扣款，因此將超過28日的日期都調整至28日

*0.2.0*

* 新增智付通MPG付款

*0.1.0*

* 新增智付通定期定額付款功能

## 安裝

將此行加入你的 Gemfile:

```ruby
gem 'spgateway_rails', git: https://github.com/ZneuRay/spgateway_rails.git
```

然後執行:

    $ bundle install

## 設定

1. 先到智付通網站註冊帳號並取得`MerchantID`、`HashKey`、`HashIV`，連結可參考下方
2. 在你的專案建立`config/initializers/spgateway.rb`並加入設定
    

```ruby
SpgatewayRails.configure do |config|
    config.merchant_id = ''
    config.hash_key = ''
    config.hash_iv = ''
    config.mode = :development
end
```

* [測試環境](https://cwww.spgateway.com/)請將`config.mode`設為`:development`
* [正式環境](https://www.spgateway.com/)請設為`:production`

## 開始使用

### 條件設定

* 在`controller`中設定你需要的付款條件，各參數請參考智付通API

```ruby
spgateway_periodical.setup do |p|
    p["ProdDesc"] = "月租費"
    p["PeriodAmt"] = 1000
end
```

* 各個必填的參數都有預設值(請參考下方)，建議至少修改`ProdDesc`與`PeriodAmt`，如需回傳資料請加入`NotifyURL`與`ReturnURL`，其它需要修改再自行填入

```ruby
RespondType : 'String'
TimeStamp : (timestamp)
Version : '1.0'
MerOrderNo : (timestamp in macroseconds 16位數)
PeriodAmt : 1000
PeriodType : 'M'
PeriodStartType : 2
PeriodTimes : 60
PeriodPoint : (今天)
```

* 當你修改`PeriodType`後可使用下方指令自動幫你產生對應`PeriodType`格式的今天日期

```ruby
spgateway_periodical.reset_period_point
```

### 產生付款`Form`

信用卡定期定額扣款透過對智付通`post request`，由智付通產生付款頁面，以下提供兩種方式

1. 透過`view helper`自動產生表單
2. 自行實作

#### 透過`view helper`自動產生表單

* 在`view`中自動產生付款表單，可自行設定按鈕名稱與樣式

```ruby
spgateway_periodical_form
# 如要設定名稱與樣式請使用
spgateway_periodical_form(
        btn_value: "付款",
        btn_class: "btn btn-primary")
```

#### 自行發送要求

* 可自行產生AES加密結果放入`PostData_`內並實作發送要求

```ruby
post_data = spgateway_periodical.get_encrypt_string
```

## 回傳資料

如有設定回傳`URL`，智付通在交易完成後會將資料回傳

* 直接傳入`Period`即會自動解密並將結果轉換成*hash*，請自行記錄回傳資料

```ruby
result = spgateway_periodical_result params[:Period]
result.get_result

# 如果想取得AES解密後的原始結果
result.get_raw_result
```

* 轉換後資料結構如下 :

```ruby
{
    "Status"=>"SUCCESS",
    "Message"=>"委託單成立，且首次授權成功",
    "Result"=>{
        "MerchantID"=>"MS1732037",
        "MerchantOrderNo"=>"14839807785444715",
        "PeriodType"=>"W",
        "PeriodAmt"=>"2",
        "AuthTimes"=>5,
        "DateArray"=>"2017-01-10,2017-01-17,2017-01-24,2017-01-31,2017-02-07",
        "TradeNo"=>"17011000532533523",
        "AuthCode"=>"930637",
        "RespondCode"=>"00",
        "AuthTime"=>"20170110005325",
        "CardNo"=>"400022******1111",
        "EscrowBank"=>"KGI",
        "AuthBank"=>"KGI",
        "PeriodNo"=>"P170110005324Eajz3K"
    }
}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ZneuRay/spgateway_rails.

