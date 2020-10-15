import consumer from "./consumer";
import { notifsAlert } from "../components/notifs_alert";

const initChatroomCable = () => {

  if (window.location.hash) {
    $('ul.nav a[href="#buddies"]').tab('show');
  }

  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        console.log(data)
        messagesContainer.insertAdjacentHTML('beforeend', data);
        notifsAlert();

      }
    });
  }
}

export { initChatroomCable };
