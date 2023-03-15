class PassagesController < ApplicationController
  def index
  end

  def search
    begin
      search_query = prepare_search_query(extract_search_query)
      @passage = get_passage(search_query)
    rescue => error
      # TODOs:
      # - render when 404.
      puts "error #{error}, #{config}"
    else
      # TODO
      puts "no risen error"
    end
  end

private
  def extract_search_query
    params.permit(:search).require(:search)
  end

  def prepare_search_query(search_query)
    search_query.gsub(/\s+/, "+")
  end

  def get_passage(search_query)
    response = RestClient.get(
      "https://bible-api.com/#{search_query}",
      {
        accept: :json,
        params: {
          translation: "bbe"
        }
      }
    )

    JSON.parse(response.body)
  end
end
