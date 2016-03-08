class Assets::FileTypesController < AssetsController

  def show
    @category = Category.friendly.find(params[:categories_id])

    file_type_whitelist = %w{ image video audio application }

    file_type_whitelist.each do |file_type|
       @assets = @category.assets.send(file_type) if params[:type] == file_type
    end
  end
end
