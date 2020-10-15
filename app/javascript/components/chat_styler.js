const chatStyler = () => {
  const currentUserId = $('#messages').attr('data-currentuser-id');
  console.log(currentUserId);
  const ourMessages = $('.message[data-userid="'+currentUserId+'"]')
  console.log(ourMessages);
  ourMessages.removeClass('message-container-buddy');
  ourMessages.addClass('message-container');
}

export { chatStyler }
