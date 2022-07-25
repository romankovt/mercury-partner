# frozen_string_literal: true

module RequestHelpers
  def json
    @json ||= JSON.parse(response.body).deep_symbolize_keys
  end

  def json_ids
    @json_ids ||= json[:data].pluck(:id).sort
  end

  def json_attributes
    @json_attributes ||= json[:data].present? ? json[:data][:attributes] : []
  end

  def json_keys(key)
    json.pluck(key).sort
  end
end
