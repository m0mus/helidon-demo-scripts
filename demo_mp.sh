#!/bin/bash

# Include the magic
. demo/demo-magic/demo-magic.sh

# Configure the options
DEMO_PROMPT='\DemoMP$ '
NO_WAIT=false
TYPE_SPEED=""

# Clear screen
clear

# Checkout SE
pe "mvn archetype:generate -DinteractiveMode=false -DarchetypeGroupId=io.helidon.archetypes -DarchetypeArtifactId=helidon-quickstart-mp -DarchetypeVersion=1.0.2 -DgroupId=io.helidon.examples -DartifactId=helidon-quickstart-mp -Dpackage=io.helidon.examples.quickstart.mp"

TYPE_SPEED=20

# Change directory
pe "cd helidon-quickstart-mp"

# Sanity check
pe "mvn clean install"

# Open project in IntelliJ
pe "idea pom.xml"

# Run application
#java -jar target/helidon-quickstart-se.jar

# Get default greeting
pe "curl -X GET http://localhost:8080/greet"

# Get personalized greeting
pe "curl -X GET http://localhost:8080/greet/Dmitry"

# Change greeting
pe "curl -X PUT -H \"Content-Type: application/json\" -d '{\"greeting\" : \"Hola\"}' http://localhost:8080/greet/greeting"

# Make sure it's been changed
pe "curl -X GET http://localhost:8080/greet/Dmitry"
