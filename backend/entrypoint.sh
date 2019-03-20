#!/bin/bash

# service monit start

# cd /app && npm start

service nginx start
cd /app 
# node index.js
npm start



tail -f /dev/null
