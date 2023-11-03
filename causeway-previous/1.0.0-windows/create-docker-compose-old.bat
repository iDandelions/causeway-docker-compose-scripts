@echo off
set rootfolder=E:/Docker
md causeway
cd causeway
md volumes
cd volumes
md frontend
md backend
md typedb
cd ..
del docker-compose.yaml
echo services:>>docker-compose.yaml
echo   typedb:>>docker-compose.yaml
echo     image: harbor.fliite.systems/geminos/typedb>>docker-compose.yaml
echo     container_name: typedb>>docker-compose.yaml
echo     volumes:>>docker-compose.yaml
echo       - "%rootfolder%/Causeway/Volumes/TypeDB:/typedb:rw">>docker-compose.yaml
echo     networks:>>docker-compose.yaml
echo       causewaynet:>>docker-compose.yaml
echo         ipv4_address: 172.24.2.1>>docker-compose.yaml
echo     ports:>>docker-compose.yaml
echo       - "1729:1729">>docker-compose.yaml
echo     restart: always>>docker-compose.yaml
echo   frontend:>>docker-compose.yaml
echo     image: harbor.fliite.systems/geminos/causeway_frontend:1.0.0>>docker-compose.yaml
echo     container_name: "causewaygui">>docker-compose.yaml
echo     volumes:>>docker-compose.yaml
echo       - "%rootfolder%/Causeway/Volumes/Frontend:/frontend:rw">>docker-compose.yaml
echo     networks:>>docker-compose.yaml
echo       causewaynet:>>docker-compose.yaml
echo         ipv4_address: 172.24.2.2>>docker-compose.yaml
echo     ports:>>docker-compose.yaml
echo       - "1880:1880">>docker-compose.yaml
echo     depends_on:>>docker-compose.yaml
echo       - "typedb">>docker-compose.yaml
echo     restart: always>>docker-compose.yaml
echo   backend:>>docker-compose.yaml
echo     image: harbor.fliite.systems/geminos/causeway_api:1.0.0>>docker-compose.yaml
echo     container_name: "causewayapi">>docker-compose.yaml
echo     volumes:>>docker-compose.yaml
echo       - "%rootfolder%/Causeway/Volumes/Frontend:/backend:rw">>docker-compose.yaml
echo     restart: "always">>docker-compose.yaml
echo     networks:>>docker-compose.yaml
echo       causewaynet:>>docker-compose.yaml
echo         ipv4_address: 172.24.2.3>>docker-compose.yaml
echo     ports:>>docker-compose.yaml
echo       - "5001:5001">>docker-compose.yaml
echo     depends_on:>>docker-compose.yaml
echo       - "typedb">>docker-compose.yaml
echo       - "frontend">>docker-compose.yaml
echo networks:>>docker-compose.yaml
echo   causewaynet:>>docker-compose.yaml
echo     driver: bridge>>docker-compose.yaml
echo     ipam:>>docker-compose.yaml
echo       driver: default>>docker-compose.yaml
echo       config:>>docker-compose.yaml
echo         - subnet: "172.24.2.0/16">>docker-compose.yaml
pause
docker compose up -d
pause