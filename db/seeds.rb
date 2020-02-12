Dir[Rails.root.join('db/seeds/*.rb')].sort.each { |seed| load seed }
