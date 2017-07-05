module ApplicationHelper
  def format_date(date)
    date.strftime("%m/%d/%Y")
  end

  def display_words(string, chars_size=300)
    return if !string
    string[0..chars_size]
  end
end
