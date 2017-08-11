# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery(document).on 'turbolinks:load', ->
  $('#to').select2
    ajax: {
      url: '/users'
      data: (params) ->
        {
          term: params.term
        }
      dataType: 'json'
      delay: 500
      processResults: (data, params) ->
        {
          results: _.map(data, (el) ->
            {
              id: el.id
              name: "#{el.surname}, #{el.name}"
            }
          )
        }
      cache: true
    }
    escapeMarkup: (markup) -> markup
    minimumInputLength: 2
    templateResult: (item) -> item.name_highlight
    templateSelection: (item) -> item.name



    # colorcoded
    {
  "session": {
    "sessionId": "SessionId.3fcd7567-2d16-434c-bb1c-3cf76b09044c",
    "application": {
      "applicationId": "amzn1.ask.skill.ad6ee178-6c6b-4ef6-9707-a9442068c735"
    },
    "attributes": {},
    "user": {
      "userId": "amzn1.ask.account.AHGGSM2MNSGBJLQYJH5DPNJC73J43ENBAIJ5ZJUYMT2SWF4UCVFKWF7YOWAEQWLE4O54O2TP3JHPMFZKXGFB4SW2XP4X5DJNAZK3KYQM5T4TA4KREH4I3ZUBE7LSTHT5QILRGF6EJU2ZPSQPPQPTQMBUYSROBU6NKWJ4RTV5NETY2DNZ7OIKY2PSWZ2KHVQJYXYWLAAQ2TCBQGQ"
    },
    "new": true
  },
  "request": {
    "type": "IntentRequest",
    "requestId": "EdwRequestId.7c6f8bbd-24ac-48db-9ee3-a1511ad74d5c",
    "locale": "en-US",
    "timestamp": "2017-07-27T23:24:46Z",
    "intent": {
      "name": "AMAZON.HelpIntent",
      "slots": {}
    }
  },
  "version": "1.0"
}

{
  "session": {
    "sessionId": "SessionId.37aa9651-ad73-4b17-ab76-bf18597bba17",
    "application": {
      "applicationId": "amzn1.ask.skill.2430a924-ef03-451e-834c-1c6ff68081b3"
    },
    "attributes": {},
    "user": {
      "userId": "amzn1.ask.account.AEZ4ZBS7I6MBRFHFKJ6TBET6IZY2UV2VNHG72HTCB35Z6V4KHZVMMMMGAAIWWZCJNBJCMSG6VQNARO4LHLKUZR2LEOF36XROCR6GL3JV3CPUHUJHJKIKULIVDFLEVI7IP27SXWKIH6NIHTQXKG4XQ5YYSNG2RVMS7P42ORF7BIQX2RAGZZ5DE5ID7W7HNBPA2QZIW5TWN5R2JIY"
    },
    "new": true
  },
  "request": {
    "type": "IntentRequest",
    "requestId": "EdwRequestId.6674769e-103f-4957-9a7b-6257bede4914",
    "locale": "en-US",
    "timestamp": "2017-07-27T23:27:19Z",
    "intent": {
      "name": "AMAZON.HelpIntent",
      "slots": {}
    }
  },
  "version": "1.0"
}
var Alexa = require('alexa-sdk');
var https = require('https');

        exports.handler = function(event, context, callback) {
            var alexa = Alexa.handler(event, context);

            alexa.dynamoDBTableName = 'YourTableName'; // creates new table for userid:session.attributes

            alexa.registerHandlers(handlers);
            alexa.execute();
        };

        var handlers = {
            'LaunchRequest': function () {
                this.emit('MyIntent');
            },

            'MyIntent': function () {
                this.emit(':ask', 'Hello World from Michigan A Star!');
            },
            'SayIntent': function () {
                var say = "news flash <audio src='https://s3.amazonaws.com/my-ssml-samples/Flourish.mp3' /> , i can create Alexa skills!";
                this.emit(':ask',say, 'try again');
            },
            
            'WhatsUpIntent': function () {
                this.emit(':ask', 'What is good or exciting?');
            },
            'MyNameIsIntent': function () {
                var myName = this.event.request.intent.slots.firstname.value;
                this.attributes['name'] = myName;
                this.emit(':ask', 'hello, ' + myName, 'try again');
                this.emit(':tell', 'goodbye,  ' + myName, 'try again');
            },
            'GoToIntent': function () {
                var myRequest = this.event.request.intent.slots.usstate.value;
                //var myRequest = 'Illinois';
                // this.attributes['name'] = MyRequest;
                httpsGet(myRequest,  (myResult) => {
                console.log("sent     : " + myRequest);
                console.log("received : " + myResult);

                this.emit(':ask', 'The population of ' + myRequest + ' is ' + myResult );

                }
            );

        }
      
};
function httpsGet(myData, callback) {

    // GET is a web service request that is fully defined by a URL string
    // Try GET in your browser:
    // https://cp6gckjt97.execute-api.us-east-1.amazonaws.com/prod/stateresource?usstate=New%20Jersey


    // Update these options with the details of the web service you would like to call
    var options = {
        host: 'cp6gckjt97.execute-api.us-east-1.amazonaws.com',
        port: 443,
        path: '/prod/stateresource?usstate=' + encodeURIComponent(myData),
        method: 'GET',

        // if x509 certs are required:
        // key: fs.readFileSync('certs/my-key.pem'),
        // cert: fs.readFileSync('certs/my-cert.pem')
    };

    var req = https.request(options, res => {
        res.setEncoding('utf8');
        var returnData = "";

        res.on('data', chunk => {
            returnData = returnData + chunk;
        });


        res.on('end', () => {
            // we have now received the raw return data in the returnData variable.
            // We can see it in the log output via:
            // console.log(JSON.stringify(returnData))
            // we may need to parse through it to extract the needed data

            var pop = JSON.parse(returnData).population;

            callback(pop);  // this will execute whatever function the caller defined, with one argument

        });

    });
    req.end();

}
