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

    total(@drugs_with_same_name)

    @drugs_with_same_name = paginate_drugs @drugs_with_same_name.where
                                                                .not(id: @drug)
  end

  def companies
    @query = Drug.ransack(params[:query])
    @drugs_from_same_company = @query.result.where(company: params[:company])

    total(@drugs_from_same_company)
    @company_name = params[:company]
    @drugs_from_same_company = paginate_drugs @drugs_from_same_company
  end

  def create
    csv_parser = CsvParser.new

    countity = csv_parser.call(drug_params[:csv])

    if countity.positive?
      redirect_to drugs_path, notice: "create or update #{countity} new drug#{countity > 1 ? 's' : ''}"
    else
      redirect_to drugs_path, status: :unprocessable_entity, alert: 'drugs already exist or some info is incorrect'
    end
  rescue StandardError => _e
    redirect_to drugs_path, status: :unprocessable_entity, alert: 'csv file info is incorrect'
  end

  def destroy
    name = @drug&.name
    if @drug&.destroy
      redirect_to drugs_path, notice: "delete #{name}"
    else
      redirect_to drugs_path, status: :unprocessable_entity, alert: 'something is wrong'
    end
  end

  private

  def total(drugs)
    @total_amount = drugs.sum('amount')
    @total_price = drugs.sum('price * amount')
    @countity = drugs.size
  end

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
