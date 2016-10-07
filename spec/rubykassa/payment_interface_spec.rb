require 'spec_helper'

describe Rubykassa::PaymentInterface do
  before(:each) do
    @payment_interface = Rubykassa::PaymentInterface.new do
      self.invoice_id = 12
      self.total = 1200
      self.out_sum_currency = 'USD'
      self.params = { foo: 'bar' }
    end
  end

  it 'should return correct pay_url' do
    expect(@payment_interface.pay_url).to eq 'https://auth.robokassa.ru/Merchant/Index.aspx?MerchantLogin=your_login&OutSum=1200&InvId=12&OutSumCurrency=USD&IsTest=1&SignatureValue=6b2b9c325aa2cc34797adccc2fab9c4a&shpfoo=bar'
  end

  it 'should return correct pay_url when additional options passed' do
    url = @payment_interface.pay_url description: 'desc',
                                     culture: 'ru',
                                     email: 'foo@bar.com',
                                     currency: ''
    expect(url).to eq 'https://auth.robokassa.ru/Merchant/Index.aspx?MerchantLogin=your_login&OutSum=1200&InvId=12&OutSumCurrency=USD&IsTest=1&SignatureValue=6b2b9c325aa2cc34797adccc2fab9c4a&shpfoo=bar&IncCurrLabel=&Desc=desc&Email=foo@bar.com&Culture=ru'
  end

  it 'should return correct initial_options' do
    params = { login: 'your_login',
               total: 1200,
               invoice_id: 12,
               out_sum_currency: 'USD',
               is_test: 1,
               signature: '6b2b9c325aa2cc34797adccc2fab9c4a',
               shpfoo: 'bar' }
    expect(@payment_interface.initial_options).to eq(params)
  end

  it 'should return correct test_mode?' do
    expect(@payment_interface.test_mode?).to be_truthy
  end
end
