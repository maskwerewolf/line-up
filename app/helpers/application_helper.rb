module ApplicationHelper

  def queue_index(index,page_size,page)
      current_page_base = page_size.to_i *  ( page.to_i - 1)
      return index + 1 if current_page_base < 0
      return current_page_base + index + 1
  end
end
