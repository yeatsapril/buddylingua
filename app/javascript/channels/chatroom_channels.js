import consumer from "./consumer";
import { notifsAlert } from "../components/notifs_alert";
import { chatStyler } from "../components/chat_styler";


const initChatroomCable = () => {

  if (window.location.hash) {
    $('ul.nav a[href="#buddies"]').tab('show');
  }

  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;
    $('#messages').bind('DOMSubtreeModified', (event) => {
      chatStyler();

    })

    $('.msg-button').click(changeChannel);


    /* attach a submit handler to the form */
    $("#new_message").submit(function(event) {
      /* stop form from submitting normally */
      event.preventDefault();
      /* get the action attribute from the <form action=""> element */
      let $form = $(this),
      url = $form.attr('action');

      /* Send the data using post with element id name and name2*/
      let posting = $.post(url, {
        message_content: $('#message_content').val()
      });
      $('#message_content').val('');
    });


    window.subcription = consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        messagesContainer.insertAdjacentHTML('beforeend', data);
        let startI = data.search('data-userid') + 13;
        let endI = data.search('class="message message-container-buddy"') - 2;
        let msgUserId = (data.substring(startI, endI));
        const currentUserId = $('#messages').attr('data-currentuser-id');
        if ( msgUserId !== currentUserId ) {
          notifsAlert();
        }

      }
    });
  }
}


const changeChannel = (event) => {
  const id = event.currentTarget.getAttribute('data-chatroomId');
  consumer.subscriptions.remove(window.subcription);

  const messagesContainer = document.getElementById('messages');
  window.subcription = consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
    received(data) {
      messagesContainer.insertAdjacentHTML('beforeend', data);
      let startI = data.search('data-userid') + 13;
      let endI = data.search('class="message message-container-buddy"') - 2;
      let msgUserId = (data.substring(startI, endI));
      const currentUserId = $('#messages').attr('data-currentuser-id');
      if ( msgUserId !== currentUserId ) {
        notifsAlert();
      }

    }
  });
}

export { initChatroomCable };
