# frozen_string_literal: true

module PostsHelper
  def truncated_body(body)
    return body unless body.size > 160

    body.first(160) + "..."
  end
end
