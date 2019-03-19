require "HTTParty"
require "dotenv"
require "awesome_print"

module Slack
  class Channel
    CHANNEL_URL = "https://slack.com/api/channels.list"

    class SlackError < StandardError; end

    Dotenv.load

    attr_reader :channel_id, :channel_name, :topic, :member_count
    attr_accessor :channel_name, :topic

    def initialize(channel_id, channel_name, topic)
      @channel_id = channel_id
      @channel_name = channel_name
      @topic = topic
      @member_count = member_count
    end # initialize

    def self.list
      query_parameters = {
        token: ENV["SLACK_API_TOKEN"],
      }
      response = HTTParty.get(CHANNEL_URL, query: query_parameters)
      ENV["SLACK_API_TOKEN"]

      if (response.code == 200)
        response["channels"].map do |channel|
          channel["name"]
        end # each
      else
        puts "Error #{response.code} : #{response["message"]}"
      end # else
    end # self.list

    ap self.list
  end # class
end # module
