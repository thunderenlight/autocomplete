class User < ApplicationRecord

	include PgSearch
	pg_search_scope :search_by_full_name, against: [:name, :surname]
end
