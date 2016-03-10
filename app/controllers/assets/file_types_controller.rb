class Assets::FileTypesController < AssetsController

  def show
    @category = Category.friendly.find(params[:categories_id])
    @project = Project.friendly.find(params[:project_id])
    @assets_content_type = Asset.pluck(:content_type).uniq
    @filtered_assets = Asset.filtered_by_type(params[:type], @category)

    file_type = params[:type]
    @assets = Asset.none

    file_type_whitelist = %w{ image video audio application }

    if file_type_whitelist.include?(file_type)
      @assets = @category.assets.send(file_type)
    end
  end
end
