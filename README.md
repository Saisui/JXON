# JXON

# Installation
```
gem intall jxon
```
usage example

示例用法
```ruby
tmp = JXON.new {|proxy, host, path, req, id, pwd, **kwargs|
  {
    proxy: proxy,
    host: host,
    path: path,
    req: req,
    post:{
      id: id,
      pwd: pwd,
      **kwargs,
    }
  }
}

tmp2 = JXON.new {|**kwargs|
  stkws, body = * kwargs.exceptlast(:proxy,:host,:path,:req)
  #
  # separate request headers and body.
  # 分割两部分，请求头和请求体分开。
  #
  return {
    **stkws,
    post:{
      **body
    }
  }
}

JXON.new{|proxy, path, req, **kwargs|
  tmp.fill(proxy, "www.example.com", path, req,
    "account", "password", **kwargs)
}


JXON.new{|**kwargs|
  tmp2.fill(host: "www.example.com",
    id: "account", pwd: "password", **kwargs)
}
```
## JXON#ref 方法

填充模板一部分内容，克隆为另外一份模板（会引用原模板）

```ruby
client = tmp.ref(host: "www.example.com", id: "account", pwd: "password")
client.fill(motion:"go")

```
