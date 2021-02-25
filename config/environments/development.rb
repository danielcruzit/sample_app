require "active_support/core_ext/integer/time"

Rails.application.configure do
   
   config.hosts.clear
   config.active_storage.service = :local

end
