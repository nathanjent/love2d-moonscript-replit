url = require "socket.url"
https = require "ssl.https"
ltn12 = require "ltn12"

export class ReplitDbClient
  new:(db_url = os.getenv("REPLIT_DB_URL")) =>
    @db_url = db_url

  get:(key)=>
    t = {}
    res, code, headers = https.request {
      url: "#{@db_url}/#{key}"
      method: "GET"
      sink: ltn12.sink.table t
    }
    table.concat(t), res, code, headers

  set:(key, value)=>
    key = url.escape key
    value = url.escape value
    str_body = "#{key}=#{value}"
    https.request {
      url: @db_url
      method: "POST"
      source: str_body and ltn12.source.string str_body
      headers:
        "Content-Type": "application/x-www-form-urlencoded"
        "Content-Length": string.len str_body
    }
      
  delete:(keys)=>
    https.request {
      url: "#{@db_url}/#{key}"
      method: "DELETE"
    }
      
  list:(prefix="")=>
    prefix=url.escape prefix
    r, c, h = https.request "#{@db_url}?encode=true&prefix=#{prefix}"
    if string.len(r) == 0
      {}
    else
      t={}
      for str in string.gmatch inputstr, "([^\n]+)"
        table.insert t, str
      t

  get_all:=>
    t={}
    for k in *@list!
      table.insert t, @get k
    t

  delete_all:=>
    delete_many @list!

  set_many:(obj={})=>
    for k,v in pairs obj
      @set k,v

  delete_many:(obj={})=>
    for k in *obj
      @delete k