import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["toggleable"]

  toggle(event) {
    console.log(this.toggleableTarget)
    event.preventDefault()
  }
}
