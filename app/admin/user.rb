ActiveAdmin.register User do

  index do
    column :name
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :role
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
      f.input :role, as: :select, collection: User.roles.keys
    end
    f.button "Save"
  end

  controller do
  def update
    # get the currently logged in User's id
    current_id = current_admin_user.id
    # load the User being updated
    @user = User.find(params[:id])
    # update the User with new attributes
    # if successful, this will sign out the User being updated
    if @user.update_attributes(permitted_params[:user])
      # if the updated User was the currently logged in User, sign them back in
      if @user.id == current_id
        sign_in(User.find(current_id), :bypass => true)
      end
      flash[:notice] = I18n.t('devise.passwords.updated_not_active')
      redirect_to '/admin/users'
    # display errors
    else
      render :action => :edit
    end
  end
end

  permit_params :user, :name, :password, :password_confirmation, :company, :email, :admin, :role
end
