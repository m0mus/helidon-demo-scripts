#!/bin/bash

# Include the magic
. demo/demo-magic/demo-magic.sh

# Configure the options
DEMO_PROMPT='TracingMP$ '
NO_WAIT=false
TYPE_SPEED=20

# Clear screen
clear

# Run Zipkin in docker
pe "docker run -d -p 9411:9411 openzipkin/zipkin"

# Open Zipkin console
pe "open http://localhost:9411/zipkin/"

wait

echo
echo -e "${BLUE}1. Add dependencies${COLOR_RESET}"
echo -e "${WHITE}"
echo "<dependency>"
echo "   <groupId>io.helidon.microprofile.tracing</groupId>"
echo "   <artifactId>helidon-microprofile-tracing</artifactId>"
echo "</dependency>"
echo "<dependency>"
echo "   <groupId>io.helidon.tracing</groupId>"
echo "   <artifactId>helidon-tracing-zipkin</artifactId>"
echo "</dependency>"
echo -e "${RESET_COLOR}"
echo -e "${BLUE}2. Add service name to microprofile-config.properties${COLOR_RESET}"
echo -e "${WHITE}"
echo "tracing.service=helidon-mp"
echo -e "${RESET_COLOR}"

wait

NO_WAIT=true
TYPE_SPEED=""

pe "curl -X GET http://localhost:8080/greet"
pe "curl -X GET http://localhost:8080/greet/Joe"
pe "curl -X GET http://localhost:8080/greet"
pe "curl -X GET http://localhost:8080/greet/Tomas"
pe "curl -X GET http://localhost:8080/greet"

NO_WAIT=false

pe "open http://localhost:9411/zipkin/"