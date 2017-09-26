class MarketsController < ApplicationController
  def payment
    #byebug
    @product = Product.find(params[:id])
    temp_params=@product
    temp_params.status=0
    #temp_params.update()
    #@product.update(name: 'test update' , description: 'test update d', price: 200, status: 0, category_id: 980190965,user_id: 980190963)
    #temp_params.status.new(status: 0)
    @product.update(status: 0)
    
  end
  
  def item_detail
    #params[:id]はproduct_id
    @product=Product.find(params[:id])
    
  end
  

end
