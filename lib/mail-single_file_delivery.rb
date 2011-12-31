require "mail-single_file_delivery/version"

module Mail
  module SingleFileDelivery
    class Agent
      attr_accessor :settings

      def initialize(settings={})
        self.settings = {:filename => '/tmp/mail-single_file'}.merge! settings
        filename = self.settings[:filename]
        @fd = File.open(filename, "w") \
          or raise "Cannot open #{filename} for writing" # just being safe
      end

      def deliver!(mail)
        @fd.write mail.encoded
        @fd.flush
      end
    end
  end
end
