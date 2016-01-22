ActiveAdmin.register User do

  index do
    column :name
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :admin
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
      f.input :admin, :label => "Administrator"
    end
    f.button "Save"
  end
  
  permit_params :user, :name, :password, :password_confirmation, :company, :email, :admin
end
