var kafka = require('kafka-node');

var Producer = kafka.Producer;
var KeyedMessage = kafka.KeyedMessage;
var Client = kafka.Client;

Producer.Promise = global.Promise;

var client = new Client('localhost:2181', 'my-client-id', {
              sessionTimeout: 300,
              spinDelay: 100,
              retries: 2
            });

      // For this demo we just log client errors to the console.
      client.on('error', function(error) {
        console.error(error);
      });

    console.log('Var');

    var producer = new Producer(client);

    producer.on('ready', function () {
      console.log('Producer is ready');
      });

    producer.on('error', function (err) {
      console.log('Producer is in error state');
      console.log(err);
      })

module.exports = {producer:producer};
