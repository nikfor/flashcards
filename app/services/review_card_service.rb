class ReviewCardService

  attr_reader :card, :expected_text

  def initialize(card, expected_text)
    @card = card
    @expected_text = expected_text
  end

  def review
    result = Struct.new(:status, :text)
    case Levenshtein.distance(card.original_text.downcase, expected_text.downcase)
    when 0
      card.update_attributes(count_success_attempts:  card.count_success_attempts + 1, count_unsuccess_attempts: 0)
      rew_res = result.new(true, I18n.t("alert.right"))
    when 1..3
      card.update_attributes(count_success_attempts:  card.count_success_attempts + 1, count_unsuccess_attempts: 0)
      rew_res = result.new(true, I18n.t('alert.typo') + " '#{card.translated_text}': #{card.original_text}. " + I18n.t('alert.typo2') + " #{expected_text}")
    else
      card.update_attributes(count_unsuccess_attempts: card.count_unsuccess_attempts + 1)
      rew_res = result.new(false, I18n.t("alert.not_right"))
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
