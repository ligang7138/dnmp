local cache_ngx = ngx.shared.ngx_cache


-- cache_ngx:get('aa')


cache_ngx:set('aa','aabb',60 * 60)