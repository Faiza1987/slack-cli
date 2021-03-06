require "dotenv"
require "httparty"
require "table_print"
require "awesome_print"
require_relative "user"
require_relative "channel"

Dotenv.load

module Slack
  class ResponseError < StandardError; end

  class Workspace
    BASE_URL = "https://slack.com/api/users.list"
    attr_reader :users, :channels
    attr_accessor :selection

    def initialize
      @users = User.list
      @channels = Channel.list
      @selection = nil
    end

    def select_user(name_or_id)
      users.each do |user|
        if name_or_id == user.name || name_or_id == user.slack_id || name_or_id == user.real_name
          @selection = user
        end
      end
      if @selection == nil
        return "Sorry, #{name_or_id} is not a valid user."
      end
      return @selection
    end

    def select_channel(name_or_id)
      @channels.each do |channel|
        if name_or_id == channel.name || name_or_id == channel.slack_id
          @selection = channel
        end
      end

      if @selection == nil
        return "Sorry, #{name_or_id} is not a valid channel."
      end
      return @selection
    end

    def show_details
      return @selection, @selection.details
      # if @selection == nil
      #   return false
      # ap @selection, @selection.details
      # end
      tp @selection, @selection.details
    end

    def send_message(text)
      if @selection == nil
        return false
      end

      if text == ""
        return nil
      end

      return @selection.send_message(@selection.slack_id, text)
    end
  end
end
