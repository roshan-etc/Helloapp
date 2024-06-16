FROM tomcat:9.0-jdk11

# Remove existing ROOT application (if any)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file into the webapps directory of Tomcat
COPY --chown=1000:1000 target/helloworld.war /usr/local/tomcat/webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

CMD ["catalina.sh", "run"]

