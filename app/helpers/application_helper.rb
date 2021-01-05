module ApplicationHelper
  def counter(noun, count)
    if noun == 0
      "No #{ noun }"
    else
      "#{ count } #{ noun.pluralize(count) }" 
    end
  end
end
