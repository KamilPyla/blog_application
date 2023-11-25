module Transactionable
  extend ActiveSupport::Concern

  def in_transaction(&block)
    ActiveRecord::Base.transaction(&block)
  end
end
