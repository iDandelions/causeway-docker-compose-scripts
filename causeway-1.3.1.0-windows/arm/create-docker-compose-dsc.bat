@echo off
set rootfolder=%USERPROFILE%\Desktop
set rootfolder=%rootfolder:\=/%
cd %rootfolder%
md causeway
cd causeway
md volumes
cd volumes
md frontend
md backend
md typedb
cd ..
del docker-compose.yml
echo services:>>docker-compose.yml
echo   typedb:>>docker-compose.yml
echo     image: public.ecr.aws/r5d0x2q7/typedb:arm>>docker-compose.yml
echo     container_name: typedb>>docker-compose.yml
echo     volumes:>>docker-compose.yml
echo       - "geminos:/data/typedb:rw">>docker-compose.yml
echo       - "%rootfolder%/causeway/volumes/typedb:/typedb:rw">>docker-compose.yml
echo     networks:>>docker-compose.yml
echo       causewaynet:>>docker-compose.yml
echo         ipv4_address: 172.24.2.1>>docker-compose.yml
echo     ports:>>docker-compose.yml
echo       - "1729:1729">>docker-compose.yml
echo     restart: always>>docker-compose.yml
echo   causewaygui:>>docker-compose.yml
echo     image: public.ecr.aws/r5d0x2q7/causewaygui:dsc>>docker-compose.yml
echo     container_name: "causewaygui">>docker-compose.yml
echo     volumes:>>docker-compose.yml
echo       - "geminos:/data:rw">>docker-compose.yml
echo       - "geminos:/root:rw">>docker-compose.yml
echo       - "%rootfolder%/causeway/volumes/frontend:/frontend:rw">>docker-compose.yml
echo     networks:>>docker-compose.yml
echo       causewaynet:>>docker-compose.yml
echo         ipv4_address: 172.24.2.2>>docker-compose.yml
echo     ports:>>docker-compose.yml
echo       - "1880:1880">>docker-compose.yml
echo     depends_on:>>docker-compose.yml
echo       - "typedb">>docker-compose.yml
echo     restart: always>>docker-compose.yml
echo   causewayapi:>>docker-compose.yml
echo     image: public.ecr.aws/r5d0x2q7/causewayapi:latest>>docker-compose.yml
echo     container_name: "causewayapi">>docker-compose.yml
echo     volumes:>>docker-compose.yml
echo       - "geminos:/data/causal-api-server/geminosnb:rw">>docker-compose.yml
echo       - "geminos:/data:rw">>docker-compose.yml
echo       - "geminos:/root:rw">>docker-compose.yml
echo       - "%rootfolder%/causeway/volumes/frontend:/backend:rw">>docker-compose.yml
echo     restart: "always">>docker-compose.yml
echo     networks:>>docker-compose.yml
echo       causewaynet:>>docker-compose.yml
echo         ipv4_address: 172.24.2.3>>docker-compose.yml
echo     ports:>>docker-compose.yml
echo       - "5001:5001">>docker-compose.yml
echo     depends_on:>>docker-compose.yml
echo       - "typedb">>docker-compose.yml
echo       - "causewaygui">>docker-compose.yml
echo networks:>>docker-compose.yml
echo   causewaynet:>>docker-compose.yml
echo     driver: bridge>>docker-compose.yml
echo     ipam:>>docker-compose.yml
echo       driver: default>>docker-compose.yml
echo       config:>>docker-compose.yml
echo         - subnet: "172.24.2.0/16">>docker-compose.yml
echo volumes:>>docker-compose.yml
echo   geminos:>>docker-compose.yml
echo     driver: local>>docker-compose.yml
pause
docker compose up -d
pause
