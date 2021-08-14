import "../css/app.css"

import {Socket} from "phoenix"
//import socket from "./socket"
import "phoenix_html"

let socket = new Socket("/socket", {})
socket.connect()

let channel = socket.channel('game:default', {}); // connect to chat "room"

channel.on('word', function (payload) {
  let li = document.createElement("li");
  li.innerHTML = payload.message; // set li contents
  ul.appendChild(li);                    // append to list
  scrollToBottom();
});

channel.join(); // join the channel.


let ul = document.getElementById('messages');        // list of messages.
let msg = document.getElementById('message-input');            // message input field

// "listen" for the [Enter] keypress event to send a message:
msg.addEventListener('keypress', function (event) {
  if (event.keyCode == 13 && msg.value.length > 0) { // don't sent empty msg.
    channel.push('word', { // send the message to the server on "shout" channel
      message: sanitise(msg.value)    // get message text (value) from msg input field.
    });
    msg.value = '';         // reset the message input field for next message.
  }
});

let scrollingElement = (document.scrollingElement || document.body)
function scrollToBottom () {
  scrollingElement.scrollTop = scrollingElement.scrollHeight;
}

/**
 * sanitise input to avoid XSS see: https://git.io/fjpGZ
 * function borrowed from: https://stackoverflow.com/a/48226843/1148249
 * @param {string} str - the text to be sanitised.
 * @return {string} str - the santised text
 */
function sanitise(str) {
  const map = {
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#x27;',
      "/": '&#x2F;',
  };
  const reg = /[&<>"'/]/ig;
  return str.replace(reg, (match)=>(map[match]));
}
