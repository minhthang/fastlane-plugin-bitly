require 'fastlane/action'
require_relative '../helper/bitly_helper'
require 'bitly'

module Fastlane
  module Actions
    class BitlyAction < Action
      module SharedValues
        BITLY_SHORTLINK_OUTPUT ||= :BITLY_SHORTLINK_OUTPUT
      end

      def self.run(params)
        UI.message("The bitly plugin is working!")
        token = params[:token]
        long_url = params[:long_url]
        client = Bitly::API::Client.new(token: token)
        bitlink = client.shorten(long_url: long_url)
        shortlink = bitlink.link
        Actions.lane_context[SharedValues::BITLY_SHORTLINK_OUTPUT] = shortlink
        ENV[SharedValues::BITLY_SHORTLINK_OUTPUT.to_s] = shortlink
      end

      def self.description
        "create bit.ly short link from url"
      end

      def self.authors
        ["Thang Nguyen"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "create bit.ly short link"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :token,
                                  env_name: "",
                               description: "Bitly Access API Token",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :long_url,
                                  env_name: "",
                               description: "Long link",
                                  optional: false,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        [:ios, :android].include?(platform)
        true
      end
    end
  end
end
