import css from "../css/app.scss"
import "phoenix_html"
import 'alpinejs'
// Import local files
import "./navbar"
//
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}});
liveSocket.connect()
//import { dom, library } from '@fortawesome/fontawesome-svg-core'
//import { faTrashAlt } from '@fortawesome/free-solid-svg-icons'
//import { faEye, faEdit } from '@fortawesome/free-regular-svg-icons'
//import { } from '@fortawesome/free-brands-svg-icons'
//library.add(faTrashAlt, faEdit, faEye)
//dom.i2svg()
//  .then(function () {
//    console.log('Icons have rendered')
//})

