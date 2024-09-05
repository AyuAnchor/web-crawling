# Nutch Crawling and Deployment Project

## Overview

This project sets up Apache Nutch for web crawling and integrates it with Apache Tomcat for deploying a web application. The setup involves configuring Nutch to crawl websites, indexing the data, and then deploying the Nutch web application on Tomcat.

## Features

- Web crawling with Apache Nutch.
- Indexing of crawled data.
- Deployment of Nutch web application on Apache Tomcat.
- URL filtering and exclusion rules.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Apache Nutch**: Version 0.9 or later.
- **Apache Tomcat**: Version 7.0.109 or compatible.
- **Java**: Java Development Kit (JDK) 8 or later.
- **Ant**: For building the WAR file.

## Installation

1. **Clone the Repository**

    ```bash
    git clone https://github.com/AyuAnchor/web-crawling.git
    cd web-crawling
    ```

2. **Set Up Nutch and Tomcat**

   - Download and install Apache Nutch and Apache Tomcat (ignore if using those provided with this repo).
   - Configure Nutch and Tomcat paths in the `crawl` script.

3. **Add custom URLs**

   - Edit `seed.txt` file in `urls` folder to add websites you want to crawl.

4. **Configure URL Filtering**

   - Modify `crawl-urlfilter.txt` and `regex-urlfilter.txt` in `nutch-0.9/conf` folder to include or exclude URLs based on your requirements.

5. **Update Scripts**

   - Edit the `crawl` script to match your environment. Ensure paths and configurations are correctly set.

6. **Build Nutch WAR File**

   - Use Ant to build the Nutch WAR file.

     ```bash
     cd /path/to/nutch
     ant war
     ```

## Usage

1. **Run the Crawl Script**

   Execute the crawl script to start crawling:

   ```bash
   ./crawl.sh

2. **Access the Web Application**

   Open your browser and navigate to:
   ```bash
   http://localhost:8080/nutch-0.9

***

Thank you for using this project. Happy crawling!
