#!/bin/bash
# path = " ./create-docker-compose.sh"
cd ~/desktop
mkdir causeway-docker
cd causeway-docker
mkdir volumes
cd volumes
mkdir  frontend
mkdir  backend
mkdir  typedb
cd ..
rm docker-compose.yml
echo version: '"'3'"'>>docker-compose.yml
echo services:>>docker-compose.yml
echo -e ' ' typedb:>>docker-compose.yml
echo -e '  ' image: harbor.fliite.systems/geminos/typedb:arm>>docker-compose.yml
echo -e '  ' container_name: typedb>>docker-compose.yml
echo -e '  ' volumes:>>docker-compose.yml
echo -e '   ' - geminos:/data/typedb:rw>>docker-compose.yml
echo -e '   ' - ~/causeway-docker/volumes/typedb:/typedb:rw>>docker-compose.yml
echo -e '  ' networks:>>docker-compose.yml
echo -e '   ' causewaynet:>>docker-compose.yml
echo -e '    ' ipv4_address: 172.24.2.1>>docker-compose.yml
echo -e '  ' ports:>>docker-compose.yml
echo -e '   ' - "1729:1729">>docker-compose.yml
echo -e '  ' restart: always>>docker-compose.yml
echo -e ' ' gui:>>docker-compose.yml
echo -e '  ' image: harbor.fliite.systems/geminos/causewaygui:1.3.1.0>>docker-compose.yml
echo -e '  ' container_name: causewaygui>>docker-compose.yml
echo -e '  ' volumes:>>docker-compose.yml
echo -e '   ' - geminos:/data:rw>>docker-compose.yml
echo -e '   ' - geminos:/root:rw>>docker-compose.yml
echo -e '   ' - ~/causeway-docker/volumes/frontend:/frontend:rw>>docker-compose.yml
echo -e '  ' networks:>>docker-compose.yml
echo -e '   ' causewaynet:>>docker-compose.yml
echo -e '    ' ipv4_address: 172.24.2.2>>docker-compose.yml
echo -e '  ' ports:>>docker-compose.yml
echo -e '   ' - "1880:1880">>docker-compose.yml
echo -e '  ' depends_on:>>docker-compose.yml
echo -e '   ' - "typedb">>docker-compose.yml
echo -e '  ' restart: always>>docker-compose.yml
echo -e ' '  api:>>docker-compose.yml
echo -e '  ' image: harbor.fliite.systems/geminos/causewayapi:1.3.1.0>>docker-compose.yml
echo -e '  ' container_name: causewayapi>>docker-compose.yml
echo -e '  ' volumes:>>docker-compose.yml
echo -e '   ' - geminos:/data/causal-api-server/geminosnb:rw>>docker-compose.yml
echo -e '   ' - geminos:/data:rw>>docker-compose.yml
echo -e '   ' - geminos:/root:rw>>docker-compose.yml
echo -e '   ' - ~/causeway-docker/volumes/backend:/backend:rw>>docker-compose.yml
echo -e '  ' restart: "always">>docker-compose.yml
echo -e '  ' networks:>>docker-compose.yml
echo -e '   ' causewaynet:>>docker-compose.yml
echo -e '    ' ipv4_address: 172.24.2.3>>docker-compose.yml
echo -e '  ' ports:>>docker-compose.yml
echo -e '   ' - "5001:5001">>docker-compose.yml
echo -e '  ' depends_on:>>docker-compose.yml
echo -e '   ' - typedb>>docker-compose.yml
echo -e '   ' - gui>>docker-compose.yml
echo networks:>>docker-compose.yml
echo -e '  ' causewaynet:>>docker-compose.yml
echo -e '   ' driver: bridge>>docker-compose.yml
echo -e '   ' ipam:>>docker-compose.yml
echo -e '    ' driver: default>>docker-compose.yml
echo -e '    ' config:>>docker-compose.yml
echo -e '     ' - subnet: "172.24.2.0/16">>docker-compose.yml
echo volumes:>>docker-compose.yml
echo -e '  ' geminos:>>docker-compose.yml
echo -e '   ' driver: local>>docker-compose.yml
exec docker compose up -d