module ApplicationHelper
  def format_date(date)
    date.strftime("%m/%d/%Y")
  end

  def display_words(string, words_size=50)
    words = string.split(' ')
    words[0..words_size].join(' ')
  end
end
