#!/bin/bash

# Include the magic
. demo/demo-magic/demo-magic.sh

# Configure the options
DEMO_PROMPT='HealthMP$ '
NO_WAIT=false
TYPE_SPEED=20

# Clear screen
clear

echo 
echo -e "${RED}##############################################################"
echo -e "${RED}                Make sure MP demo is running"
echo -e "${RED}##############################################################"
echo -e "${COLOR_RESET}"

wait

echo -e "${GREEN}HealthCheck is switch on by default${COLOR_RESET}"

pe "curl -s -X GET http://localhost:8080/health/ | json_pp"

wait

echo
echo -e "${GREEN}Custom health check${COLOR_RESET}"
echo 
cp -a demo/healthcheck-mp/. .

wait

pe "curl -s -X GET http://localhost:8080/health/ | json_pp"