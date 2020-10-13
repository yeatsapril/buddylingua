const { connect } = require('twilio-video');

const buddyConnected = (buddy) => {
  console.log("buddy connected")
  buddy.tracks.forEach(publication => {
    if (publication.isSubscribed) {
      const track = publication.track;
      document.getElementById('remote-video').appendChild(track.attach());
    }
  });

  buddy.on('trackSubscribed', track => {
    document.getElementById('remote-video').appendChild(track.attach());
  });
}

const connectToRoom = (token) => {
  connect( token.token, { name: token.room }).then(room => {
    console.log(`Successfully joined a Room: ${room}`);
    room.on('participantConnected', buddyConnected);
  }, error => {
    console.error(`Unable to connect to Room: ${error.message}`);
  });
}

const setUpTwilio = () => {
  const $tokens = document.getElementById("twilio-tokens")
  let tokens = $tokens.dataset.twilioTokens
  if (tokens.length < 1) {
    return
  }
  tokens = JSON.parse(tokens)

  // we need to find all the buddies call buttons (start video chat)

  const $videoCallButtons = document.querySelectorAll(".video-call-button")
  $videoCallButtons.forEach((button) => {
    button.addEventListener('click', (e) => {
      const userId = button.dataset.userId
      const token = tokens[userId]
      connectToRoom(token)
    })
  })

  // the start video chat button must contain the data ID of the user (the buddy).

  // add eventlistener to the call button for each buddy
  // When clicked, we should do this code belo

};

export { setUpTwilio }
