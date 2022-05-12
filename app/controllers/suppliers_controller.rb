class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
  end
  
  def create
    supplier_params = params.require(:supplier).permit(:corporate_name, :brand_name, :city, :state,
                                                 :full_adress, :email, :registration_number, :phone_number)
    @supplier = Supplier.new(supplier_params)
    
    if @supplier.save()
      redirect_to suppliers_path, notice: 'Fornecedor cadastrado com sucesso'
    else
      flash.now[:notice] = 'Fornecedor não cadastrado'
      render 'new'
    end

  end

  def show
    @supplier = Supplier.find(params[:id])
  end
end