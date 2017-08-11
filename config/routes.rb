# Rails.application.routes.draw do
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#   resources :users, only: [:index]  
#   root to: 'users#index'
#   resources :messages, only: [:new]
#   resources :cities, only: [:index]
# end


hsh = {"a"=> 21, "b" => true, "c"=> 23}

def optimize(hsh)   
	hsh.reduce({}) do |new_hsh, (k,v)| 	
	new_hsh[k.to_sym] = v.kind_of?(Hash) ? optimize(v) : v 	
	new_hsh   
	end 
end

p optimize(hsh)

def flat(arr)
  array.each_with_object([]) do |el, flat_arr|
    flat_arr << (el.is_a?(Array) ? flat(el) : el)
  end
end

p flat([1,2,3,4,[1,2,3,4],5])