module BaseActions
  class UserForm < BaseForm
    attribute :first_name
    attribute :last_name
    attribute :login

    attribute :about_me, ActionText::RichText
    attribute :avatar, ActiveStorage::Attached::One
  end
end
