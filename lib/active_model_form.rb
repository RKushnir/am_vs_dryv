require 'active_model'

class ActiveModelForm
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  attr_reader :start_date, :end_date

  include ActiveModel::Validations
  validates :start_date, :end_date, presence: true

  validate do
    if start_date.present?
      errors.add :start_date, :invalid unless valid_date?(start_date)
    end

    if end_date.present?
      errors.add :end_date, :invalid unless valid_date?(end_date)
    end
  end

  validate do
    if start_date.present? && valid_date?(start_date) &&
       end_date.present? && valid_date?(end_date)
      errors.add :base, :invalid_date_range unless Date.parse(start_date) < Date.parse(end_date)
    end
  end

  def valid_date?(date)
    Date.parse(date)
    true
  rescue ArgumentError
    false
  end
end
