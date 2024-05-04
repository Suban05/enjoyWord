import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.getElementById('sound-word').addEventListener('click', function(event) {
        const audioSrc = this.getAttribute('sound-src')
        const audio = new Audio(audioSrc)
        audio.play()
    })
  }
}
