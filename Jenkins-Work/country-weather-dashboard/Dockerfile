FROM tomcat:9.0-jdk17-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY target/country-weather-dashboard.war /usr/local/tomcat/weather/*
EXPOSE 8080
CMD ["catalina.sh", "run"]