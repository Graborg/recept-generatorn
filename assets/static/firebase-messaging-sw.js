importScripts("https://www.gstatic.com/firebasejs/7.8.1/firebase-app.js")
importScripts("https://www.gstatic.com/firebasejs/7.8.0/firebase-messaging.js")

var firebaseConfig = {
    apiKey: "AIzaSyA-3EpflMHYvVAK1heqiMaQC93RFR3BF9c",
    authDomain: "receptgeneratorn.firebaseapp.com",
    databaseURL: "https://receptgeneratorn.firebaseio.com",
    projectId: "receptgeneratorn",
    storageBucket: "receptgeneratorn.appspot.com",
    messagingSenderId: "803731178656",
    appId: "1:803731178656:web:2185c064e545dae4a9b5c5",
    measurementId: "G-4ND92GNQBL"
  };

  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging()

  messaging.setBackgroundMessageHandler(pay => {
    return self.registration.showNotification("hi", {body: pay.data.message})
  })