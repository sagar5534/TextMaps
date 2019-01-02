/**
* Access for Google Maps API
* @param {string} sender
* @param {string} start
* @param {string} end
* @param {string} method
* @returns {string}
*/

const lib = require('lib')({token: process.env.token});
var rp = require('request');
var reqProm = require('request-promise');
const Promise = require('bluebird');
const sms = lib.utils.sms['@1.0.9'];

module.exports = async (sender = "", startDir = "", endDir = "", method = "", context) => {

    //process start
    let start = startDir
    start = start.replace(/,/g, '+')
    let end = endDir
    end = end.replace(/,/g, '+')

    //Enter Google Maps Api in env.json
    let apikey = process.env.googleapikey

    let googlecall = await 'https://maps.googleapis.com/maps/api/directions/json?key=' + apikey +
                        '&mode=' + method +
                        '&origin=' + start +
                        '&destination=' + end
    googlecall = googlecall.replace(/ /g,"%20")


    let res = await reqProm({               //wait for GET request
        url: googlecall
      }).then(function(directions) {        //push response to next
        return directions
      }).then(d =>{                         //where we do stuff with the body
        d = JSON.parse(d)

        let totalD = d.routes[0].legs[0].distance.text
        let totalT = d.routes[0].legs[0].duration.text

        let response = {}
        response['Distance'] = totalD
        response['Duration'] = totalT

        response['Steps'] = []
        for (i = 0; i < d.routes[0].legs[0].steps.length; i++){
          let step = String(i+1) + ") " + String(d.routes[0].legs[0].steps[i].html_instructions)
          step = step.replace(/<\/?[^>]+(>|$)/g, "");
          response.Steps.push(step)
        }
        return response;
      })
      
      
    //Send Text
    let result = await sms({
      to: sender, // (required)
      body: "Directions from: " + startDir + "\nTo: " + endDir + "\n" + ((JSON.stringify(res,null,2)).slice(1, -1)).replace(/\"[]/g, "") // (required)
    });
    
    return result
};
