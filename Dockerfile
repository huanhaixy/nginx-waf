#openrestry Dockerfile https://github.com/openresty/docker-openresty/blob/master/alpine/Dockerfile
# wafmaster https://github.com/unixhot/waf
# waftar get from curl -L https://github.com/unixhot/waf/archive/v1.0.0.tar.gz  -o waf.tar.gz
FROM openresty/openresty:1.15.8.2-4-alpine
COPY waf.tar.gz /tmp
RUN cd /tmp \ 
    && ls \
    && tar zxvf waf.tar.gz \ 
    && \cp -rf waf-1.0.0/waf/* /usr/local/openresty/site/lualib \
    && rm -rf /tmp/*
COPY config.lua /usr/local/openresty/site/lualib/
COPY default.conf /etc/nginx/conf.d/
COPY ngx_http_headers_more_filter_module.so /usr/local/openresty/nginx/modules/
COPY resty.index /usr/local/openresty/
CMD ["nginx","-g", "daemon off;"]
