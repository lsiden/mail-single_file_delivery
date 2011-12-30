require "mail-single_file_delivery/version"

module Mail
  module SingleFileDelivery
    class Agent
      attr_accessor :settings

      def initialize(settings={})
        self.settings = {:location => '/tmp/mail-single_file'}.merge! settings
        location = self.settings[:location]
        @fd = File.open(location, "w") \
          or raise "Cannot open #{location} for writing" # just being safe
      end

      def deliver!(mail)
        @fd.write mail.encoded
        @fd.flush
      end
    end
  end
end
