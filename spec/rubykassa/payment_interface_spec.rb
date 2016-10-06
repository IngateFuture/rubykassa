require 'spec_helper'

describe Rubykassa::PaymentInterface do
  before(:each) do
    @payment_interface = Rubykassa::PaymentInterface.new do
      self.invoice_id = 12
      self.total = 1200
      self.params = { foo: 'bar', out_sum_currency: 'USD' }
    end
  end

  it 'should return correct pay_url' do
    expect(@payment_interface.pay_url).to eq 'https://auth.robokassa.ru/Merchant/Index.aspx?MerchantLogin=your_login&OutSum=1200&InvId=12&IsTest=1&SignatureValue=90aafbe4adb9ab6b690f37f236726d55&shpfoo=bar&shpout_sum_currency=USD'
  end

  it 'should return correct pay_url when additional options passed' do
    url = @payment_interface.pay_url description: 'desc',
                                     culture: 'ru',
                                     email: 'foo@bar.com',
                                     out_sum_currency: 'USD',
                                     currency: ''
    expect(url).to eq 'https://auth.robokassa.ru/Merchant/Index.aspx?MerchantLogin=your_login&OutSum=1200&InvId=12&IsTest=1&SignatureValue=90aafbe4adb9ab6b690f37f236726d55&shpfoo=bar&shpout_sum_currency=USD&IncCurrLabel=&OutSumCurrency=USD&Desc=desc&Email=foo@bar.com&Culture=ru'
  end

  it 'should return correct initial_options' do
    params = { login: 'your_login',
               shpout_sum_currency: 'USD',
               shpfoo: 'bar',
               total: 1200,
               invoice_id: 12,
               signature: '90aafbe4adb9ab6b690f37f236726d55',
               is_test: 1 }
    expect(@payment_interface.initial_options).to eq(params)
  end

  it 'should return correct test_mode?' do
    expect(@payment_interface.test_mode?).to be_truthy
  end
end
