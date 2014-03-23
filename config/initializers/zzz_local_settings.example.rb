=begin
# ローカル環境独自の設定値をここに入れることが出来ます。
# 名前を zzz_local_settings.rb でコピーして下さい。

# better error
if defined?(BetterErrors) && Rails.env.development?
  # RubyMine
  BetterErrors.editor = 'x-mine://open?file=%{file}&line=%{line}'
end

# letter_opener
if Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
end

=end
