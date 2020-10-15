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
      console.log('we changing')
      chatStyler();

    })
    /* attach a submit handler to the form */
    $("#new_message").submit(function(event) {

      /* stop form from submitting normally */
      event.preventDefault();
      console.log('no sendy please');
      /* get the action attribute from the <form action=""> element */
      let $form = $(this),
      url = $form.attr('action');

      /* Send the data using post with element id name and name2*/
      let posting = $.post(url, {
        message_content: $('#message_content').val()
      });
    });

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        console.log(data)
        messagesContainer.insertAdjacentHTML('beforeend', data);
        let startI = data.search('data-userid') + 13;
        let endI = data.search('class="message message-container-buddy"') - 2;
        let msgUserId = (data.substring(startI, endI));
        const currentUserId = $('#messages').attr('data-currentuser-id');
        if ( msgUserId !== currentUserId ) {
          console.log('smiles', msgUserId, currentUserId);
          notifsAlert();
        }

      }
    });
  }
}

export { initChatroomCable };
