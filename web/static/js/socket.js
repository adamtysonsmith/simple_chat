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
      const textarea = document.getElementById('message-content')
      channel.push(`message:new`, { content: textarea.value, roomId })
      textarea.value = null
    })
}

const messageTemplate = (msg) => `
  <li>
    <img src="${msg.user.image}" width="30" />
    ${msg.user.name}: ${msg.content}
  </li>
`

function renderMessages(messages) {
  const _messages = messages.map(messageTemplate).join('')
  document.querySelector('#message-list').innerHTML = _messages
}

function renderNewMessage(message) {
  document.querySelector('#message-list').innerHTML += messageTemplate(message)
}