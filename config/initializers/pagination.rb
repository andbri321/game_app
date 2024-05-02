# frozen_string_literal: true

require "kaminari_api_meta_data/version"

module KaminariApiMetaData
  def meta_data(collection, extra_meta = {})
    prev_page_link = collection&.prev_page ? "#{games_path(page: collection.prev_page)}" : nil
    next_page_link = collection&.next_page ? "#{games_path(page: collection.next_page)}" : nil

    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      next_page_link: next_page_link,
      prev_page_link: prev_page_link,
      per_page: collection.limit_value,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }.merge(extra_meta)
  end
end