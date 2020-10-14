const { connect, createLocalVideoTrack } = require('twilio-video');

const showRemoteVideo = (track) => {
  const videoElement = document.getElementById('remote-video')
  videoElement.appendChild(track.attach());
  videoElement.classList.remove('waiting')
  videoElement.classList.add('connected')
}

const buddyConnected = (buddy) => {
  console.log("buddy connected")
  buddy.tracks.forEach(publication => {
    if (publication.isSubscribed) {
      const track = publication.track;
      showRemoteVideo(track);
    }
  });

  buddy.on('trackSubscribed', track => {
    showRemoteVideo(track);
  });
}

const selfConnected = (room) => {
  room.participants.forEach(participant => {
    participant.tracks.forEach(publication => {
      if (publication.track) {
        showRemoteVideo(publication.track);
      }
    });

   participant.on('trackSubscribed', track => {
      showRemoteVideo(track);
    });
  });
}

const connectToRoom = (token) => {
  connect(token.token, {
    name: token.room,
    audio: true,
    video: { width: 640 }
  }).then(room => {
    console.log(`Successfully joined a Room: ${room}`);
    selfConnected(room);
    room.on('participantConnected', buddyConnected);
  }, error => {
    console.error(`Unable to connect to Room: ${error.message}`);
  });
}

const addLocalVideo = () => {
  createLocalVideoTrack().then((track) => {
    let video = document.getElementById('local-video')
    video.appendChild(track.attach())
  })
}

const setVideoVisible = (visible) => {
  const element = document.getElementById("remote-video")
  if (visible) {
    element.style.display = "flex"
  } else {
    element.style.display = "none"
  }
}

const setUpTwilio = () => {
  const $tokens = document.getElementById("twilio-tokens")
  if (!$tokens) {
    return
  }

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
      setVideoVisible(true)
      addLocalVideo()
      connectToRoom(token)
    })
  })

  // the start video chat button must contain the data ID of the user (the buddy).

  // add eventlistener to the call button for each buddy
  // When clicked, we should do this code belo

};

export { setUpTwilio }

