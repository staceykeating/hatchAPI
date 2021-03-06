class PackingItemsController < ApplicationController

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  def create
    @packing_item = PackingItem.create(packing_item_params)

    # Component.create({destination_id: @place["id"], title: "Restaurants"})

    @packing_items = PackingItem.where(trip_id: packing_item_params['trip_id'])
    render json: @packing_items
  end

  def update
    @packing_item = PackingItem.find(params[:id])
    @packing_item.description = packing_item_params['description']
    @packing_item.checked = packing_item_params['checked']
    @packing_item.creator_name = packing_item_params['creator_name']
    @packing_item.save!
    @packing_items = PackingItem.where(trip_id: packing_item_params['trip_id'])
    render json: @packing_items
  end

  def destroy
    @packing_item = PackingItem.find(params[:id])
    @packing_item.destroy
    @packing_items = PackingItem.where(trip_id: packing_item_params['trip_id'])
    render json: @packing_items
  end

  private

  def packing_item_params
    params.permit(
      :description,
      :trip_id,
      :checked,
      :creator_name
    )
  end
end
