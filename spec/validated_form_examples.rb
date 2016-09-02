RSpec.shared_examples 'a validated form' do
  def expect_success(start_date: '2016-01-02', end_date: '2016-02-03')
    expect(described_class.new(start_date, end_date)).to be_valid
  end

  def expect_failure(start_date: '2016-01-02', end_date: '2016-02-03')
    expect(described_class.new(start_date, end_date)).not_to be_valid
  end

  it 'passes valid values' do
    expect_success start_date: '2016-01-02', end_date: '2016-02-03'
  end

  it 'validates start_date is present' do
    expect_failure start_date: nil
    expect_failure start_date: ''
  end

  it 'validates start_date is a valid date' do
    expect_failure start_date: 'wrong'
    expect_failure start_date: '2016-50-10'
    expect_failure start_date: ['2016-01-02']
  end

  it 'validates end_date is present' do
    expect_failure end_date: nil
    expect_failure end_date: ''
  end

  it 'validates end_date is a valid date' do
    expect_failure end_date: 'wrong'
    expect_failure end_date: '2016-50-10'
    expect_failure end_date: ['2016-01-02']
  end

  it 'validates start_date is before the end_date' do
    expect_failure start_date: '2016-02-03', end_date: '2016-01-02'
  end
end
