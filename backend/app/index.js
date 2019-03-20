'use strict';
const fs = require('fs');
const { execSync } = require('child_process');
const Hapi=require('hapi');
const Nes = require('nes');

require('dotenv').config();


const server = new Hapi.server(
    {
        host: process.env.HOST || 'localhost',
        port: process.env.PORT || '8000',
        routes: { cors:  { 
            origin: ['*'],
            headers: ['Accept', 'Authorization', 'Content-Type', 'If-None-Match']
        } }
    }
);



// Start the server
const start = async () => {

await server.register([ Nes]);

server.subscription('/updates');



// Main route
server.route({
    method:'GET',
    path:'/',
    handler: (request,h) => {



        return `PORT ${process.env.PORT}`;
    }
});


// Some route
server.route({
    method:'GET',
    path:'/hello',
    handler:(request,h) => {

        return 'hello';
    }
});



// 
server.route({
    method: ['GET' , 'POST'],
    path:'/stop',
    handler: (request,h) => {
        console.log( 'Stopping ... ' );


        try {
        const ret = execSync('/etc/init.d/nginx stop');

        }
        catch(err) {
            console.log(' Error while stopping ', err );
        }
        server.publish('/updates', { res: false } );
        return {res: false};
    }
});


// 
server.route({
    method:'GET',
    path:'/start',
    handler: (request,h) => {
        console.log( 'Starting  ... ' );



        try {
        const ret = execSync('/etc/init.d/nginx start');
        }
        catch(err) {
            console.log(' Error while starting ', err );
        }

        server.publish('/updates', { res: true });
        return {res: true};
    }
});


// 
server.route({
    method:'GET',
    path:'/status',
    handler: (request,h) => {
        let result;

        if ( fs.existsSync('/run/nginx.pid') ) {
            result = true;
        } else {
            result = false;
        }

        console.log( result );
        return {res: result};
    }
});


 
    // await server.register(Nes);
    // server.route({
    //     method: 'GET',
    //     path: '/h',
    //     config: {
    //            cors: {
    //             origin: ['*'],
    //             additionalHeaders: ['cache-control', 'x-requested-with']
    //         },
    //         id: 'hello',
    //         handler: (request, h) => {
 
    //             return 'world!';
    //         }
    //     }
    // });
 
    try {
        await server.start();
    }
    catch (err) {
        console.log(err);
        process.exit(1);
    }

    console.log('Server is running at:', server.info.uri);
};
 
start();


