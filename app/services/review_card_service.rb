class ReviewCardService

  attr_reader :card, :expected_text

  Result = Struct.new(:status, :message) do
    def success?
      status ? true : false
    end
  end

  def initialize(card, expected_text)
    @card = card
    @expected_text = expected_text
  end

  def review
    case Levenshtein.distance(card.original_text.downcase, expected_text.downcase)
    when 0
      card.update_attributes(count_success_attempts:  card.count_success_attempts + 1, count_unsuccess_attempts: 0)
      rew_res = Result.new(true, I18n.t("alert.right"))
    when 1..3
      card.update_attributes(count_success_attempts:  card.count_success_attempts + 1, count_unsuccess_attempts: 0)
      rew_res = Result.new(true, I18n.t('alert.typo') + " '#{card.translated_text}': #{card.original_text}. " + I18n.t('alert.typo2') + " #{expected_text}")
    else
      card.update_attributes(count_unsuccess_attempts: card.count_unsuccess_attempts + 1)
      rew_res = Result.new(false, I18n.t("alert.not_right"))
    end
    touch_review_date
    rew_res
  end

  private

  def touch_review_date
    card.update_column(:review_date, date_for_review)
  end

  def date_for_review
    if card.count_unsuccess_attempts > 2
      card.update_attributes(count_unsuccess_attempts: 0, count_success_attempts: 1)
      12.hours.from_now
    else
      get_date_success_attempts
    end
  end

  def get_date_success_attempts
    return  Time.current if card.count_success_attempts == 0
    case card.count_success_attempts
    when 1 then 12.hours
    when 2 then 3.days
    when 3 then 7.days
    when 4 then 14.days
    else
      1.months
    end.from_now
  end

end
