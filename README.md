# lsiobase-webhook-gateway

```
docker run -d \
--name webhook-gateway \
--network production-network \
--restart unless-stopped \
--label "traefik.enable=true" \
--label "traefik.basic.frontend.rule=Host:webhook-gateway.example.com" \
--label "traefik.basic.port=8080" \
-e APPRISE_ENDPOINTS="slack://XXXX/XXXX/XXXX/#general" \
-e WEBHOOK_AUTH=yes \
-e WEBHOOK_TOKEN_NAME=x-gw-token \
-e WEBHOOK_TOKEN_VALUE=secret \
-e TZ=Europe/Prague \
lukasmrtvy/lsiobase-webhook-gateway
```

# env variables
- APPRISE_ENDPOINTS ( Required, mutually exculsive to APPRISE_CONFIG_PATH )
- APPRISE_CONFIG_PATH ( Required, mutually exculsive to APPRISE_ENDPOINTS )
- WEBHOOK_AUTH ( Optional, Default: no )
- WEBHOOK_TOKEN_NAME ( Optional, Default: 4UTH )
- WEBHOOK_TOKEN_VALUE ( Optional, Default: <random> )
- TZ ( Optional, Default: UTC )
- PUID
- PGID
- HAPROXY_http_req_rate ( Optional, Default: 10s ) 
- HAPROXY_http_req_expire ( Optional, Default: 30s )
- HAPROXY_http_req_count ( Optional, Default: 20 ) 

# ports
- 8080 ( haproxy frontend with rate limiting )
- 9000 ( backend )

# batteries included
- haproxy
- tini
- supervisord
- apprise
- webhook

# usage
```
curl http://docker-webhook-gateway:8080/hooks/notify?title=foo&body=bar
```

# todo
webhook sighup handling
