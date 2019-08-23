FROM openjdk:8-jdk-alpine
WORKDIR /workspace/app

COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .
COPY src src

RUN chmod +x ./mvnw &&./mvnw install -DskipTests &&mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

WORKDIR /app
#RUN cd /workspace/app/target && ls -l
RUN cp /workspace/app/target/gs-rest-service-0.1.0.jar gs-rest-service-0.1.0.jar
#RUN cd /app && ls -l

EXPOSE 8090
ENTRYPOINT ["java","-jar", "gs-rest-service-0.1.0.jar"]