class PizzasController < ApplicationController
  before_action :set_order
  before_action :set_order_pizza, only: [:show, :update, :destroy]

  # GET /orders/:order_id/pizzas
  def index
    json_response(@order.pizzas)
  end

  # GET /orders/:order_id/pizzas/:id
  def show
    json_response(@pizza)
  end

  # POST /orders/:order_id/pizzas
  def create
    @order.pizzas.create!(pizza_params)
    json_response(@order, :created)
  end

  # PUT /orders/:order_id/pizzas/:id
  def update
    @pizza.update(pizza_params)
    head :no_content
  end

  # DELETE /orders/:order_id/pizzas/:id
  def destroy
    @pizza.destroy
    head :no_content
  end

  private

  def pizza_params
    params.permit(:name)
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_order_pizza
    @pizza = @order.pizzas.find_by!(id: params[:id]) if @order
  end
end
