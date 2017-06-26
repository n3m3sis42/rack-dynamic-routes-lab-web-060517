class Application
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item = find_item(req)
      if item.nil?
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write item.price.to_s
      end 
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

  def find_item(req)
    @@items.find {|item| item.name == req.path.split("/items/").last}
  end

end
