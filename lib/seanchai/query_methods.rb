module Seanchai
  module QueryMethods

    def find_visible_for(user, criteria = {}, options = {})
      results = self.where(criteria).
          or([{status_id: Status[:published].id}, {creator: user}])

      results = order_results(results, options[:order_by]) #if options[:order_by]
      results = limit_results(results, options[:limit], options[:skip])
      results if results.count > 0
    end

    def order_results(results, order)
      results.order_by(order)
    end

    def limit_results(results, limit, skip)
      results.skip(skip).limit(limit)
    end

  end
end