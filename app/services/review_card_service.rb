class ReviewCardService

  attr_reader :card, :expected_text

  def initialize(card, expected_text)
    @card = card
    @expected_text = expected_text
  end

  def review
    if eql_translation?(expected_text)
      card.update_attributes(count_success_attempts:  card.count_success_attempts + 1, count_unsuccess_attempts: 0)
      result = true
    else
      card.update_attributes(count_unsuccess_attempts: card.count_unsuccess_attempts + 1)
      result = false
    end
    touch_review_date
    result
  end

  private

  def touch_review_date
    card.update_column(:review_date, date_for_review)
  end


  def eql_translation?(text)
    card.original_text.downcase == text.downcase
  end

  def date_for_review
    if card.count_unsuccess_attempts > 2
      card.update_attributes(count_unsuccess_attempts: 0, count_success_attempts: 1)
      12.hours.from_now
    else
      case card.count_success_attempts
      when 0
        Time.current
      when 1
        12.hours.from_now
      when 2
        3.days.from_now
      when 3
        7.days.from_now
      when 4
        14.days.from_now
      else
        1.months.from_now
      end
    end
  end
end
