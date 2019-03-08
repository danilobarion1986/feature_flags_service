require 'roda'

class App < Roda
  route do |r|
    # GET / request
    r.root do
      'My Roda App!'
    end

    # /feature branch
    r.on 'feature' do
      # Set variable for all routes in /feature branch
      @feature = 'my_feature'

      # /hello request
      r.is do
        # GET /hello request
        r.get do
          "#{@feature}!"
        end
      end
    end
  end
end

run App.freeze.app
