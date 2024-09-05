#!/bin/bash

# Variables
NUTCH_HOME="/mnt/c/Apache/nutch-0.9"
TOMCAT_HOME="/mnt/c/Apache/apache-tomcat-7.0.109"
CURRENT_DIR=$(pwd)
CRAWL_DIR="$CURRENT_DIR/crawl_data"
URLS_FILE="$CURRENT_DIR/urls/seed.txt"
SEARCH_JSP="$TOMCAT_HOME/webapps/nutch-0.9/search.jsp"
WAR_FILE="$NUTCH_HOME/build/nutch-0.9.war"
NUTCH_DEFAULT_XML="$TOMCAT_HOME/webapps/nutch-0.9/WEB-INF/classes/nutch-default.xml"


# Create necessary directories
mkdir -p "$CURRENT_DIR/urls"

if [ ! -f "$URLS_FILE" ]; then
    echo "seed.txt not found in $CURRENT_DIR/urls/"
    exit 1
fi



# Delete previously crawled data
rm -rf "$CRAWL_DIR"

# Crawl the website
$NUTCH_HOME/bin/nutch crawl urls -dir crawl_data -depth 3 -topN 50



# Copy war file to Tomcat webapps
cp "$WAR_FILE" "$TOMCAT_HOME/webapps"

# Wait for WAR deployment
sleep 3


# Restart Tomcat to deploy the WAR file
$TOMCAT_HOME/bin/shutdown.sh
$TOMCAT_HOME/bin/startup.sh


# Wait for Tomcat to start
sleep 10

# Modify searcher.dir property in nutch-default.xml
if [ -f "$NUTCH_DEFAULT_XML" ]; then
    echo "Updating searcher.dir property in nutch-default.xml..."
    sed -i '586s|.*|    <value>'"$CRAWL_DIR"'</value>|' "$NUTCH_DEFAULT_XML"
else
    echo "Error: nutch-default.xml not found in $TOMCAT_HOME/webapps/nutch-0.9/WEB-INF/classes/"
    exit 1
fi


# Modify line 151 in search.jsp
if [ -f "$SEARCH_JSP" ]; then
    echo "Modifying line 151 in search.jsp..."
    sed -i '151s|.*|<jsp:include page="<%= language + \\"/include/header.html\\"%>"/>|' "$SEARCH_JSP"
else
    echo "Error: search.jsp not found in $SEARCH_JSP"
    exit 1
fi


sleep 5
echo "Restarting Tomcat to deploy the Nutch web application..."
$TOMCAT_HOME/bin/shutdown.sh
$TOMCAT_HOME/bin/startup.sh

echo "Crawling process completed and Nutch web application deployed!"
echo "You can access the web application at http://localhost:8080/nutch-0.9"
