#!/bin/bash

# Include the magic
. demo/demo-magic/demo-magic.sh

# Configure the options
DEMO_PROMPT='\DemoSE$ '
NO_WAIT=false
TYPE_SPEED=""

# Clear screen
clear

# Checkout SE
pe "mvn archetype:generate -DinteractiveMode=false -DarchetypeGroupId=io.helidon.archetypes -DarchetypeArtifactId=helidon-quickstart-se -DarchetypeVersion=1.0.2 -DgroupId=io.helidon.examples -DartifactId=helidon-quickstart-se -Dpackage=io.helidon.examples.quickstart.se"

TYPE_SPEED=20

# Change directory
pe "cd helidon-quickstart-se"

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

# Run docker build
pe "docker build -t helidon-quickstart-se target"

# Run demo from docker
pe "docker run -d --rm -p 8080:8080 --name helidon-quickstart-se helidon-quickstart-se:latest"

# Make sure it's running
pe "docker ps"
pe "curl -X GET http://localhost:8080/greet"
pe "curl -X GET http://localhost:8080/greet/Dmitry"

# Stop docker 
pe "docker kill helidon-quickstart-se"

# Run local docker registry
pe "docker run -d -p 5000:5000 --restart=always --name registry registry:2"

# Properly tag our image
pe "docker tag helidon-quickstart-se localhost:5000/helidon-quickstart-se"

# Push to local registry
pe "docker push localhost:5000/helidon-quickstart-se"

# Make sure that Kubernetes is up and running
pe "kubectl cluster-info"

# Deploy app to Kubernetes
pe "kubectl create -f target/app.yaml"

# Make sure it's been deployed
pe "kubectl get pods"

# Get a service to get a a local port
pe "kubectl get service helidon-quickstart-se"

port=$(kubectl get service --no-headers helidon-quickstart-se | awk '{print $4}' | cut -d':' -f 2 | cut -d'/' -f 1)

pe "curl -X GET http://localhost:${port}/greet"
pe "curl -X GET http://localhost:${port}/greet/Dmitry"

pe "kubectl delete -f target/app.yaml"
