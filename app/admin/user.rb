ActiveAdmin.register User do

  index do
    column :name
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :role do |user|
          user.roles.collect {|role| role.name.capitalize }.to_sentence
    end
    column :email
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :company
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :roles, as: :check_boxes
    end
    f.button "Save"
  end

  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete "password"
        params[:user].delete "password_confirmation"
      end

      super
    end
  end

  permit_params :user, :name, :password, :password_confirmation, :company, :email, :admin, role_ids: []
end
