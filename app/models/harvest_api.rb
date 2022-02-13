class HarvestApi
  def me
    OpenStruct.new(get("users/me"))
  end

  def time_entries(from: nil, to: nil)
    query = { from: from, to: to }.compact
    response = get_all("time_entries", query: query) { |r| r["time_entries"] }
    response.map { |e| TimeEntry.new(e) }
  end

  def user_id
    @user_id ||= ENV["HARVEST_USER_ID"].presence || raise(StandardError, "Env HARVEST_ACCOUNT_ID is required")
  end

  private

  def api(path)
    "https://api.harvestapp.com/v2/#{path}"
  end

  def get(path, **options)
    response = HTTParty.get api(path), headers: headers, **options
    raise StandardError, "wrong response from Harvest: #{response.code} #{response.message}" unless response.ok?

    response
  end

  def get_all(path, **options)
    values = []
    options_without_query = options.excluding(:query)
    next_page = :first
    until next_page.nil?
      response = next_page == :first ?
        HTTParty.get(api(path), headers: headers, **options) :
        HTTParty.get(next_page, headers: headers, **options_without_query)
      raise StandardError, "wrong response from Harvest: #{response.code} #{response.message}" unless response.ok?

      values += yield(response)
      next_page = response.dig("links", "next")
    end

    values
  end

  def access_token
    @access_token ||= ENV["HARVEST_ACCESS_TOKEN"].presence || raise(StandardError, "Env HARVEST_ACCESS_TOKEN is required")
  end

  def account_id
    @account_id ||= ENV["HARVEST_ACCOUNT_ID"].presence || raise(StandardError, "Env HARVEST_ACCOUNT_ID is required")
  end

  def headers
    @headers ||= {
      "Authorization" => "Bearer #{access_token}",
      "Harvest-Account-Id" => account_id
    }
  end
end
