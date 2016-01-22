ActiveAdmin.register Project do
 permit_params :title, :description, :favorite, :private

# find record with slug(friendly_id)
 controller do
   def find_resource
     begin
       scoped_collection.where(slug: params[:id]).first!
     rescue ActiveRecord::RecordNotFound
       scoped_collection.find(params[:id])
     end
   end
 end
end
