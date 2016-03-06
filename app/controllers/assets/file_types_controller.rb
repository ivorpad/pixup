class Assets::FileTypesController < AssetsController

  def show
    @category = Category.friendly.find(params[:categories_id])

    file_type_whitelist = %w{ images videos }

    file_type_whitelist.each do |file_type|
      if params[:type] == file_type
       @assets = @category.assets.send(file_type)
      end
    end
  end
end
