#!/bin/bash

# Include the magic
. demo/demo-magic/demo-magic.sh

# Configure the options
DEMO_PROMPT='HealthSE$ '
NO_WAIT=false
TYPE_SPEED=20

# Clear screen
clear

echo 
echo -e "${RED}##############################################################"
echo -e "${RED}                Make sure SE demo is running"
echo -e "${RED}##############################################################"
echo -e "${COLOR_RESET}"

wait

pe "curl -s -X GET http://localhost:8080/health/ | json_pp"

wait

echo
echo -e "${GREEN}Custom health check${COLOR_RESET}"
echo 
echo -e "${BLUE}Add to HealthSupport initialization in Main${COLOR_RESET}"
echo
echo -e "${WHITE}.add(() -> HealthCheckResponse.named(\"custom\") // a custom health check"
echo -e "                        .up()"
echo -e "                        .withData(\"timestamp\", System.currentTimeMillis())"
echo -e "                        .build())${COLOR_RESET}"
echo

wait

pe "curl -s -X GET http://localhost:8080/health/ | json_pp"