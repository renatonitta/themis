Themis::Config['disqus'].each do |key, value|
  Disqus::defaults[key.to_sym] = value
end
