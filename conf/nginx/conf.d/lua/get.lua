local cache_ngx = ngx.shared.ngx_cache


-- cache_ngx:get('aa')

ngx.say(cache_ngx:get('aa'))