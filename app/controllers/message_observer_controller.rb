# class MessageObserverController < FayeRails::Controller
#   observe Message, :after_create do |new_message|
#     p "*****TEST******"
#     MessageObserverController.publish('/me/messages', new_widget.attributes)
#   end
# end