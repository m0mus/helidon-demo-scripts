#!/bin/bash

# Include the magic
. demo/demo-magic/demo-magic.sh

# Configure the options
DEMO_PROMPT='\MetricsSE$ '
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
echo -e "${BLUE}1. Property in GreetService${COLOR_RESET}"
echo
echo -e "${WHITE}private final Counter defaultMessageCounter;${COLOR_RESET}"
echo
echo -e "${BLUE}2. Initialization in constructor${COLOR_RESET}"
echo
echo -e "${WHITE}RegistryFactory metricsRegistry = RegistryFactory.getRegistryFactory().get();${COLOR_RESET}"
echo -e "${WHITE}MetricRegistry appRegistry = metricsRegistry.getRegistry(MetricRegistry.Type.APPLICATION);${COLOR_RESET}"
echo -e "${WHITE}this.defaultMessageCounter = appRegistry.counter(\"greet.default.counter\");${COLOR_RESET}"
echo
echo -e "${BLUE}3. Increment in ${WHITE}getDefaultMessageHandler${BLUE} method${COLOR_RESET}"
echo
echo -e "${WHITE}defaultMessageCounter.inc();${COLOR_RESET}"
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

NO_WAIT=false

echo
echo -e "${GREEN}Check our custom metric again${COLOR_RESET}"
pe "curl -s -H 'Accept: application/json' -X GET http://localhost:8080/metrics/application/greet.default.counter | json_pp"