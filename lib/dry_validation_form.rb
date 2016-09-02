require 'dry-validation'

class DryValidationForm
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  attr_reader :start_date, :end_date

  Schema = Dry::Validation.Form do
    required(:start_date).filled(:date?)
    required(:end_date).filled(:date?)

    rule(start_date_before_end_date: %i(start_date end_date)) do |start_date, end_date|
      start_date.lt? end_date
    end
  end

  def valid?
    Schema.(start_date: start_date, end_date: end_date).success?
  end
end
