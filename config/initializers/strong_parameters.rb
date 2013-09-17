ActiveRecord::Base.send(:include, ActiveModel::ForbiddenAttributesProtection)

ActiveSupport.on_load(:action_controller) do
  include ActionController::StrongParameters
end
