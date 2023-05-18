# frozen_string_literal: true


# :startdoc:

class JXON
  #
  # A dynamically json template.
  # For many usage, such as RESTful applications, Json body
  #
  def initialize &blk
    #
    # usage example:
    #
    #    tmp = JXON.new {|**kwargs|
    #      stkws, body = * kwargs.exceptlast(:proxy,:host,:path,:req)
    #      # separate request headers and body.
    #      return {
    # This is the request header
    #        **stkws,
    #        post:{
    # This is the request body
    #          **body
    #        }
    #      }
    #    }
    #
    # To reuse this json template:
    #
    #    clientjson = JXON.new{|**kwargs|
    #    tmp2.fill(host: "www.example.com",
    #      id: "account", pwd: "password", **kwargs)
    #    }
    #
    # POST example.
    #
    #    POST **clientjson.fill(path: "/api", motion: "follow", motion_obj: "what" )
    #
    @blk = blk
  end



  def fill *args, **kwargs
    @blk.call(*args, **kwargs)
  end

  def dup *args, **kwargs
    #
    # usage example:
    #
    #    template = JXON.new{|a,b,c, **kwargs|
    #      return {
    #               a:a, b:b, c:c,
    #                 d:{
    #                     **kwargs}}}}
    #
    #    client = template.dup(1, acc:"yes", password: "no")
    #    client.fill(2, 3, motion: "go")
    #
    self.class.new{|*as, **kws|
      self.fill(*args, *as, **kws, **kwargs)
    }
  end
end


class Hash
  def get *keys
    keys.map do |key|
      [key,self[key]]
    end.to_h
  end
  # def except *keys
  #   hsh = {**self}
  #   keys.each do |key|
  #     hsh.delete(key)
  #   end
  #   hsh
  # end
  def exceptlast(*keys)
    '''[except of hash, last of exceptions]'''
    [self.get(*keys), self.except(*keys)]
  end
  def concat ano
    {**self, **ano}
  end
end
