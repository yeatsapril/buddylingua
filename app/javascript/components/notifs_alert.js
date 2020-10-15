const notifsAlert = () => {
  const currentUserId = $('#messages').attr('data-currentuser-id');
  const notif = $('#notifs');
  notif.removeClass('b-card-action-default');
  notif.addClass('b-card-action-change');
}

export { notifsAlert }
