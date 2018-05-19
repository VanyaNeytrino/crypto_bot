class Counter

  def initialize(amount : String, base_currency : String, counter_currency : String)
    @amount = amount
    @base_currency = base_currency
    @counter_currency = counter_currency
  end

  def count
    course = CryptoApi.new(@base_currency, @counter_currency).exchange_rates
    result = @amount.to_f64 * course.to_f64
    puts result
    return result.round(8)
  end

end
