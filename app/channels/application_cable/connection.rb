module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
 
    def connect
      self.current_user = find_verified_user
    end
 
    protected
      def find_verified_user
        if  verified_user = User.find_by(id: user_id) #cookies.signed[:user_id])
          verified_user
        else
          reject_unauthorized_connection
        end
      end

      def user_id
        user_id = cookies.encrypted['_qna_session']&.dig('warden.user.user.key')&.first&.first
      end
  
  #def disconnect
  #end

  end
end

