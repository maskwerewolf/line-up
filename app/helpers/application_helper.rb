module ApplicationHelper

  def queue_index(index,page_size,page)
      current_page_base = page_size.to_i *  ( page.to_i - 1)
      return index + 1 if current_page_base < 0
      return current_page_base + index + 1
  end

  def split_account(str)
    index = str.index('@')
    if (not index.nil?) && index > 0
      return "#{str[0, index/2+index%2]}**#{str[index, str.length]}"
    end
    return "#{str[0, 4]}**#{str[7, 10]}"
  end
end
