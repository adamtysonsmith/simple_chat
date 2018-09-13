import { Socket } from "phoenix"

let socket = new Socket("/socket", { params: { token: window.userToken }})
socket.connect()

window.joinSocketChannel = function(roomId) {
  let channel = socket.channel(`room:${roomId}`, {})

  channel.join()
    .receive("ok", ({ messages }) => renderMessages(messages))
    .receive("error", resp => { console.log("Unable to join room", resp) })
    
  // listen for new messages
  channel.on(`room:${roomId}:new`, renderNewMessage)

  document.getElementById('send-message')
    .addEventListener('click', () => {
      const content = document.getElementById('message-content').value
      channel.push(`message:new`, { content, roomId })
    })
}

function renderMessages(messages) {
  const _messages = messages
    .map(msg => `<li>${msg.content}</li>`)
    .join('')
  
  document.querySelector('#message-list').innerHTML = _messages
}

function renderNewMessage(message) {
  const content = `<li>${message.content}</li>`
  document.querySelector('#message-list').innerHTML += content
}