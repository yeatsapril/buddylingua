import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["button"]

  stop(event) {
    console.log('pressed')
    //event.preventDefault()
  }
}
