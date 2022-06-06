class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:show, :edit, :update]
  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create   
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save()
      redirect_to @order, notice: 'Pedido registrado com sucesso'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:notice] = 'Não foi possível registrar o pedido'
      render :new
    end
  end
  
  def show    
    check_user
  end

  def search
    @code = params["query"]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def edit   
    check_user
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update     
    check_user
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    if @order.update(order_params)
      redirect_to @order, notice: 'Pedido atualizado com sucesso.'
    end    
  end

  private

  def check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      redirect_to root_path, alert: 'Você não possui acesso a esse pedido'
    end
  end
end