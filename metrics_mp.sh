#!/bin/bash

# Include the magic
. demo/demo-magic/demo-magic.sh

# Configure the options
DEMO_PROMPT='\MetricsMP$ '
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

echo -e "${GREEN}Metrics in Prometheus format${COLOR_RESET}"
pe "curl -s -X GET http://localhost:8080/metrics/"

wait

echo
echo -e "${GREEN}Metrics in JSON format${COLOR_RESET}"
pe "curl -s -H 'Accept: application/json' -X GET http://localhost:8080/metrics/ | json_pp"

wait

echo
echo -e "${GREEN}Custom metric${COLOR_RESET}"
echo 
echo "Add the following annotations on GreetingResource::getDefaultMessage() and restart the service:"
echo
echo -e "${BLUE}@Timed${COLOR_RESET}"
echo -e "${BLUE}@Counted(name = \"greet.default.counter\", monotonic = true, absolute = true)${COLOR_RESET}"
echo

wait

pe "curl -s -H 'Accept: application/json' -X GET http://localhost:8080/metrics/application/greet.default.counter | json_pp"

wait

TYPE_SPEED=60
NO_WAIT=true
echo
echo -e "${GREEN}For not zero result let's call greeting service${COLOR_RESET}"
pe "curl -X GET http://localhost:8080/greet"

echo
echo -e "${GREEN}... and once more${COLOR_RESET}"
pe "curl -X GET http://localhost:8080/greet"

NO_WAIT=true

echo
echo -e "${GREEN}Check our custom metric again${COLOR_RESET}"
pe "curl -s -H 'Accept: application/json' -X GET http://localhost:8080/metrics/application/greet.default.counter | json_pp"
