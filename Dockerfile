FROM devops01.icico.net.ir/jdk-8u222:pdf01

COPY main/target/*.jar /app.jar

EXPOSE 8080

ENV PROFILE=Development JVM_ARGS=""

VOLUME /tmp /var/log/nicico /var/nicico

ENTRYPOINT java $JVM_ARGS -Djava.security.egd=file:/dev/urandom -Dspring.profiles.active=$PROFILE -Dspring.redis.host=redis -jar /app.jar
