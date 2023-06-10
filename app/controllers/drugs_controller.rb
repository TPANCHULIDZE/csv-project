# frozen_string_literal: true

class DrugsController < ApplicationController
  PER_PAGE = 5
  before_action :authenticate_user!
  before_action :set_drug, only: %i[show destroy]

  def index
    @query = Drug.ransack(params[:query])
    @drugs = paginate_drugs @query.result(distinct: true)
  end

  def show
    @query = Drug.ransack(params[:query])

    @drugs_with_same_name = @query.result
                                  .where(name: @drug.name)

    @total_price = @drugs_with_same_name.sum('price')
    @total_amount = @drugs_with_same_name.sum('amount')
    @countity = @drugs_with_same_name.size

    @drugs_with_same_name = paginate_drugs @drugs_with_same_name.where
                                                                .not(id: @drug)
  end

  def create
    csv_parser = CsvParser.new

    csv_parser.call(drug_params[:csv])

    redirect_to drugs_path
  rescue StandardError => e
    Rails.logger.debug e
    redirect_to new_drug_path, status: :unprocessable_entity
  end

  def destroy
    @drug.destroy
  end

  private

  def drug_params
    params.require(:drug).permit(:csv)
  end

  def set_drug
    @drug = Drug.find_by(id: params[:id])
  end

  def paginate_drugs(drugs)
    drugs.page(params[:page] || 1).per(PER_PAGE)
  end
end
