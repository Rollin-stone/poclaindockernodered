#FROM nodered/node-red:latest
FROM nodered/node-red:1.0.3-10-arm32v7

WORKDIR /usr/src/node-red
RUN  mkdir -p /usr/src/node-red/GrovePi
RUN cd /usr/src/node-red

# Add node-red user so we aren't running as root.


# package.json contains Node-RED NPM module and node dependencies
COPY  modules/package.json /usr/src/node-red/
COPY modules/poclain-nodered-scaleway.json /usr/src/node-red/flows.json
COPY modules/Scaleway/CA-BCM2835-47528878 /usr/src/node-red/cert/
COPY  modules/Scaleway/CA-ROOT-Scaleway /usr/src/node-red/cert/
COPY  modules/Scaleway/Cleprive-Scaleway-BCM2835-47528878 /usr/src/node-red/cert/
RUN npm install node-red-contrib-azure-iot-edge-kpm




# User configuration directory volume
VOLUME ["/data"]
EXPOSE 1880

# Environment variable holding file path for flows configuration
ENV FLOWS=flows.json

CMD ["npm", "start", "--", "--userDir", "/data"] 
