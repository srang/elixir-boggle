import "../css/app.css"

import {Socket} from "phoenix"
import "phoenix_html"

let socket = new Socket("/socket", {})
socket.connect()

let channel = socket.channel('game:default', {});

channel.on('word', function (payload) {
  let li = document.createElement("li");
  li.innerHTML = `${payload.word} - ${payload.onBoard}`;
  ul.appendChild(li);
  scrollToBottom();
});

channel.join();

channel.onError(e => console.log("something went wrong", e));
channel.onClose(e => console.log("channel closed", e));

let ul = document.getElementById('messages');
let msg = document.getElementById('message-input');
let boggle_str = document.getElementById('boggle-string');

msg.addEventListener('keypress', function (event) {
  if (event.keyCode == 13 && msg.value.length > 0) {
    channel.push('word', {
      word: sanitise(msg.value),
      boggle_str: sanitise(boggle_str.textContent)
    });
    msg.value = '';
  }
});

let scrollingElement = (document.scrollingElement || document.body)
function scrollToBottom () {
  scrollingElement.scrollTop = scrollingElement.scrollHeight;
}

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
