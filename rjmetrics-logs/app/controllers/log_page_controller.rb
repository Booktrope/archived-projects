class LogPageController < ApplicationController
  def show
  	@logs = Parse::Query.new("RJMetricsLogEntry").tap do | q |
  		q.limit = 1000
  		q.order_by = "-createdAt"
  	end.get
  end
end
