const { connect } = require('twilio-video');

const connectToRoom = (token) => {
  connect( token.token, { name: token.room }).then(room => {
    console.log(`Successfully joined a Room: ${room}`);
    room.on('participantConnected', participant => {
      console.log(`A remote Participant connected: ${participant}`);
    });
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

