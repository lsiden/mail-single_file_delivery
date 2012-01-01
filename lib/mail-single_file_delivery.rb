require "mail-single_file_delivery/version"

module Mail
  module SingleFileDelivery
    class Agent
      attr_accessor :settings

      def initialize(settings={})
        self.settings = {:filename => '/tmp/mail-single_file'}.merge! settings
        filename = self.settings[:filename]
        mode = File.pipe?(filename) ? 'a+' : 'w'
        @fd = File.open(filename, mode) \
          or raise "Cannot open #{filename} for writing" # just being safe
      end

      def deliver!(mail)
        @fd.write mail.encoded + "\r\n\r\n"
        @fd.flush
      end
    end
  end
end
