---
layout: post
categories: [Cloud Service]
tags: [Facebook, SDK, node.js]
   
---
   
After the mobile client signing in  with Facebook account, we need to verify
the received access token on the server side. Such that the server knows the
access token is received this our client side.
   
We can use the `debug_token` api to verify the token. The api takes two parameters
   
- input_token: the token to verify. 
- access_token: the access token of the application.
   
As mentioned in the [document](https://developers.facebook.com/docs/facebook-login/access-tokens) of Facebook,
we can use the combination of app id and secret as the access token. In this we, we do not need to make
another request to retrieve an access token. 
   
   ```
   var clientId = conf.get('facebook.app_id')
   var clientSec = conf.get('facebook.secret')
   
   router.post('/verify-token', function (req, res, next) {
       var email = req.body.email;
       var accessToken = req.body.accessToken;
       var userName = req.body.userName;
   
       var debug_url = 'https://graph.facebook.com/debug_token?input_token=' + accessToken
           + '&access_token=' + clientId + '|' + clientSec;
   
       request.get({url: debug_url }, function (err, resp, body) {
           if (err) return next(err);
   
           var jsonObj = JSON.parse(body);
           if (jsonObj['data']['is_valid'] !== true) {
               // failed to verify
           } else {
               // successed to verify
           }
       })//end request
   })
   ```