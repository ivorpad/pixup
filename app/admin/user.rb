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
      f.input :admin, :label => "Super Administrator"
    end
    f.button "Save"
  end

  # create_or_edit = Proc.new {
  #   @user       = User.find_or_create_by(params[:id])
  #   @user.admin = permitted_params[:user][:admin]
  #   @user.attributes = permitted_params[:user].delete_if do |k, v|
  #     (k == "admin") ||
  #     (["password", "password_confirmation"].include?(k) && v.empty? && !@user.new_record?)
  #   end
  #   if @user.save
  #     redirect_to :action => :show, :id => @user.id
  #   else
  #     render active_admin_template((@user.new_record? ? 'new' : 'edit') + '.html.erb')
  #   end
  # }
  # member_action :create, :method => :post, &create_or_edit
  # member_action :update, :method => :put, &create_or_edit

  permit_params :user, :name, :password, :password_confirmation, :company, :email, :admin
end
