RSpec.shared_examples 'a validated form' do
  def expect_success(*args)
    expect(described_class.new(*args)).to be_valid
  end

  def expect_failure(*args)
    expect(described_class.new(*args)).not_to be_valid
  end

  it 'passes valid values' do
    expect_success '2016-01-02', '2016-02-03'
  end

  it 'validates start_date is present' do
    expect_failure nil, '2016-02-03'
    expect_failure '', '2016-02-03'
  end

  it 'validates start_date is a valid date' do
    expect_failure 'wrong', '2016-02-03'
    expect_failure '2016-50-10', '2016-02-03'
  end

  it 'validates end_date is present' do
    expect_failure '2016-01-02', nil
    expect_failure '2016-01-02', ''
  end

  it 'validates end_date is a valid date' do
    expect_failure '2016-01-02', 'wrong'
    expect_failure '2016-01-02', '2016-50-10'
  end

  it 'validates start_date is before the end_date' do
    expect_failure '2016-02-03', '2016-01-02'
  end
end
