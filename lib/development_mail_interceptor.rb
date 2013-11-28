class DevelopmentMailInterceptor
   def self.delivering_email(message)
        message.subject = "[#{message.to}] #{message.subject}"
        message.to = "rubyrails88@gmail.com"
   end
end
