# coding: utf-8
module Pry::Prompt::Snowman
  extend self
  extend Pry::Helpers::Text
  extend Pry::Helpers::BaseHelpers

  # https://unicode-table.com/en/1F48E/
  GEM_STONE = "💎"

  # Pry-like symbol.
  # https://unicode-table.com/en/26CF/
  PICK = "⛏"

  # https://unicode-table.com/en/2615/
  COFFEE = "☕"

  def prompt(obj, nest_level, pry, wait)
    e = wait ? "*" : ">"
    input_size = pry.input_array.size
    [
      pry.color ? cyan(" #{input_size} ") : input_size,
      " #{ruby_info(pry)} ",
      "#{PICK} (#{Pry.view_clip(obj)})#{':%s' % nest_level if not nest_level.zero?}#{e}",
    ].compact.join
  end

  def ruby_info(pry)
    case
    when jruby?
      str = " #{COFFEE}  #{RUBY_ENGINE}-#{RUBY_VERSION} "
      pry.color ? white_on_red(str) : str
    else
      str = " #{GEM_STONE}  #{RUBY_ENGINE}-#{RUBY_VERSION} "
      pry.color ? white_on_red(str) : str
    end
  end
  private :ruby_info
end
